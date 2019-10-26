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
		float T=t,v=0.,dtt[10]=DTT0_,dvt[10]=DVT0_;
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
		float T=t,v=0.,dtt[8]=DTT1_,dvt[8]=DVT1_;
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
		float T=t,v=0.,dtt[27]=DTT2_,dvt[27]=DVT2_;
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
		float T=t,v=0.,dtt[17]=DTT3_,dvt[17]=DVT3_;
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
		float T=t,v=0.,dtt[14]=DTT4_,dvt[14]=DVT4_;
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
		float T=t,v=0.,dtt[10]=DTT5_,dvt[10]=DVT5_;
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
		float T=t,v=0.,dtt[15]=DTT6_,dvt[15]=DVT6_;
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
		float T=t,v=0.,dtt[16]=DTT7_,dvt[16]=DVT7_;
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
		float T=t,v=0.,dtt[13]=DTT8_,dvt[13]=DVT8_;
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
		float T=t,v=0.,dtt[24]=DTT9_,dvt[24]=DVT9_;
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
		float T=t,v=0.,dtt[24]=DTT10_,dvt[24]=DVT10_;
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
		float T=t,v=0.,dtt[10]=DTT11_,dvt[10]=DVT11_;
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
		float T=t,v=0.,dtt[20]=DTT12_,dvt[20]=DVT12_;
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