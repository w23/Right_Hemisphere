#!/usr/bin/env python3
import json
import sys
import re
import argparse

parser = argparse.ArgumentParser(description='Convert envelopster export into buildable intro sources')
parser.add_argument('--automation', type=argparse.FileType('w'), default='automation.c', help='Output automation file (c/asm)')
parser.add_argument('--shader', type=argparse.FileType('w'), default='shader.glsl', help='Output shader file (glsl)')
parser.add_argument('--verbose', action='store_true', help='Be verbose')
parser.add_argument('--printf', action='store_true', help='Add printf to debug envelope unpacking')
parser.add_argument('--printf2', action='store_true', help='Add even more printf to debug envelope unpacking')
#parser.add_argument('--vprec', choices=['df32', 'du16'], default='df32', help='Precision and type of packing for stored values')
#parser.add_argument('--tprec', choices=['df32', 'du16'], default='df32', help='Precision and type of packing for stored times')
parser.add_argument('--noshort', action='store_true', help='Don\'t rename uniforms')
parser.add_argument('--precision', type=int, default=7, help='Digits to preserve after floating point')
parser.add_argument('input', type=argparse.FileType('r'), help='Input intro.txt file (json)')
args = parser.parse_args()

source = json.load(args.input)
shader = source['fragment']
uniforms = source['variables']

shader = shader.replace('precision highp float;', '').replace('varying vec2 coordVar;', '').replace('coordVar', '(gl_FragCoord.xy/vec2(1920.,1080.))')

out_format = 'c' if args.automation.name.endswith('.c') or args.automation.name.endswith('.h') else 'nasm' if args.automation.name.endswith('.asm') or args.automation.name.endswith('.inc') else 'glsl' if args.automation.name.endswith('glsl') else None

print(out_format)

class ArrayDeltaF32:
    def __init__(self, name, values):
        self.name = name
        self.type = 'float'
        self.values = []
        pv = 0
        for v in values:
            self.values.append(v - pv)
            pv = v

def writeArrayC(array):
    out = '#pragma data_seg(\".{}\")\n'.format(array.name)
    out += 'static const {} {}[] = {{\n'.format(array.type, array.name)
    for v in array.values:
        out += '\t{},\n'.format(v)
    return out + '};\n\n'

def writeArrayNasm(array):
    if array.type == 'float':
        prefix = 'dd'
    out = 'section _{} data align=1\n{}:\n'.format(array.name,array.name)
    for v in array.values:
        out += '\t{} {},\n'.format(prefix, v)
    return out + '\n'


"""
def writeArrayDeltaF32(name, values):
    out = '#pragma data_seg(\".{}\")\n'.format(name)
    out += 'static const float {}[] = {{\n'.format(name)
    pv = 0
    for v in values:
        out += '\t{},\n'.format(v - pv)
        pv = v
    args.automation.write(out + '};\n\n')

def writeArrayDeltaU16(name, values):
    base = min(values)
    delta = max(values) - base
    out = '#pragma data_seg(\".{}\")\n'.format(name)
    out += '#define {}_base {:.7f}\n'.format(name, base)
    out += '#define {}_delta {:.7f}\n'.format(name, delta)
    out += 'static const unsigned short {}[] = {{\n'.format(name)
    pv = 0
    for v in values:
        vu16 = int((v - base) / delta * 65535.0)
        out += '\t{},\n'.format((vu16 - pv) & 0xffff)
        pv = vu16
    args.automation.write(out + '};\n\n')
""" and None

#writeTimes = None
#if args.tprec == 'df32':
arrayTimes = ArrayDeltaF32
#elif args.tprec == 'du16':
#    writeTimes = writeArrayDeltaU16


#writeValues = None
#if args.vprec == 'df32':
arrayValues = ArrayDeltaF32
#elif args.vprec == 'du16':
    #writeValues = writeArrayDeltaU16

