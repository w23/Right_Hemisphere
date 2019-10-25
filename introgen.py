#!/usr/bin/env python3
import json
import sys
import re
import argparse

parser = argparse.ArgumentParser(description='Convert envelopster export into buildable intro sources')
parser.add_argument('--automation', type=argparse.FileType('w'), default='automation.c', help='Output automation file (c)')
parser.add_argument('--shader', type=argparse.FileType('w'), default='shader.glsl', help='Output shader file (glsl)')
parser.add_argument('--verbose', action='store_true', help='Be verbose')
parser.add_argument('--printf', action='store_true', help='Add printf to debug envelope unpacking')
parser.add_argument('--printf2', action='store_true', help='Add even more printf to debug envelope unpacking')
#parser.add_argument('--vprec', choices=['df32', 'du16'], default='df32', help='Precision and type of packing for stored values')
#parser.add_argument('--tprec', choices=['df32', 'du16'], default='df32', help='Precision and type of packing for stored times')
parser.add_argument('--noshort', action='store_true', help='Don\'t rename uniforms')
parser.add_argument('input', type=argparse.FileType('r'), help='Input intro.txt file (json)')
args = parser.parse_args()

source = json.load(args.input)
shader = source['fragment']
uniforms = source['variables']

shader = shader.replace('precision highp float;', '').replace('varying vec2 coordVar;', '').replace('coordVar', '(gl_FragCoord.xy/vec2(1920.,1080.))')

args.shader.write(shader)

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
        self.uniform_name = '"{}"'.format(name) if args.noshort else 'VAR_' + name.upper()
        self.length = len(ktimes)

        self.times = arrayTimes("udtimes_" + name, ktimes)
        self.values = arrayValues("udvalues_" + name, values)

        args.automation.write(writeArrayC(self.times) + writeArrayC(self.values))

uniforms = [Uniform(k, v) for k, v in uniforms.items()]

reader_C = '#pragma code_seg(".setUniform")\n'

if True: #args.vprec == 'df32':
    reader_C += """
static void setUniform(GLuint prog, const char *name, float t, const float *dtimes, const float *dvalues, int len) {
"""

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
    reader_C += """
static void setUniform(GLuint prog, const char *name, float t, const float *dtimes, const unsigned short *dvalues, float vbase, float vdelta, int len) {
"""

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

reader_C += """
    oglUniform1f(oglGetUniformLocation(prog, name), pv);
}
"""

args.automation.write(reader_C)

args.automation.write('static __forceinline void setUniforms(GLuint prog, float t) {\n')
if args.printf:
    args.automation.write('\tprintf("\\n%.3f ", t);\n')
for u in uniforms:
    if True: #args.vprec == 'df32':
        args.automation.write('\tsetUniform(prog, {}, t, udtimes_{}, udvalues_{}, {});\n'.format(u.uniform_name, u.name, u.name, u.length))
    #elif args.vprec == 'du16':
     #   args.automation.write(
      #      '\tsetUniform(prog, {}, t, udtimes_{}, udvalues_{}, udvalues_{}_base, udvalues_{}_delta, {});\n'.format(u.uniform_name, u.name, u.name, u.name, u.name, u.length))
args.automation.write('}\n')
