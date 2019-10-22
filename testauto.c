#include <stdio.h>
#include <stdlib.h>

typedef unsigned int GLuint;
#define __forceinline

void oglUniform1f(const char *name, float v) {
	printf(" %s=%.3f", name, v);
}

const char *oglGetUniformLocation(int _, const char* name) { (void)_; return name; }

#include "automation.c"

void main(int argc, char *argv[]) {
	const float t = atof(argv[1]);
	printf("t=%.3f", t);
	setUniforms(0, t);
	printf("\n");
}