class Uniform:
    def __init__(self, name, data):
        frames = data['frames']
        ktimes = []
        values = []
        base = data['min']
        delta = data['max'] - base
        times = sorted([(float(t),  base + delta * v) for t, v in frames.items()], key=lambda x:x[0])
        if args.verbose:
            print(name, times)
        if times[0][0] != 0:
            pv = times[0][1]
            ktimes.append(0)
            values.append(pv)
        for tv in times:
            ktimes.append(tv[0] / 30.0)
            values.append(tv[1])
        if args.verbose:
            print(name, ktimes, values)

        self.name = name
        self.length = len(ktimes)

        self.times = arrayTimes("udtimes_" + name, ktimes)
        self.values = arrayValues("udvalues_" + name, values)

        if out_format == 'c':
            args.automation.write(writeArrayC(self.times) + writeArrayC(self.values))
        elif out_format == 'nasm':
            args.automation.write(writeArrayNasm(self.times) + writeArrayNasm(self.values))

uniforms = [Uniform(k, v) for k, v in uniforms.items()]

if out_format == 'c':
    reader_C = '#pragma code_seg(".setUniform")\n'
    if True: #args.vprec == 'df32':
        reader_C += 'static void setUniform(GLuint prog, const char *name, float t, const float *dtimes, const float *dvalues, int len) {\n'
        if args.printf2:
            reader_C += 'printf("\\n%s:\\n", name);'
        reader_C += """
        float pv = 0.f;
        for (int j = 0; j < len; ++j) {
            const float dt = dtimes[j], dv = dvalues[j];
    """
        if args.printf2:
            reader_C += 'printf("\\t[t=%.3f dt=%.3f pv=%.3f dv=%.3f]\\n", t, dt, pv, dv);'
        reader_C += """
            if (dt >= t) {
                t /= dt;
                pv += dv * t;
                break;
            }
            pv += dv;
            t -= dt;
        }
    """
    elif False: #args.vprec == 'du16':
        reader_C += 'static void setUniform(GLuint prog, const char *name, float t, const float *dtimes, const unsigned short *dvalues, float vbase, float vdelta, int len) {\n'
        if args.printf2:
            reader_C += 'printf("\\n%s:\\n", name);'
        reader_C += """
        unsigned short puv = 0;
        float pv = 0.f;
        for (int j = 0; j < len; ++j) {
            const float dt = dtimes[j];
            const unsigned short uv = puv + dvalues[j];
            const float v = vbase + uv * vdelta / 65535.f;
            const float dv = v - pv;
    """
        if args.printf2:
            reader_C += 'printf("\\t[t=%.3f dt=%.3f pv=%.3f dv=%.3f]\\n", t, dt, pv, dv);'
        reader_C += """
            if (dt >= t) {
                t /= dt;
                pv += dv * t;
                break;
            }
            puv = uv;
            pv = v;
            t -= dt;
        }
    """
    if args.printf:
        reader_C += 'printf("%s=%.3f\\n", name, pv);'
    reader_C += 'oglUniform1f(oglGetUniformLocation(prog, name), pv);\n}\n'
    args.automation.write(reader_C)
