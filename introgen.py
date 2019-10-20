#!/usr/bin/env python3
import json
import sys
import re
import argparse

parser = argparse.ArgumentParser(description='Convert envelopster export into buildable intro sources')
parser.add_argument('--automation', type=argparse.FileType('w'), default='automation.c', help='Output automation file (c)')
parser.add_argument('--shader', type=argparse.FileType('w'), default='shader.glsl', help='Output shader file (glsl)')
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
    pt = 0
    pv = 0
    times = sorted([(float(t), v) for t, v in frames.items()], key=lambda x:x[0])
    for tv in times:
        t = tv[0] / 30.0
        v = tv[1]
        assert(t >= pt)
        dtimes.append(t - pt)
        dvalues.append(v - pv)
        pt = t
        pv = v
    names.append(k)
    lengths.append(len(frames))
    writeArray("udtimes_" + k, dtimes)
    writeArray("udvalues_" + k, dvalues)

reader_C = """
#pragma code_seg(".setUniform")
static void setUniform(GLuint prog, const char *name, float t, const float *dtimes, const float *dvalues, int len) {
    float pv = 0.f;
    for (int j = 0; j < len; ++j) {
        const float dt = dtimes[j], dv = dvalues[j];
        if (dt >= t) {
            t /= dt;
            pv += dv * t;
            break;
        }
        pv += dv;
        t -= dt;
    }
    //printf("%s %.3f\t", name, pv);
    oglUniform1f(oglGetUniformLocation(prog, name), pv);
}
"""
args.automation.write(reader_C)

args.automation.write('static __forceinline void setUniforms(GLuint prog, float t) {/*printf("\\n%.3f", t);*/\n')
for i, n in enumerate(names):
    args.automation.write('\tsetUniform(prog, "{}", t, udtimes_{}, udvalues_{}, {});\n'.format(n,n,n,lengths[i]))
args.automation.write('}\n')
