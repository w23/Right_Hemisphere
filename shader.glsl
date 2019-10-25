float Fade, shift11, zoomshift, steps, greyscale, greyscale2, timeshift, shiftX, shiftY, zoomXY, red, skip, distort;
// Right Hemisphere intro




uniform float t;


vec3 massive[16]; // coordinates
float zoom;


vec3 rotate(vec3 p, vec3 a)
{
    vec3 s = sin(a), c = cos(a);
    return p * mat3(
         c.y,     s.z*s.y,            -s.y*c.z,
        -s.x*s.y, c.x*c.z+s.x*s.z*c.y, s.z*c.x-s.x*c.z*c.y,
         c.x*s.y, s.x*c.z-c.x*s.z*c.y, s.z*s.x+c.x*c.z*c.y
    );
}


vec3 fill(float x, float y, float z)
{
    return vec3(x*4.-2.,y*4.-2.,z*4.-2.);
}


float squareSingle(vec3 o, vec3 c) // input: ray position, square center
{
    vec3 p, r; // moved vector, rotation
    vec3 s = vec3(.5,.5,.001); // square size

    r = c;
    c.z = ( c.z + zoom ) * 4.;
    p = o - c; // move square to 0,0,0
    p = rotate(p, (t+timeshift)/29. * r); // rotate over axis x,y,z
    r = max(p - s, -p - s); // differences

    return max(max(r.x,r.y),r.z); // cube distance function
}