elif out_format == 'nasm':
    read_nasm = '''
%macro SET_UNIFORM 4 ; 1 -- count, 2 -- dtimes, 3 -- dvalues, 4 -- name
    mov ecx, %1
    mov eax, %2
    mov ebx, %3
    fldz ; st0 = v=0, st1 = t
loop:
    fld dword ptr [ebx] ; st0 = dv, st1 = v, st2 = t
    fxch 2 ; st0 = t, st1 = v, st2 = dv
    fld dword ptr [eax] ; dt, t, v, dv
    fcomi
    jb cont; dt < t
    fdiv ; t/dt, v, dv
    FIXME
    jmp end:
    FIXME
cont:
    FIXME
end:
    FIXME
%endmacro
'''
elif out_format == 'glsl':
    head = None
    #count = 0
    #for u in uniforms:
        #count = max(count, len(u.times.values))
    tl = ''

    patch = {}
    seq = 0

    min_trailing_zeros = re.compile('0*$')
    min_leading_zeros = re.compile('0(\.[0-9])')
    minifmt = '{:.' + '{}'.format(args.precision) + 'f}'
    def miniFloat(f):
        return min_leading_zeros.sub('\\1', min_trailing_zeros.sub('', minifmt.format(f)))

    #tl = '\tfloat T, v;\n'
    #tl += '#define Q(a,b) if(T<a){v+=T*b/a;break;}T-=a;v+=b\n'
    #tl += '#define Q(a,b) if(T<=a)v+=t*b/a;T-=a;v+=b\n'
    for u in uniforms:
        if not head:
            head = 'float ' + u.name
        else:
            head += ', ' + u.name

        #tl += '\tT=t;{}=0.;\n\t'.format(u.name)
        #tl += '\tfor(int i=0;i<1;++i){\n\tfloat T=t,v=0.,dt,dv;\n'#.format(u.name)

        count = len(u.times.values)
        tl += '\t{{\n\t\tfloat T=t,v=0.,dtt[{0}]=DTT{1}_,dvt[{0}]=DVT{1}_;'.format(count, seq)
        #tl += '/*\t{{\n\t\tfloat T=t,v=0.,dtt[{0}]=float[]('.format(count)
        #tl += '/*\t{{\n\t\t"float g=s,o=0.,u[{0}]=float[]('.format(count)
        sep = ''
        dtt = 'float[]('
        for v in u.times.values:
            #dtt += min_leading_zeros.sub('\1', minify.sub('', '{}{:.7f}'.format(sep, v)))
            dtt += sep + miniFloat(v)
            sep = ','
        dtt += ')'

        #tl += '),dvt[{0}]=float[]('.format(count)
        #tl += '),h[{0}]=float[]('.format(count)
        dvt = 'float[]('
        sep = ''
        for v in u.values.values:
            #dvt += min_leading_zeros.sub('\1', minify.sub('', '{}{:.7f}'.format(sep, v)))
            dvt += sep + miniFloat(v)
            sep = ','
        dvt += ')'

        patch['DTT{}_'.format(seq)] = dtt
        patch['DVT{}_'.format(seq)] = dvt

        seq += 1

        #tl += ''');'\n
        tl += '''
        for (int i = 0; i < {1}; ++i) {{
            //float dt = dt{0}[i], dv = dv{0}[i];
            if (T < dtt[i]) {{
                v += dvt[i] * T / dtt[i];
                break;
            }}
            v += dvt[i];
            T -= dtt[i];
        }}
        {0} = v;
    }}
'''.format(u.name, count)

        '''
                for i in range(count):
                    dt = '{:.3f}'.format(u.times.values[i])
                    dv = '{:.3f}'.format(u.values.values[i])
                    #tl += '\tif(T<={0})v+=T*{1}/{0};else{{T-={0};v+={1};\n'.format(dt, dv)
                    tl += '\t\tdt={};dv={};if(T<dt){{v+=T*dv/dt;break;}}T-=dt;v+=dv;\n'.format(dt, dv)
                    #tl += '\t\tQ({:.3f}, {:.3f});\n'.format(u.times.values[i], u.values.values[i])
                tl += '\t\t{} = v;\n\t}}'.format(u.name)
        ''' and None

    json.dump(patch, args.automation)

    #tl += '\t}\n'

    shader = re.sub('uniform[a-zA-Z0-9\s,]*;', 'uniform float t;\n' + head + ';\n', shader, 0, re.MULTILINE)
    shader = '#version 120\n' + shader
    shader = re.sub('void main\(\)\s*{', 'void main() {\n' + tl, shader, 0, re.MULTILINE)

print('Writing shader into {}...'.format(args.shader.name))
args.shader.write(shader)

if out_format == 'c':
    args.automation.write('static __forceinline void setUniforms(GLuint prog, float t) {\n')
    if args.printf:
        args.automation.write('\tprintf("\\n%.3f ", t);\n')
    for u in uniforms:
        if True: #args.vprec == 'df32':
            uniform_name = '"{}"'.format(u.name) if args.noshort else 'VAR_' + u.name.upper()
            args.automation.write('\tsetUniform(prog, {}, t, udtimes_{}, udvalues_{}, {});\n'.format(uniform_name, u.name, u.name, u.length))
        #elif args.vprec == 'du16':
         #   args.automation.write(
          #      '\tsetUniform(prog, {}, t, udtimes_{}, udvalues_{}, udvalues_{}_base, udvalues_{}_delta, {});\n'.format(u.uniform_name, u.name, u.name, u.name, u.name, u.length))
    args.automation.write('}\n')
