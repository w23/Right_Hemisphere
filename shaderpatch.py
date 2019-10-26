#!/usr/bin/env python3
import json
import re
import argparse

parser = argparse.ArgumentParser(description='Patch minified shader')
parser.add_argument('--patch', required=True, help='Minified file to patch')
parser.add_argument('input', type=argparse.FileType('r'), help='Patch data (json)')
args = parser.parse_args()

shader = open(args.patch, 'r').read()

patch = json.load(args.input)

for k, v in patch.items():
    shader = shader.replace(k, v)

open(args.patch, 'w').write(shader)
