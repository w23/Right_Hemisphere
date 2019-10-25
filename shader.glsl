#version 120
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
		float T=t,v=0.,dtt[10],dvt[10];
#'float b=x,l=0.,a[10]=float[](0.000,3.967,0.033,0.467,0.533,3.000,127.700,17.267,318.033,9.000),e[10]=float[](0.000,0.300,0.312,-0.142,0.056,0.474,0.000,-1.000,1.000,-1.000);'

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
    }
	{
		float T=t,v=0.,dtt[8],dvt[8];
#'float b=x,l=0.,a[8]=float[](0.000,3.000,9.000,0.033,11.967,0.033,5.967,90.000),e[8]=float[](300.000,0.000,-71.100,34.100,-20.000,-109.000,-47.231,78.462);'

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
    }
	{
		float T=t,v=0.,dtt[27],dvt[27];
#'float b=x,l=0.,a[27]=float[](0.000,8.000,0.033,1.967,19.000,0.033,2.100,0.033,36.833,0.033,0.500,0.033,27.433,0.033,0.967,15.000,0.300,0.200,0.167,0.200,0.133,7.000,5.000,0.033,0.533,0.333,1.100),e[27]=float[](2.800,0.000,-0.100,0.100,0.000,-0.200,0.000,0.200,0.000,0.200,0.000,-0.200,0.000,4.498,-0.052,-4.246,2.791,-0.245,0.125,-0.100,0.025,-1.595,0.000,-0.400,0.350,-0.050,0.100);'

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
    }
	{
		float T=t,v=0.,dtt[17],dvt[17];
#'float b=x,l=0.,a[17]=float[](0.000,16.000,0.033,3.967,0.033,47.967,0.033,0.500,0.033,2.800,0.033,0.633,0.033,23.933,0.033,23.967,0.033),e[17]=float[](3.000,0.000,1.000,0.000,-1.000,0.000,-1.000,0.000,1.000,0.000,-1.000,0.000,1.000,0.000,-2.000,0.000,1.000);'

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
    }
	{
		float T=t,v=0.,dtt[14],dvt[14];
#'float b=x,l=0.,a[14]=float[](0.000,96.000,0.033,12.967,2.967,0.067,5.967,2.000,0.033,4.967,0.033,17.267,6.600,4.067),e[14]=float[](0.000,0.000,1.000,0.000,-0.100,0.100,0.000,-0.140,-0.360,-0.200,-0.300,0.000,0.433,0.267);'

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
    }
	{
		float T=t,v=0.,dtt[10],dvt[10];
#'float b=x,l=0.,a[10]=float[](0.000,104.000,0.033,0.700,3.267,4.000,0.233,0.100,3.367,4.300),e[10]=float[](0.000,0.000,0.850,-0.420,-0.202,-0.019,0.199,0.591,0.000,-0.500);'

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
    }
	{
		float T=t,v=0.,dtt[15],dvt[15];
#'float b=x,l=0.,a[15]=float[](0.000,12.000,0.033,3.967,0.033,3.967,0.033,3.967,1.000,55.033,0.033,7.933,0.033,7.967,0.033),e[15]=float[](86.000,0.000,78.000,0.000,-375.000,-10.000,385.000,0.000,-158.000,0.000,150.000,-6.000,-28.000,-4.000,-112.000);'

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
    }
	{
		float T=t,v=0.,dtt[16],dvt[16];
#'float b=x,l=0.,a[16]=float[](0.000,8.000,0.033,3.967,0.033,3.933,0.033,0.033,3.967,0.033,60.000,0.033,7.933,0.033,7.967,0.033),e[16]=float[](-0.500,0.000,0.438,0.000,-0.308,0.000,0.000,-0.610,0.000,0.480,0.000,0.700,-0.200,-0.450,0.000,-0.050);'

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
    }
	{
		float T=t,v=0.,dtt[13],dvt[13];
#'float b=x,l=0.,a[13]=float[](0.000,8.000,0.033,3.967,0.033,3.967,0.033,3.967,0.033,60.000,0.033,7.933,0.033),e[13]=float[](-0.500,0.000,-0.300,0.000,0.300,0.000,0.780,0.000,-0.780,0.000,0.100,0.000,-0.100);'

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
    }
	{
		float T=t,v=0.,dtt[24],dvt[24];
#'float b=x,l=0.,a[24]=float[](0.000,8.000,0.033,3.967,0.033,0.967,3.000,0.033,3.967,0.033,3.967,0.033,6.967,3.000,46.033,0.033,7.933,0.033,7.967,0.033,23.967,0.033,24.967,7.967),e[24]=float[](1.400,0.000,-0.360,0.000,0.160,0.000,-0.082,-0.638,0.020,0.360,-0.010,0.350,0.000,0.000,1.180,-1.680,0.000,0.600,-0.150,0.250,0.000,0.250,0.550,-0.260);'

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
    }
	{
		float T=t,v=0.,dtt[24],dvt[24];
#'float b=x,l=0.,a[24]=float[](0.000,29.000,2.133,0.033,2.867,0.033,0.100,0.133,0.700,3.000,30.000,0.033,0.533,0.033,0.900,10.533,0.033,9.933,0.033,0.233,1.733,33.000,0.033,1.967),e[24]=float[](0.000,0.000,1.000,-1.000,0.000,0.400,0.000,-0.200,-0.200,0.000,0.714,-0.454,0.340,-0.260,0.410,0.250,-1.000,0.000,0.250,-0.020,-0.230,0.000,0.618,-0.618);'

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
    }
	{
		float T=t,v=0.,dtt[10],dvt[10];
#'float b=x,l=0.,a[10]=float[](0.000,28.000,0.033,0.467,0.033,0.500,0.033,42.333,0.600,0.033),e[10]=float[](15.000,0.000,-3.400,-2.600,-5.000,-4.000,15.000,0.000,-15.000,15.000);'

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
    }
	{
		float T=t,v=0.,dtt[20],dvt[20];
#'float b=x,l=0.,a[20]=float[](0.000,52.000,0.033,0.400,0.033,0.500,0.400,14.633,0.033,0.533,0.033,1.200,1.200,0.033,0.333,0.033,0.600,0.033,0.067,0.433),e[20]=float[](0.000,0.000,0.350,-0.250,0.100,-0.150,-0.050,0.000,0.250,-0.150,0.100,-0.200,0.000,0.300,-0.200,0.200,0.700,-0.091,-0.709,-0.200);'

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