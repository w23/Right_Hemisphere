#pragma data_seg(".udtimes_Fade")
static const float udtimes_Fade[] = {
	0.0,
	3.966666666666667,
	0.033333333333333215,
	0.4666666666666668,
	0.5333333333333332,
	3.0,
	127.69999999999999,
	10.300000000000011,
	325.0,
	9.0,
};

#pragma data_seg(".udvalues_Fade")
static const float udvalues_Fade[] = {
	0,
	0.3,
	0.3118975360576924,
	-0.1418975360576924,
	0.05615384615384622,
	0.4738461538461538,
	0,
	-1,
	1,
	-1,
};

#pragma data_seg(".udtimes_shift11")
static const float udtimes_shift11[] = {
	0,
	3.0,
	27.0,
	90.0,
};

#pragma data_seg(".udvalues_shift11")
static const float udvalues_shift11[] = {
	300,
	0,
	-213.23076923076923,
	78.46153846153847,
};

#pragma data_seg(".udtimes_zoomshift")
static const float udtimes_zoomshift[] = {
	0,
	8.0,
	0.033333333333333215,
	1.9666666666666668,
	86.0,
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
	2.8,
	0.0,
	-0.09999999999999964,
	0.09999999999999964,
	0.0,
	4.498,
	-0.05153846153846153,
	-4.446461538461539,
	2.990585567823344,
	-0.24531742902208276,
	0.12460567823343904,
	-0.09968454258675052,
	0.02492113564668763,
	-1.5951104100946374,
};

#pragma data_seg(".udtimes_steps")
static const float udtimes_steps[] = {
	0,
	96.0,
	0.03333333333333144,
};

#pragma data_seg(".udvalues_steps")
static const float udvalues_steps[] = {
	3.0,
	0.0,
	-2.0,
};

#pragma data_seg(".udtimes_greyscale")
static const float udtimes_greyscale[] = {
	0,
	96.0,
	0.03333333333333144,
	8.366666666666674,
	4.3999999999999915,
	0.20000000000000284,
	2.9666666666666686,
	0.06666666666666288,
	5.966666666666669,
	2.0,
};

#pragma data_seg(".udvalues_greyscale")
static const float udvalues_greyscale[] = {
	0,
	0,
	1,
	0,
	0,
	0,
	-0.09999999999999998,
	0.09999999999999998,
	0,
	-0.14,
};

#pragma data_seg(".udtimes_greyscale2")
static const float udtimes_greyscale2[] = {
	0,
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

#pragma data_seg(".udtimes_timeshift")
static const float udtimes_timeshift[] = {
	0,
	12.0,
	0.033333333333333215,
	11.966666666666667,
	0.7333333333333343,
	63.266666666666666,
	0.03333333333333144,
	7.966666666666669,
	0.03333333333333144,
};

#pragma data_seg(".udvalues_timeshift")
static const float udvalues_timeshift[] = {
	86.0,
	0.0,
	34.0,
	0,
	-114.0,
	0.0,
	112.0,
	0.0,
	-112.0,
};

#pragma data_seg(".udtimes_shiftX")
static const float udtimes_shiftX[] = {
	0,
	8.0,
	0.033333333333333215,
	3.966666666666667,
	0.033333333333333215,
	75.96666666666667,
	0.03333333333333144,
	7.966666666666669,
	0.03333333333333144,
};

#pragma data_seg(".udvalues_shiftX")
static const float udvalues_shiftX[] = {
	-0.5,
	0.0,
	0.43800000000000017,
	0.0,
	-0.43800000000000017,
	0.0,
	0.04999999999999982,
	0.0,
	-0.04999999999999982,
};

#pragma data_seg(".udtimes_shiftY")
static const float udtimes_shiftY[] = {
	0,
	8.0,
	0.033333333333333215,
	3.966666666666667,
	0.033333333333333215,
};

#pragma data_seg(".udvalues_shiftY")
static const float udvalues_shiftY[] = {
	-0.5,
	0.0,
	-0.33999999999999986,
	0.0,
	0.33999999999999986,
};

#pragma data_seg(".udtimes_zoomXY")
static const float udtimes_zoomXY[] = {
	0,
	8.0,
	0.033333333333333215,
	3.966666666666667,
	0.033333333333333215,
	75.96666666666667,
	0.03333333333333144,
	7.966666666666669,
	0.03333333333333144,
};

#pragma data_seg(".udvalues_zoomXY")
static const float udvalues_zoomXY[] = {
	1.4,
	0.0,
	-0.2999999999999998,
	0.0,
	0.2999999999999998,
	0.0,
	-0.09999999999999987,
	-0.15000000000000013,
	0.25,
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

    oglUniform1f(oglGetUniformLocation(prog, name), pv);
}
static __forceinline void setUniforms(GLuint prog, float t) {
	setUniform(prog, "Fade", t, udtimes_Fade, udvalues_Fade, 10);
	setUniform(prog, "shift11", t, udtimes_shift11, udvalues_shift11, 4);
	setUniform(prog, "zoomshift", t, udtimes_zoomshift, udvalues_zoomshift, 14);
	setUniform(prog, "steps", t, udtimes_steps, udvalues_steps, 3);
	setUniform(prog, "greyscale", t, udtimes_greyscale, udvalues_greyscale, 10);
	setUniform(prog, "greyscale2", t, udtimes_greyscale2, udvalues_greyscale2, 10);
	setUniform(prog, "timeshift", t, udtimes_timeshift, udvalues_timeshift, 9);
	setUniform(prog, "shiftX", t, udtimes_shiftX, udvalues_shiftX, 9);
	setUniform(prog, "shiftY", t, udtimes_shiftY, udvalues_shiftY, 5);
	setUniform(prog, "zoomXY", t, udtimes_zoomXY, udvalues_zoomXY, 9);
}