void main() {
	{		float dtt[10], dvt[10];
		dtt[0] = 0.0000000;
		dtt[1] = 3.9666667;
		dtt[2] = 0.0333333;
		dtt[3] = 0.4666667;
		dtt[4] = 0.5333333;
		dtt[5] = 3.0000000;
		dtt[6] = 127.7000000;
		dtt[7] = 17.2666667;
		dtt[8] = 318.0333333;
		dtt[9] = 9.0000000;
		dvt[0] = 0.0000000;
		dvt[1] = 0.3000000;
		dvt[2] = 0.3118975;
		dvt[3] = -0.1418975;
		dvt[4] = 0.0561538;
		dvt[5] = 0.4738462;
		dvt[6] = 0.0000000;
		dvt[7] = -1.0000000;
		dvt[8] = 1.0000000;
		dvt[9] = -1.0000000;

        float T = t; Fade = 0.;
        for (int i = 0; i < 10; ++i) {
            //float dt = dtFade[i], dv = dvFade[i];
            if (dtt[i] >= T) {
                Fade += T * dvt[i] / dtt[i];
                break;
            }
            Fade += dvt[i];
            T -= dtt[i];
        }
    }
	{		float dtt[8], dvt[8];
		dtt[0] = 0.0000000;
		dtt[1] = 3.0000000;
		dtt[2] = 9.0000000;
		dtt[3] = 0.0333333;
		dtt[4] = 11.9666667;
		dtt[5] = 0.0333333;
		dtt[6] = 5.9666667;
		dtt[7] = 90.0000000;
		dvt[0] = 300.0000000;
		dvt[1] = 0.0000000;
		dvt[2] = -71.1000000;
		dvt[3] = 34.1000000;
		dvt[4] = -20.0000000;
		dvt[5] = -109.0000000;
		dvt[6] = -47.2307692;
		dvt[7] = 78.4615385;

        float T = t; shift11 = 0.;
        for (int i = 0; i < 8; ++i) {
            //float dt = dtshift11[i], dv = dvshift11[i];
            if (dtt[i] >= T) {
                shift11 += T * dvt[i] / dtt[i];
                break;
            }
            shift11 += dvt[i];
            T -= dtt[i];
        }
    }
	{		float dtt[27], dvt[27];
		dtt[0] = 0.0000000;
		dtt[1] = 8.0000000;
		dtt[2] = 0.0333333;
		dtt[3] = 1.9666667;
		dtt[4] = 19.0000000;
		dtt[5] = 0.0333333;
		dtt[6] = 2.1000000;
		dtt[7] = 0.0333333;
		dtt[8] = 36.8333333;
		dtt[9] = 0.0333333;
		dtt[10] = 0.5000000;
		dtt[11] = 0.0333333;
		dtt[12] = 27.4333333;
		dtt[13] = 0.0333333;
		dtt[14] = 0.9666667;
		dtt[15] = 15.0000000;
		dtt[16] = 0.3000000;
		dtt[17] = 0.2000000;
		dtt[18] = 0.1666667;
		dtt[19] = 0.2000000;
		dtt[20] = 0.1333333;
		dtt[21] = 7.0000000;
		dtt[22] = 5.0000000;
		dtt[23] = 0.0333333;
		dtt[24] = 0.5333333;
		dtt[25] = 0.3333333;
		dtt[26] = 1.1000000;
		dvt[0] = 2.8000000;
		dvt[1] = 0.0000000;
		dvt[2] = -0.1000000;
		dvt[3] = 0.1000000;
		dvt[4] = 0.0000000;
		dvt[5] = -0.2000000;
		dvt[6] = 0.0000000;
		dvt[7] = 0.2000000;
		dvt[8] = 0.0000000;
		dvt[9] = 0.2000000;
		dvt[10] = 0.0000000;
		dvt[11] = -0.2000000;
		dvt[12] = 0.0000000;
		dvt[13] = 4.4980000;
		dvt[14] = -0.0515385;
		dvt[15] = -4.2464615;
		dvt[16] = 2.7905856;
		dvt[17] = -0.2453174;
		dvt[18] = 0.1246057;
		dvt[19] = -0.0996845;
		dvt[20] = 0.0249211;
		dvt[21] = -1.5951104;
		dvt[22] = 0.0000000;
		dvt[23] = -0.4000000;
		dvt[24] = 0.3500000;
		dvt[25] = -0.0500000;
		dvt[26] = 0.1000000;

        float T = t; zoomshift = 0.;
        for (int i = 0; i < 27; ++i) {
            //float dt = dtzoomshift[i], dv = dvzoomshift[i];
            if (dtt[i] >= T) {
                zoomshift += T * dvt[i] / dtt[i];
                break;
            }
            zoomshift += dvt[i];
            T -= dtt[i];
        }
    }
	{		float dtt[17], dvt[17];
		dtt[0] = 0.0000000;
		dtt[1] = 16.0000000;
		dtt[2] = 0.0333333;
		dtt[3] = 3.9666667;
		dtt[4] = 0.0333333;
		dtt[5] = 47.9666667;
		dtt[6] = 0.0333333;
		dtt[7] = 0.5000000;
		dtt[8] = 0.0333333;
		dtt[9] = 2.8000000;
		dtt[10] = 0.0333333;
		dtt[11] = 0.6333333;
		dtt[12] = 0.0333333;
		dtt[13] = 23.9333333;
		dtt[14] = 0.0333333;
		dtt[15] = 23.9666667;
		dtt[16] = 0.0333333;
		dvt[0] = 3.0000000;
		dvt[1] = 0.0000000;
		dvt[2] = 1.0000000;
		dvt[3] = 0.0000000;
		dvt[4] = -1.0000000;
		dvt[5] = 0.0000000;
		dvt[6] = -1.0000000;
		dvt[7] = 0.0000000;
		dvt[8] = 1.0000000;
		dvt[9] = 0.0000000;
		dvt[10] = -1.0000000;
		dvt[11] = 0.0000000;
		dvt[12] = 1.0000000;
		dvt[13] = 0.0000000;
		dvt[14] = -2.0000000;
		dvt[15] = 0.0000000;
		dvt[16] = 1.0000000;

        float T = t; steps = 0.;
        for (int i = 0; i < 17; ++i) {
            //float dt = dtsteps[i], dv = dvsteps[i];
            if (dtt[i] >= T) {
                steps += T * dvt[i] / dtt[i];
                break;
            }
            steps += dvt[i];
            T -= dtt[i];
        }
    }
	{		float dtt[14], dvt[14];
		dtt[0] = 0.0000000;
		dtt[1] = 96.0000000;
		dtt[2] = 0.0333333;
		dtt[3] = 12.9666667;
		dtt[4] = 2.9666667;
		dtt[5] = 0.0666667;
		dtt[6] = 5.9666667;
		dtt[7] = 2.0000000;
		dtt[8] = 0.0333333;
		dtt[9] = 4.9666667;
		dtt[10] = 0.0333333;
		dtt[11] = 17.2666667;
		dtt[12] = 6.6000000;
		dtt[13] = 4.0666667;
		dvt[0] = 0.0000000;
		dvt[1] = 0.0000000;
		dvt[2] = 1.0000000;
		dvt[3] = 0.0000000;
		dvt[4] = -0.1000000;
		dvt[5] = 0.1000000;
		dvt[6] = 0.0000000;
		dvt[7] = -0.1400000;
		dvt[8] = -0.3600000;
		dvt[9] = -0.2000000;
		dvt[10] = -0.3000000;
		dvt[11] = 0.0000000;
		dvt[12] = 0.4331250;
		dvt[13] = 0.2668750;

        float T = t; greyscale = 0.;
        for (int i = 0; i < 14; ++i) {
            //float dt = dtgreyscale[i], dv = dvgreyscale[i];
            if (dtt[i] >= T) {
                greyscale += T * dvt[i] / dtt[i];
                break;
            }
            greyscale += dvt[i];
            T -= dtt[i];
        }
    }
	{		float dtt[10], dvt[10];
		dtt[0] = 0.0000000;
		dtt[1] = 104.0000000;
		dtt[2] = 0.0333333;
		dtt[3] = 0.7000000;
		dtt[4] = 3.2666667;
		dtt[5] = 4.0000000;
		dtt[6] = 0.2333333;
		dtt[7] = 0.1000000;
		dtt[8] = 3.3666667;
		dtt[9] = 4.3000000;
		dvt[0] = 0.0000000;
		dvt[1] = 0.0000000;
		dvt[2] = 0.8501577;
		dvt[3] = -0.4195584;
		dvt[4] = -0.2018927;
		dvt[5] = -0.0189274;
		dvt[6] = 0.1987382;
		dvt[7] = 0.5914826;
		dvt[8] = 0.0000000;
		dvt[9] = -0.5000000;

        float T = t; greyscale2 = 0.;
        for (int i = 0; i < 10; ++i) {
            //float dt = dtgreyscale2[i], dv = dvgreyscale2[i];
            if (dtt[i] >= T) {
                greyscale2 += T * dvt[i] / dtt[i];
                break;
            }
            greyscale2 += dvt[i];
            T -= dtt[i];
        }
    }
	{		float dtt[15], dvt[15];
		dtt[0] = 0.0000000;
		dtt[1] = 12.0000000;
		dtt[2] = 0.0333333;
		dtt[3] = 3.9666667;
		dtt[4] = 0.0333333;
		dtt[5] = 3.9666667;
		dtt[6] = 0.0333333;
		dtt[7] = 3.9666667;
		dtt[8] = 1.0000000;
		dtt[9] = 55.0333333;
		dtt[10] = 0.0333333;
		dtt[11] = 7.9333333;
		dtt[12] = 0.0333333;
		dtt[13] = 7.9666667;
		dtt[14] = 0.0333333;
		dvt[0] = 86.0000000;
		dvt[1] = 0.0000000;
		dvt[2] = 78.0000000;
		dvt[3] = 0.0000000;
		dvt[4] = -375.0000000;
		dvt[5] = -10.0000000;
		dvt[6] = 385.0000000;
		dvt[7] = 0.0000000;
		dvt[8] = -158.0000000;
		dvt[9] = 0.0000000;
		dvt[10] = 150.0000000;
		dvt[11] = -6.0000000;
		dvt[12] = -28.0000000;
		dvt[13] = -4.0000000;
		dvt[14] = -112.0000000;

        float T = t; timeshift = 0.;
        for (int i = 0; i < 15; ++i) {
            //float dt = dttimeshift[i], dv = dvtimeshift[i];
            if (dtt[i] >= T) {
                timeshift += T * dvt[i] / dtt[i];
                break;
            }
            timeshift += dvt[i];
            T -= dtt[i];
        }
    }
	{		float dtt[16], dvt[16];
		dtt[0] = 0.0000000;
		dtt[1] = 8.0000000;
		dtt[2] = 0.0333333;
		dtt[3] = 3.9666667;
		dtt[4] = 0.0333333;
		dtt[5] = 3.9333333;
		dtt[6] = 0.0333333;
		dtt[7] = 0.0333333;
		dtt[8] = 3.9666667;
		dtt[9] = 0.0333333;
		dtt[10] = 60.0000000;
		dtt[11] = 0.0333333;
		dtt[12] = 7.9333333;
		dtt[13] = 0.0333333;
		dtt[14] = 7.9666667;
		dtt[15] = 0.0333333;
		dvt[0] = -0.5000000;
		dvt[1] = 0.0000000;
		dvt[2] = 0.4380000;
		dvt[3] = 0.0000000;
		dvt[4] = -0.3080000;
		dvt[5] = 0.0000000;
		dvt[6] = 0.0000000;
		dvt[7] = -0.6100000;
		dvt[8] = 0.0000000;
		dvt[9] = 0.4800000;
		dvt[10] = 0.0000000;
		dvt[11] = 0.7000000;
		dvt[12] = -0.2000000;
		dvt[13] = -0.4500000;
		dvt[14] = 0.0000000;
		dvt[15] = -0.0500000;

        float T = t; shiftX = 0.;
        for (int i = 0; i < 16; ++i) {
            //float dt = dtshiftX[i], dv = dvshiftX[i];
            if (dtt[i] >= T) {
                shiftX += T * dvt[i] / dtt[i];
                break;
            }
            shiftX += dvt[i];
            T -= dtt[i];
        }
    }
	{		float dtt[13], dvt[13];
		dtt[0] = 0.0000000;
		dtt[1] = 8.0000000;
		dtt[2] = 0.0333333;
		dtt[3] = 3.9666667;
		dtt[4] = 0.0333333;
		dtt[5] = 3.9666667;
		dtt[6] = 0.0333333;
		dtt[7] = 3.9666667;
		dtt[8] = 0.0333333;
		dtt[9] = 60.0000000;
		dtt[10] = 0.0333333;
		dtt[11] = 7.9333333;
		dtt[12] = 0.0333333;
		dvt[0] = -0.5000000;
		dvt[1] = 0.0000000;
		dvt[2] = -0.3000000;
		dvt[3] = 0.0000000;
		dvt[4] = 0.3000000;
		dvt[5] = 0.0000000;
		dvt[6] = 0.7800000;
		dvt[7] = 0.0000000;
		dvt[8] = -0.7800000;
		dvt[9] = 0.0000000;
		dvt[10] = 0.1000000;
		dvt[11] = 0.0000000;
		dvt[12] = -0.1000000;

        float T = t; shiftY = 0.;
        for (int i = 0; i < 13; ++i) {
            //float dt = dtshiftY[i], dv = dvshiftY[i];
            if (dtt[i] >= T) {
                shiftY += T * dvt[i] / dtt[i];
                break;
            }
            shiftY += dvt[i];
            T -= dtt[i];
        }
    }
	{		float dtt[24], dvt[24];
		dtt[0] = 0.0000000;
		dtt[1] = 8.0000000;
		dtt[2] = 0.0333333;
		dtt[3] = 3.9666667;
		dtt[4] = 0.0333333;
		dtt[5] = 0.9666667;
		dtt[6] = 3.0000000;
		dtt[7] = 0.0333333;
		dtt[8] = 3.9666667;
		dtt[9] = 0.0333333;
		dtt[10] = 3.9666667;
		dtt[11] = 0.0333333;
		dtt[12] = 6.9666667;
		dtt[13] = 3.0000000;
		dtt[14] = 46.0333333;
		dtt[15] = 0.0333333;
		dtt[16] = 7.9333333;
		dtt[17] = 0.0333333;
		dtt[18] = 7.9666667;
		dtt[19] = 0.0333333;
		dtt[20] = 23.9666667;
		dtt[21] = 0.0333333;
		dtt[22] = 24.9666667;
		dtt[23] = 7.9666667;
		dvt[0] = 1.4000000;
		dvt[1] = 0.0000000;
		dvt[2] = -0.3600000;
		dvt[3] = 0.0000000;
		dvt[4] = 0.1600000;
		dvt[5] = 0.0000000;
		dvt[6] = -0.0818182;
		dvt[7] = -0.6381818;
		dvt[8] = 0.0200000;
		dvt[9] = 0.3600000;
		dvt[10] = -0.0100000;
		dvt[11] = 0.3500000;
		dvt[12] = 0.0000000;
		dvt[13] = 0.0000000;
		dvt[14] = 1.1800000;
		dvt[15] = -1.6800000;
		dvt[16] = 0.0000000;
		dvt[17] = 0.6000000;
		dvt[18] = -0.1500000;
		dvt[19] = 0.2500000;
		dvt[20] = 0.0000000;
		dvt[21] = 0.2500000;
		dvt[22] = 0.5500000;
		dvt[23] = -0.2600000;

        float T = t; zoomXY = 0.;
        for (int i = 0; i < 24; ++i) {
            //float dt = dtzoomXY[i], dv = dvzoomXY[i];
            if (dtt[i] >= T) {
                zoomXY += T * dvt[i] / dtt[i];
                break;
            }
            zoomXY += dvt[i];
            T -= dtt[i];
        }
    }
	{		float dtt[24], dvt[24];
		dtt[0] = 0.0000000;
		dtt[1] = 29.0000000;
		dtt[2] = 2.1333333;
		dtt[3] = 0.0333333;
		dtt[4] = 2.8666667;
		dtt[5] = 0.0333333;
		dtt[6] = 0.1000000;
		dtt[7] = 0.1333333;
		dtt[8] = 0.7000000;
		dtt[9] = 3.0000000;
		dtt[10] = 30.0000000;
		dtt[11] = 0.0333333;
		dtt[12] = 0.5333333;
		dtt[13] = 0.0333333;
		dtt[14] = 0.9000000;
		dtt[15] = 10.5333333;
		dtt[16] = 0.0333333;
		dtt[17] = 9.9333333;
		dtt[18] = 0.0333333;
		dtt[19] = 0.2333333;
		dtt[20] = 1.7333333;
		dtt[21] = 33.0000000;
		dtt[22] = 0.0333333;
		dtt[23] = 1.9666667;
		dvt[0] = 0.0000000;
		dvt[1] = 0.0000000;
		dvt[2] = 1.0000000;
		dvt[3] = -1.0000000;
		dvt[4] = 0.0000000;
		dvt[5] = 0.4000000;
		dvt[6] = 0.0000000;
		dvt[7] = -0.2000000;
		dvt[8] = -0.2000000;
		dvt[9] = 0.0000000;
		dvt[10] = 0.7140000;
		dvt[11] = -0.4540000;
		dvt[12] = 0.3400000;
		dvt[13] = -0.2600000;
		dvt[14] = 0.4100000;
		dvt[15] = 0.2500000;
		dvt[16] = -1.0000000;
		dvt[17] = 0.0000000;
		dvt[18] = 0.2500000;
		dvt[19] = -0.0200000;
		dvt[20] = -0.2300000;
		dvt[21] = 0.0000000;
		dvt[22] = 0.6184615;
		dvt[23] = -0.6184615;

        float T = t; red = 0.;
        for (int i = 0; i < 24; ++i) {
            //float dt = dtred[i], dv = dvred[i];
            if (dtt[i] >= T) {
                red += T * dvt[i] / dtt[i];
                break;
            }
            red += dvt[i];
            T -= dtt[i];
        }
    }
	{		float dtt[10], dvt[10];
		dtt[0] = 0.0000000;
		dtt[1] = 28.0000000;
		dtt[2] = 0.0333333;
		dtt[3] = 0.4666667;
		dtt[4] = 0.0333333;
		dtt[5] = 0.5000000;
		dtt[6] = 0.0333333;
		dtt[7] = 42.3333333;
		dtt[8] = 0.6000000;
		dtt[9] = 0.0333333;
		dvt[0] = 15.0000000;
		dvt[1] = 0.0000000;
		dvt[2] = -3.4000000;
		dvt[3] = -2.6000000;
		dvt[4] = -5.0000000;
		dvt[5] = -4.0000000;
		dvt[6] = 15.0000000;
		dvt[7] = 0.0000000;
		dvt[8] = -15.0000000;
		dvt[9] = 15.0000000;

        float T = t; skip = 0.;
        for (int i = 0; i < 10; ++i) {
            //float dt = dtskip[i], dv = dvskip[i];
            if (dtt[i] >= T) {
                skip += T * dvt[i] / dtt[i];
                break;
            }
            skip += dvt[i];
            T -= dtt[i];
        }
    }
	{		float dtt[20], dvt[20];
		dtt[0] = 0.0000000;
		dtt[1] = 52.0000000;
		dtt[2] = 0.0333333;
		dtt[3] = 0.4000000;
		dtt[4] = 0.0333333;
		dtt[5] = 0.5000000;
		dtt[6] = 0.4000000;
		dtt[7] = 14.6333333;
		dtt[8] = 0.0333333;
		dtt[9] = 0.5333333;
		dtt[10] = 0.0333333;
		dtt[11] = 1.2000000;
		dtt[12] = 1.2000000;
		dtt[13] = 0.0333333;
		dtt[14] = 0.3333333;
		dtt[15] = 0.0333333;
		dtt[16] = 0.6000000;
		dtt[17] = 0.0333333;
		dtt[18] = 0.0666667;
		dtt[19] = 0.4333333;
		dvt[0] = 0.0000000;
		dvt[1] = 0.0000000;
		dvt[2] = 0.3500000;
		dvt[3] = -0.2500000;
		dvt[4] = 0.1000000;
		dvt[5] = -0.1500000;
		dvt[6] = -0.0500000;
		dvt[7] = 0.0000000;
		dvt[8] = 0.2500000;
		dvt[9] = -0.1500000;
		dvt[10] = 0.1000000;
		dvt[11] = -0.2000000;
		dvt[12] = 0.0000000;
		dvt[13] = 0.3000000;
		dvt[14] = -0.2000000;
		dvt[15] = 0.2000000;
		dvt[16] = 0.7000000;
		dvt[17] = -0.0910528;
		dvt[18] = -0.7089472;
		dvt[19] = -0.2000000;

        float T = t; distort = 0.;
        for (int i = 0; i < 20; ++i) {
            //float dt = dtdistort[i], dv = dvdistort[i];
            if (dtt[i] >= T) {
                distort += T * dvt[i] / dtt[i];
                break;
            }
            distort += dvt[i];
            T -= dtt[i];
        }
    }

  
    zoom = zoomshift + smoothstep(120.,180.,t+timeshift)*.6 - smoothstep(240.,300.,t+timeshift);
    
// objects coordinates

    massive[0] = fill(.044677,.928527,.337524);
    massive[1] = fill(.520019,.026367,.486328);
    massive[2] = fill(.026125,.984497,.337249);
    massive[3] = fill(.635498,.420410,.417480);
    massive[4] = fill(.558349,.929687,.849609);
    massive[5] = fill(.840576,.539917,.436889);
    massive[6] = fill(.096557,.049438,.537475);
    massive[7] = fill(.439819,.906127,.853759);
    massive[8] = fill(.291748,.754150,.479736);
    massive[9] = fill(.572753,.774047,.402343);
    massive[10]= fill(.565551,.614624,.542602);
    massive[11]= fill(.279052,.261779,.264550);
    massive[12]= fill(.622070,.145751,.537809);
    massive[13]= fill(.846801,.820800,.397094);
    massive[14]= fill(.905029,.469421,.400512);
    massive[15]= fill(.725585,.835769,.054077);    
    
    massive[11]-=shift11/vec3(70.,110.,-180.); // move closest object 

    float l, d, d2, e = .0001, aax, aay = .00015; // ray length, current distance, epsilon, anti-aliasing

    vec3 xyz, color = vec3(0.), c, // 3d-coordinates, final color, aa-color
    p, r, found1, found2, s = vec3(.5,.5,.001), // moved vector, center, rotation, found square, square size
    norm = vec3(0.,0.,0.), ex = vec3(e,0.,0.), ey = vec3(0.,e,0.), ez = vec3(0.,0.,e);

// antialiasing
for (int by=0; by<3; by++)
{
aax = .00015;
for (int bx=0; bx<3; bx++)
{
	vec2 uv = ((gl_FragCoord.xy/vec2(1920.,1080.)) + vec2(aax,aay) + vec2(shiftX,shiftY)) / vec2(1., 16./9.) * zoomXY;
//	vec2 uv = ((gl_FragCoord.xy/vec2(1920.,1080.)) + vec2(shiftX,shiftY)) / vec2(1., 16./9.) * zoomXY;

// raymarching
	l = 1.;
    xyz = normalize(vec3(uv, 1.)); // view direction

    for (int i=0; i<5; i++) // trace to bounding sphere for the faster computation
    {
        if (i>=int(steps)) break;
		d = 26.; // distance
	    for (int j=0; j<15; j++) if(j!=int(skip))
	    {
	        c = massive[j];
	        c.z = ( c.z + zoom ) * 4.;
	        d = min( d, length(xyz*l - c)-0.71 ); // sphere distance function
	    }
        if (d<e) break;
        l += d;
        if (l>26.) break;
    }

    if (l<26.)
    {
        if (mod(uv.y,.08)<.04) l-=distort;
        xyz *= l; // actual point
	    d = 26.;
	    for (int i=0; i<15; i++)
	    {
	        c = massive[i];
	        found1 = c;
	        r = c;
	        c.z = ( c.z + zoom ) * 4.;
	        p = xyz - c; // move square to 0,0,0
	        p = rotate(p, (t+timeshift)/29. * r); // rotate over axis x,y,z
	        r = max(p - s, -p - s); // differences
	        d2 = max(max(r.x,r.y),r.z); // cube distance function
	        if (d2 < d)
	        {
	            d = d2;
	            found2 = found1;
	        }
	    }
        norm = normalize(vec3(
        squareSingle(xyz+ex,found2)-squareSingle(xyz-ex,found2),
        squareSingle(xyz+ey,found2)-squareSingle(xyz-ey,found2),
        squareSingle(xyz+ez,found2)-squareSingle(xyz-ez,found2)));
    }

    
    c = vec3(norm.xy,vec3(1.-l/20.));

    c.z+=c.y/2.; c.y=c.y+c.x; // colour correction

    color += clamp(c, 0., 1.); // accumulate aa-color

aax += .0003; // end of antialiasing loop 
}
aay += .0003;
}  
color /= 9.; // normalize aa-color

    color = (1.-greyscale)*color + vec3(color.r+color.b*greyscale2) *greyscale;
    color.xz+=red*vec2(abs(norm.y),color.b/3.);
    gl_FragColor = vec4(color * Fade, 1.);
}