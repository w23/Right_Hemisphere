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
	float T, v;
#define Q(a,b) if(T<a){v+=T*b/a;break;}T-=a;v+=b
	T=t;v=0.;
	for(int i=0;i<1;++i){
	Q(0.000, 0.000);
	Q(3.967, 0.300);
	Q(0.033, 0.312);
	Q(0.467, -0.142);
	Q(0.533, 0.056);
	Q(3.000, 0.474);
	Q(127.700, 0.000);
	Q(17.267, -1.000);
	Q(318.033, 1.000);
	Q(9.000, -1.000);
	}
	Fade = v;
	T=t;v=0.;
	for(int i=0;i<1;++i){
	Q(0.000, 300.000);
	Q(3.000, 0.000);
	Q(9.000, -71.100);
	Q(0.033, 34.100);
	Q(11.967, -20.000);
	Q(0.033, -109.000);
	Q(5.967, -47.231);
	Q(90.000, 78.462);
	}
	shift11 = v;
	T=t;v=0.;
	for(int i=0;i<1;++i){
	Q(0.000, 2.800);
	Q(8.000, 0.000);
	Q(0.033, -0.100);
	Q(1.967, 0.100);
	Q(19.000, 0.000);
	Q(0.033, -0.200);
	Q(2.100, 0.000);
	Q(0.033, 0.200);
	Q(36.833, 0.000);
	Q(0.033, 0.200);
	Q(0.500, 0.000);
	Q(0.033, -0.200);
	Q(27.433, 0.000);
	Q(0.033, 4.498);
	Q(0.967, -0.052);
	Q(15.000, -4.246);
	Q(0.300, 2.791);
	Q(0.200, -0.245);
	Q(0.167, 0.125);
	Q(0.200, -0.100);
	Q(0.133, 0.025);
	Q(7.000, -1.595);
	Q(5.000, 0.000);
	Q(0.033, -0.400);
	Q(0.533, 0.350);
	Q(0.333, -0.050);
	Q(1.100, 0.100);
	}
	zoomshift = v;
	T=t;v=0.;
	for(int i=0;i<1;++i){
	Q(0.000, 3.000);
	Q(16.000, 0.000);
	Q(0.033, 1.000);
	Q(3.967, 0.000);
	Q(0.033, -1.000);
	Q(47.967, 0.000);
	Q(0.033, -1.000);
	Q(0.500, 0.000);
	Q(0.033, 1.000);
	Q(2.800, 0.000);
	Q(0.033, -1.000);
	Q(0.633, 0.000);
	Q(0.033, 1.000);
	Q(23.933, 0.000);
	Q(0.033, -2.000);
	Q(23.967, 0.000);
	Q(0.033, 1.000);
	}
	steps = v;
	T=t;v=0.;
	for(int i=0;i<1;++i){
	Q(0.000, 0.000);
	Q(96.000, 0.000);
	Q(0.033, 1.000);
	Q(12.967, 0.000);
	Q(2.967, -0.100);
	Q(0.067, 0.100);
	Q(5.967, 0.000);
	Q(2.000, -0.140);
	Q(0.033, -0.360);
	Q(4.967, -0.200);
	Q(0.033, -0.300);
	Q(17.267, 0.000);
	Q(6.600, 0.433);
	Q(4.067, 0.267);
	}
	greyscale = v;
	T=t;v=0.;
	for(int i=0;i<1;++i){
	Q(0.000, 0.000);
	Q(104.000, 0.000);
	Q(0.033, 0.850);
	Q(0.700, -0.420);
	Q(3.267, -0.202);
	Q(4.000, -0.019);
	Q(0.233, 0.199);
	Q(0.100, 0.591);
	Q(3.367, 0.000);
	Q(4.300, -0.500);
	}
	greyscale2 = v;
	T=t;v=0.;
	for(int i=0;i<1;++i){
	Q(0.000, 86.000);
	Q(12.000, 0.000);
	Q(0.033, 78.000);
	Q(3.967, 0.000);
	Q(0.033, -375.000);
	Q(3.967, -10.000);
	Q(0.033, 385.000);
	Q(3.967, 0.000);
	Q(1.000, -158.000);
	Q(55.033, 0.000);
	Q(0.033, 150.000);
	Q(7.933, -6.000);
	Q(0.033, -28.000);
	Q(7.967, -4.000);
	Q(0.033, -112.000);
	}
	timeshift = v;
	T=t;v=0.;
	for(int i=0;i<1;++i){
	Q(0.000, -0.500);
	Q(8.000, 0.000);
	Q(0.033, 0.438);
	Q(3.967, 0.000);
	Q(0.033, -0.308);
	Q(3.933, 0.000);
	Q(0.033, 0.000);
	Q(0.033, -0.610);
	Q(3.967, 0.000);
	Q(0.033, 0.480);
	Q(60.000, 0.000);
	Q(0.033, 0.700);
	Q(7.933, -0.200);
	Q(0.033, -0.450);
	Q(7.967, 0.000);
	Q(0.033, -0.050);
	}
	shiftX = v;
	T=t;v=0.;
	for(int i=0;i<1;++i){
	Q(0.000, -0.500);
	Q(8.000, 0.000);
	Q(0.033, -0.300);
	Q(3.967, 0.000);
	Q(0.033, 0.300);
	Q(3.967, 0.000);
	Q(0.033, 0.780);
	Q(3.967, 0.000);
	Q(0.033, -0.780);
	Q(60.000, 0.000);
	Q(0.033, 0.100);
	Q(7.933, 0.000);
	Q(0.033, -0.100);
	}
	shiftY = v;
	T=t;v=0.;
	for(int i=0;i<1;++i){
	Q(0.000, 1.400);
	Q(8.000, 0.000);
	Q(0.033, -0.360);
	Q(3.967, 0.000);
	Q(0.033, 0.160);
	Q(0.967, 0.000);
	Q(3.000, -0.082);
	Q(0.033, -0.638);
	Q(3.967, 0.020);
	Q(0.033, 0.360);
	Q(3.967, -0.010);
	Q(0.033, 0.350);
	Q(6.967, 0.000);
	Q(3.000, 0.000);
	Q(46.033, 1.180);
	Q(0.033, -1.680);
	Q(7.933, 0.000);
	Q(0.033, 0.600);
	Q(7.967, -0.150);
	Q(0.033, 0.250);
	Q(23.967, 0.000);
	Q(0.033, 0.250);
	Q(24.967, 0.550);
	Q(7.967, -0.260);
	}
	zoomXY = v;
	T=t;v=0.;
	for(int i=0;i<1;++i){
	Q(0.000, 0.000);
	Q(29.000, 0.000);
	Q(2.133, 1.000);
	Q(0.033, -1.000);
	Q(2.867, 0.000);
	Q(0.033, 0.400);
	Q(0.100, 0.000);
	Q(0.133, -0.200);
	Q(0.700, -0.200);
	Q(3.000, 0.000);
	Q(30.000, 0.714);
	Q(0.033, -0.454);
	Q(0.533, 0.340);
	Q(0.033, -0.260);
	Q(0.900, 0.410);
	Q(10.533, 0.250);
	Q(0.033, -1.000);
	Q(9.933, 0.000);
	Q(0.033, 0.250);
	Q(0.233, -0.020);
	Q(1.733, -0.230);
	Q(33.000, 0.000);
	Q(0.033, 0.618);
	Q(1.967, -0.618);
	}
	red = v;
	T=t;v=0.;
	for(int i=0;i<1;++i){
	Q(0.000, 15.000);
	Q(28.000, 0.000);
	Q(0.033, -3.400);
	Q(0.467, -2.600);
	Q(0.033, -5.000);
	Q(0.500, -4.000);
	Q(0.033, 15.000);
	Q(42.333, 0.000);
	Q(0.600, -15.000);
	Q(0.033, 15.000);
	}
	skip = v;
	T=t;v=0.;
	for(int i=0;i<1;++i){
	Q(0.000, 0.000);
	Q(52.000, 0.000);
	Q(0.033, 0.350);
	Q(0.400, -0.250);
	Q(0.033, 0.100);
	Q(0.500, -0.150);
	Q(0.400, -0.050);
	Q(14.633, 0.000);
	Q(0.033, 0.250);
	Q(0.533, -0.150);
	Q(0.033, 0.100);
	Q(1.200, -0.200);
	Q(1.200, 0.000);
	Q(0.033, 0.300);
	Q(0.333, -0.200);
	Q(0.033, 0.200);
	Q(0.600, 0.700);
	Q(0.033, -0.091);
	Q(0.067, -0.709);
	Q(0.433, -0.200);
	}
	distort = v;

  
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