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
	{
		float dtt[27], dvt[27], T, v;
		dtt[0] = 0.000;
		dtt[1] = 3.967;
		dtt[2] = 0.033;
		dtt[3] = 0.467;
		dtt[4] = 0.533;
		dtt[5] = 3.000;
		dtt[6] = 127.700;
		dtt[7] = 17.267;
		dtt[8] = 318.033;
		dtt[9] = 9.000;
		dvt[0] = 0.000;
		dvt[1] = 0.300;
		dvt[2] = 0.312;
		dvt[3] = -0.142;
		dvt[4] = 0.056;
		dvt[5] = 0.474;
		dvt[6] = 0.000;
		dvt[7] = -1.000;
		dvt[8] = 1.000;
		dvt[9] = -1.000;

        T = t; v = 0.;
        for (int i = 0; i < 10; ++i) {
            //float dt = dtFade[i], dv = dvFade[i];
            if (T < dtt[i]) {
                v += dvt[i] * T / dtt[i];
                break;
            }
            v += dvt[i];
            T -= dtt[i];
        }
        Fade = v;
		dtt[0] = 0.000;
		dtt[1] = 3.000;
		dtt[2] = 9.000;
		dtt[3] = 0.033;
		dtt[4] = 11.967;
		dtt[5] = 0.033;
		dtt[6] = 5.967;
		dtt[7] = 90.000;
		dvt[0] = 300.000;
		dvt[1] = 0.000;
		dvt[2] = -71.100;
		dvt[3] = 34.100;
		dvt[4] = -20.000;
		dvt[5] = -109.000;
		dvt[6] = -47.231;
		dvt[7] = 78.462;

        T = t; v = 0.;
        for (int i = 0; i < 8; ++i) {
            //float dt = dtshift11[i], dv = dvshift11[i];
            if (T < dtt[i]) {
                v += dvt[i] * T / dtt[i];
                break;
            }
            v += dvt[i];
            T -= dtt[i];
        }
        shift11 = v;
		dtt[0] = 0.000;
		dtt[1] = 8.000;
		dtt[2] = 0.033;
		dtt[3] = 1.967;
		dtt[4] = 19.000;
		dtt[5] = 0.033;
		dtt[6] = 2.100;
		dtt[7] = 0.033;
		dtt[8] = 36.833;
		dtt[9] = 0.033;
		dtt[10] = 0.500;
		dtt[11] = 0.033;
		dtt[12] = 27.433;
		dtt[13] = 0.033;
		dtt[14] = 0.967;
		dtt[15] = 15.000;
		dtt[16] = 0.300;
		dtt[17] = 0.200;
		dtt[18] = 0.167;
		dtt[19] = 0.200;
		dtt[20] = 0.133;
		dtt[21] = 7.000;
		dtt[22] = 5.000;
		dtt[23] = 0.033;
		dtt[24] = 0.533;
		dtt[25] = 0.333;
		dtt[26] = 1.100;
		dvt[0] = 2.800;
		dvt[1] = 0.000;
		dvt[2] = -0.100;
		dvt[3] = 0.100;
		dvt[4] = 0.000;
		dvt[5] = -0.200;
		dvt[6] = 0.000;
		dvt[7] = 0.200;
		dvt[8] = 0.000;
		dvt[9] = 0.200;
		dvt[10] = 0.000;
		dvt[11] = -0.200;
		dvt[12] = 0.000;
		dvt[13] = 4.498;
		dvt[14] = -0.052;
		dvt[15] = -4.246;
		dvt[16] = 2.791;
		dvt[17] = -0.245;
		dvt[18] = 0.125;
		dvt[19] = -0.100;
		dvt[20] = 0.025;
		dvt[21] = -1.595;
		dvt[22] = 0.000;
		dvt[23] = -0.400;
		dvt[24] = 0.350;
		dvt[25] = -0.050;
		dvt[26] = 0.100;

        T = t; v = 0.;
        for (int i = 0; i < 27; ++i) {
            //float dt = dtzoomshift[i], dv = dvzoomshift[i];
            if (T < dtt[i]) {
                v += dvt[i] * T / dtt[i];
                break;
            }
            v += dvt[i];
            T -= dtt[i];
        }
        zoomshift = v;
		dtt[0] = 0.000;
		dtt[1] = 16.000;
		dtt[2] = 0.033;
		dtt[3] = 3.967;
		dtt[4] = 0.033;
		dtt[5] = 47.967;
		dtt[6] = 0.033;
		dtt[7] = 0.500;
		dtt[8] = 0.033;
		dtt[9] = 2.800;
		dtt[10] = 0.033;
		dtt[11] = 0.633;
		dtt[12] = 0.033;
		dtt[13] = 23.933;
		dtt[14] = 0.033;
		dtt[15] = 23.967;
		dtt[16] = 0.033;
		dvt[0] = 3.000;
		dvt[1] = 0.000;
		dvt[2] = 1.000;
		dvt[3] = 0.000;
		dvt[4] = -1.000;
		dvt[5] = 0.000;
		dvt[6] = -1.000;
		dvt[7] = 0.000;
		dvt[8] = 1.000;
		dvt[9] = 0.000;
		dvt[10] = -1.000;
		dvt[11] = 0.000;
		dvt[12] = 1.000;
		dvt[13] = 0.000;
		dvt[14] = -2.000;
		dvt[15] = 0.000;
		dvt[16] = 1.000;

        T = t; v = 0.;
        for (int i = 0; i < 17; ++i) {
            //float dt = dtsteps[i], dv = dvsteps[i];
            if (T < dtt[i]) {
                v += dvt[i] * T / dtt[i];
                break;
            }
            v += dvt[i];
            T -= dtt[i];
        }
        steps = v;
		dtt[0] = 0.000;
		dtt[1] = 96.000;
		dtt[2] = 0.033;
		dtt[3] = 12.967;
		dtt[4] = 2.967;
		dtt[5] = 0.067;
		dtt[6] = 5.967;
		dtt[7] = 2.000;
		dtt[8] = 0.033;
		dtt[9] = 4.967;
		dtt[10] = 0.033;
		dtt[11] = 17.267;
		dtt[12] = 6.600;
		dtt[13] = 4.067;
		dvt[0] = 0.000;
		dvt[1] = 0.000;
		dvt[2] = 1.000;
		dvt[3] = 0.000;
		dvt[4] = -0.100;
		dvt[5] = 0.100;
		dvt[6] = 0.000;
		dvt[7] = -0.140;
		dvt[8] = -0.360;
		dvt[9] = -0.200;
		dvt[10] = -0.300;
		dvt[11] = 0.000;
		dvt[12] = 0.433;
		dvt[13] = 0.267;

        T = t; v = 0.;
        for (int i = 0; i < 14; ++i) {
            //float dt = dtgreyscale[i], dv = dvgreyscale[i];
            if (T < dtt[i]) {
                v += dvt[i] * T / dtt[i];
                break;
            }
            v += dvt[i];
            T -= dtt[i];
        }
        greyscale = v;
		dtt[0] = 0.000;
		dtt[1] = 104.000;
		dtt[2] = 0.033;
		dtt[3] = 0.700;
		dtt[4] = 3.267;
		dtt[5] = 4.000;
		dtt[6] = 0.233;
		dtt[7] = 0.100;
		dtt[8] = 3.367;
		dtt[9] = 4.300;
		dvt[0] = 0.000;
		dvt[1] = 0.000;
		dvt[2] = 0.850;
		dvt[3] = -0.420;
		dvt[4] = -0.202;
		dvt[5] = -0.019;
		dvt[6] = 0.199;
		dvt[7] = 0.591;
		dvt[8] = 0.000;
		dvt[9] = -0.500;

        T = t; v = 0.;
        for (int i = 0; i < 10; ++i) {
            //float dt = dtgreyscale2[i], dv = dvgreyscale2[i];
            if (T < dtt[i]) {
                v += dvt[i] * T / dtt[i];
                break;
            }
            v += dvt[i];
            T -= dtt[i];
        }
        greyscale2 = v;
		dtt[0] = 0.000;
		dtt[1] = 12.000;
		dtt[2] = 0.033;
		dtt[3] = 3.967;
		dtt[4] = 0.033;
		dtt[5] = 3.967;
		dtt[6] = 0.033;
		dtt[7] = 3.967;
		dtt[8] = 1.000;
		dtt[9] = 55.033;
		dtt[10] = 0.033;
		dtt[11] = 7.933;
		dtt[12] = 0.033;
		dtt[13] = 7.967;
		dtt[14] = 0.033;
		dvt[0] = 86.000;
		dvt[1] = 0.000;
		dvt[2] = 78.000;
		dvt[3] = 0.000;
		dvt[4] = -375.000;
		dvt[5] = -10.000;
		dvt[6] = 385.000;
		dvt[7] = 0.000;
		dvt[8] = -158.000;
		dvt[9] = 0.000;
		dvt[10] = 150.000;
		dvt[11] = -6.000;
		dvt[12] = -28.000;
		dvt[13] = -4.000;
		dvt[14] = -112.000;

        T = t; v = 0.;
        for (int i = 0; i < 15; ++i) {
            //float dt = dttimeshift[i], dv = dvtimeshift[i];
            if (T < dtt[i]) {
                v += dvt[i] * T / dtt[i];
                break;
            }
            v += dvt[i];
            T -= dtt[i];
        }
        timeshift = v;
		dtt[0] = 0.000;
		dtt[1] = 8.000;
		dtt[2] = 0.033;
		dtt[3] = 3.967;
		dtt[4] = 0.033;
		dtt[5] = 3.933;
		dtt[6] = 0.033;
		dtt[7] = 0.033;
		dtt[8] = 3.967;
		dtt[9] = 0.033;
		dtt[10] = 60.000;
		dtt[11] = 0.033;
		dtt[12] = 7.933;
		dtt[13] = 0.033;
		dtt[14] = 7.967;
		dtt[15] = 0.033;
		dvt[0] = -0.500;
		dvt[1] = 0.000;
		dvt[2] = 0.438;
		dvt[3] = 0.000;
		dvt[4] = -0.308;
		dvt[5] = 0.000;
		dvt[6] = 0.000;
		dvt[7] = -0.610;
		dvt[8] = 0.000;
		dvt[9] = 0.480;
		dvt[10] = 0.000;
		dvt[11] = 0.700;
		dvt[12] = -0.200;
		dvt[13] = -0.450;
		dvt[14] = 0.000;
		dvt[15] = -0.050;

        T = t; v = 0.;
        for (int i = 0; i < 16; ++i) {
            //float dt = dtshiftX[i], dv = dvshiftX[i];
            if (T < dtt[i]) {
                v += dvt[i] * T / dtt[i];
                break;
            }
            v += dvt[i];
            T -= dtt[i];
        }
        shiftX = v;
		dtt[0] = 0.000;
		dtt[1] = 8.000;
		dtt[2] = 0.033;
		dtt[3] = 3.967;
		dtt[4] = 0.033;
		dtt[5] = 3.967;
		dtt[6] = 0.033;
		dtt[7] = 3.967;
		dtt[8] = 0.033;
		dtt[9] = 60.000;
		dtt[10] = 0.033;
		dtt[11] = 7.933;
		dtt[12] = 0.033;
		dvt[0] = -0.500;
		dvt[1] = 0.000;
		dvt[2] = -0.300;
		dvt[3] = 0.000;
		dvt[4] = 0.300;
		dvt[5] = 0.000;
		dvt[6] = 0.780;
		dvt[7] = 0.000;
		dvt[8] = -0.780;
		dvt[9] = 0.000;
		dvt[10] = 0.100;
		dvt[11] = 0.000;
		dvt[12] = -0.100;

        T = t; v = 0.;
        for (int i = 0; i < 13; ++i) {
            //float dt = dtshiftY[i], dv = dvshiftY[i];
            if (T < dtt[i]) {
                v += dvt[i] * T / dtt[i];
                break;
            }
            v += dvt[i];
            T -= dtt[i];
        }
        shiftY = v;
		dtt[0] = 0.000;
		dtt[1] = 8.000;
		dtt[2] = 0.033;
		dtt[3] = 3.967;
		dtt[4] = 0.033;
		dtt[5] = 0.967;
		dtt[6] = 3.000;
		dtt[7] = 0.033;
		dtt[8] = 3.967;
		dtt[9] = 0.033;
		dtt[10] = 3.967;
		dtt[11] = 0.033;
		dtt[12] = 6.967;
		dtt[13] = 3.000;
		dtt[14] = 46.033;
		dtt[15] = 0.033;
		dtt[16] = 7.933;
		dtt[17] = 0.033;
		dtt[18] = 7.967;
		dtt[19] = 0.033;
		dtt[20] = 23.967;
		dtt[21] = 0.033;
		dtt[22] = 24.967;
		dtt[23] = 7.967;
		dvt[0] = 1.400;
		dvt[1] = 0.000;
		dvt[2] = -0.360;
		dvt[3] = 0.000;
		dvt[4] = 0.160;
		dvt[5] = 0.000;
		dvt[6] = -0.082;
		dvt[7] = -0.638;
		dvt[8] = 0.020;
		dvt[9] = 0.360;
		dvt[10] = -0.010;
		dvt[11] = 0.350;
		dvt[12] = 0.000;
		dvt[13] = 0.000;
		dvt[14] = 1.180;
		dvt[15] = -1.680;
		dvt[16] = 0.000;
		dvt[17] = 0.600;
		dvt[18] = -0.150;
		dvt[19] = 0.250;
		dvt[20] = 0.000;
		dvt[21] = 0.250;
		dvt[22] = 0.550;
		dvt[23] = -0.260;

        T = t; v = 0.;
        for (int i = 0; i < 24; ++i) {
            //float dt = dtzoomXY[i], dv = dvzoomXY[i];
            if (T < dtt[i]) {
                v += dvt[i] * T / dtt[i];
                break;
            }
            v += dvt[i];
            T -= dtt[i];
        }
        zoomXY = v;
		dtt[0] = 0.000;
		dtt[1] = 29.000;
		dtt[2] = 2.133;
		dtt[3] = 0.033;
		dtt[4] = 2.867;
		dtt[5] = 0.033;
		dtt[6] = 0.100;
		dtt[7] = 0.133;
		dtt[8] = 0.700;
		dtt[9] = 3.000;
		dtt[10] = 30.000;
		dtt[11] = 0.033;
		dtt[12] = 0.533;
		dtt[13] = 0.033;
		dtt[14] = 0.900;
		dtt[15] = 10.533;
		dtt[16] = 0.033;
		dtt[17] = 9.933;
		dtt[18] = 0.033;
		dtt[19] = 0.233;
		dtt[20] = 1.733;
		dtt[21] = 33.000;
		dtt[22] = 0.033;
		dtt[23] = 1.967;
		dvt[0] = 0.000;
		dvt[1] = 0.000;
		dvt[2] = 1.000;
		dvt[3] = -1.000;
		dvt[4] = 0.000;
		dvt[5] = 0.400;
		dvt[6] = 0.000;
		dvt[7] = -0.200;
		dvt[8] = -0.200;
		dvt[9] = 0.000;
		dvt[10] = 0.714;
		dvt[11] = -0.454;
		dvt[12] = 0.340;
		dvt[13] = -0.260;
		dvt[14] = 0.410;
		dvt[15] = 0.250;
		dvt[16] = -1.000;
		dvt[17] = 0.000;
		dvt[18] = 0.250;
		dvt[19] = -0.020;
		dvt[20] = -0.230;
		dvt[21] = 0.000;
		dvt[22] = 0.618;
		dvt[23] = -0.618;

        T = t; v = 0.;
        for (int i = 0; i < 24; ++i) {
            //float dt = dtred[i], dv = dvred[i];
            if (T < dtt[i]) {
                v += dvt[i] * T / dtt[i];
                break;
            }
            v += dvt[i];
            T -= dtt[i];
        }
        red = v;
		dtt[0] = 0.000;
		dtt[1] = 28.000;
		dtt[2] = 0.033;
		dtt[3] = 0.467;
		dtt[4] = 0.033;
		dtt[5] = 0.500;
		dtt[6] = 0.033;
		dtt[7] = 42.333;
		dtt[8] = 0.600;
		dtt[9] = 0.033;
		dvt[0] = 15.000;
		dvt[1] = 0.000;
		dvt[2] = -3.400;
		dvt[3] = -2.600;
		dvt[4] = -5.000;
		dvt[5] = -4.000;
		dvt[6] = 15.000;
		dvt[7] = 0.000;
		dvt[8] = -15.000;
		dvt[9] = 15.000;

        T = t; v = 0.;
        for (int i = 0; i < 10; ++i) {
            //float dt = dtskip[i], dv = dvskip[i];
            if (T < dtt[i]) {
                v += dvt[i] * T / dtt[i];
                break;
            }
            v += dvt[i];
            T -= dtt[i];
        }
        skip = v;
		dtt[0] = 0.000;
		dtt[1] = 52.000;
		dtt[2] = 0.033;
		dtt[3] = 0.400;
		dtt[4] = 0.033;
		dtt[5] = 0.500;
		dtt[6] = 0.400;
		dtt[7] = 14.633;
		dtt[8] = 0.033;
		dtt[9] = 0.533;
		dtt[10] = 0.033;
		dtt[11] = 1.200;
		dtt[12] = 1.200;
		dtt[13] = 0.033;
		dtt[14] = 0.333;
		dtt[15] = 0.033;
		dtt[16] = 0.600;
		dtt[17] = 0.033;
		dtt[18] = 0.067;
		dtt[19] = 0.433;
		dvt[0] = 0.000;
		dvt[1] = 0.000;
		dvt[2] = 0.350;
		dvt[3] = -0.250;
		dvt[4] = 0.100;
		dvt[5] = -0.150;
		dvt[6] = -0.050;
		dvt[7] = 0.000;
		dvt[8] = 0.250;
		dvt[9] = -0.150;
		dvt[10] = 0.100;
		dvt[11] = -0.200;
		dvt[12] = 0.000;
		dvt[13] = 0.300;
		dvt[14] = -0.200;
		dvt[15] = 0.200;
		dvt[16] = 0.700;
		dvt[17] = -0.091;
		dvt[18] = -0.709;
		dvt[19] = -0.200;

        T = t; v = 0.;
        for (int i = 0; i < 20; ++i) {
            //float dt = dtdistort[i], dv = dvdistort[i];
            if (T < dtt[i]) {
                v += dvt[i] * T / dtt[i];
                break;
            }
            v += dvt[i];
            T -= dtt[i];
        }
        distort = v;
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