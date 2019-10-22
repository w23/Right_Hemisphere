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
parser.add_argument('input', type=argparse.FileType('r'), help='Input intro.txt file (json)')
args = parser.parse_args()

source = json.load(args.input)
shader = source['fragment']
uniforms = source['variables']

shader = shader.replace('precision highp float;', '').replace('varying vec2 coordVar;', 'uniform vec2 R_;').replace('coordVar', '(gl_FragCoord.xy/R_)')

args.shader.write(shader)

names = []
lengths = []

def writeArray(name, dvalues):
    args.automation.write('#pragma data_seg(\".{}\")\n'.format(name))
    args.automation.write('static const float {}[] = {{\n'.format(name))
    for v in dvalues:
        args.automation.write('\t{},\n'.format(v))
    args.automation.write('};\n\n')

for k, v in uniforms.items():
    frames = v['frames']
    dtimes = []
    dvalues = []
    a = v['min']
    b = v['max']
    times = sorted([(float(t),  a + (b-a) * v) for t, v in frames.items()], key=lambda x:x[0])
    if args.verbose:
        print(k, times)
    pt = 0
    pv = 0
    if times[0][0] != 0:
        pv = times[0][1]
        dtimes.append(0)
        dvalues.append(pv)
    for tv in times:
        t = tv[0] / 30.0
        v = tv[1]
        assert(t >= pt)
        dtimes.append(t - pt)
        dvalues.append(v - pv)
        pt = t
        pv = v
    if args.verbose:
        print(k, dtimes, dvalues)
    names.append(k)
    lengths.append(len(dtimes))
    writeArray("udtimes_" + k, dtimes)
    writeArray("udvalues_" + k, dvalues)

reader_C = """
#pragma code_seg(".setUniform")
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
for i, n in enumerate(names):
    args.automation.write('\tsetUniform(prog, "{}", t, udtimes_{}, udvalues_{}, {});\n'.format(n,n,n,lengths[i]))
args.automation.write('}\n')
