#pragma data_seg(".udtimes_Fade")
static const float udtimes_Fade[] = {
	0.0,
	11.0,
	124.69999999999999,
	10.300000000000011,
	325.0,
	9.0,
};

#pragma data_seg(".udvalues_Fade")
static const float udvalues_Fade[] = {
	0,
	1,
	0,
	-1,
	1,
	-1,
};

#pragma data_seg(".udtimes_shift11")
static const float udtimes_shift11[] = {
	3.0,
	27.0,
	90.0,
};

#pragma data_seg(".udvalues_shift11")
static const float udvalues_shift11[] = {
	1,
	-0.7107692307692308,
	0.2615384615384616,
};

#pragma data_seg(".udtimes_zoomshift")
static const float udtimes_zoomshift[] = {
	96.0,
	0.03333333333333144,
	0.9666666666666686,
	15.0,
	0.29999999999999716,
	0.20000000000000284,
	0.1666666666666714,
	0.19999999999998863,
	0.13333333333333997,
	7.0,
};

#pragma data_seg(".udvalues_zoomshift")
static const float udvalues_zoomshift[] = {
	0.3417721518987341,
	0.569367088607595,
	-0.006523855890944508,
	-0.5628432327166505,
	0.37855513516751194,
	-0.0310528391167193,
	0.015772870662460692,
	-0.012618296529968487,
	0.003154574132492094,
	-0.2019127101385617,
};

#pragma data_seg(".udtimes_steps")
static const float udtimes_steps[] = {
	96.0,
	0.03333333333333144,
};

#pragma data_seg(".udvalues_steps")
static const float udvalues_steps[] = {
	0.5,
	-0.5,
};

#pragma data_seg(".udtimes_greyscale")
static const float udtimes_greyscale[] = {
	96.0,
	0.03333333333333144,
};

#pragma data_seg(".udvalues_greyscale")
static const float udvalues_greyscale[] = {
	0,
	1,
};

#pragma data_seg(".udtimes_greyscale2")
static const float udtimes_greyscale2[] = {
	104.0,
	0.03333333333333144,
	0.7000000000000028,
	3.2666666666666657,
	4.0,
	0.23333333333333428,
	0.09999999999999432,
	3.3666666666666742,
	4.299999999999997,
};

#pragma data_seg(".udvalues_greyscale2")
static const float udvalues_greyscale2[] = {
	0,
	0.8501577287066246,
	-0.41955835962145116,
	-0.20189274447949523,
	-0.018927444794952675,
	0.19873817034700314,
	0.5914826498422713,
	0,
	-0.5,
};


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
    printf("%s %.3f	", name, pv);
    oglUniform1f(oglGetUniformLocation(prog, name), pv);
}
static __forceinline void setUniforms(GLuint prog, float t) {printf("\n%.3f", t);
	setUniform(prog, "Fade", t, udtimes_Fade, udvalues_Fade, 6);
	setUniform(prog, "shift11", t, udtimes_shift11, udvalues_shift11, 3);
	setUniform(prog, "zoomshift", t, udtimes_zoomshift, udvalues_zoomshift, 10);
	setUniform(prog, "steps", t, udtimes_steps, udvalues_steps, 2);
	setUniform(prog, "greyscale", t, udtimes_greyscale, udvalues_greyscale, 2);
	setUniform(prog, "greyscale2", t, udtimes_greyscale2, udvalues_greyscale2, 9);
}
