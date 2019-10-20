// Right Hemisphere intro


uniform vec2 R_;
uniform float t, Fade, shift11, zoomshift, steps, greyscale, greyscale2;


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


float spheres(vec3 o)
{
    vec3 c; // moved vector, center, rotation
    float d=26.; // distance

    for (int i=0; i<15; i++)
    {
        c = massive[i];
        c.z = ( c.z + zoom ) * 4.;
        d = min( d, length(o - c)-0.71 ); // sphere distance function
    }
    return d;
}


vec3 findSquare(vec3 o)
{
    vec3 p, c, r, found1, found2; // moved vector, center, rotation, found square
    vec3 s = vec3(.5,.5,.001); // square size
    float d=26., d2; // distance

    for (int i=0; i<15; i++)
    {
        c = massive[i];
        found1 = c;
        r = c;
        c.z = ( c.z + zoom ) * 4.;
        p = o - c; // move square to 0,0,0
        p = rotate(p, (t+6.)/29. * r); // rotate over axis x,y,z
        r = max(p - s, -p - s); // differences
        d2 = max(max(r.x,r.y),r.z); // cube distance function
        if (d2 < d)
        {
            d = d2;
            found2 = found1;
        }
    }
    return found2;
}

float squareSingle(vec3 o, vec3 c) // input: ray position, square center
{
    vec3 p, r; // moved vector, rotation
    vec3 s = vec3(.5,.5,.001); // square size

    r = c;
    c.z = ( c.z + zoom ) * 4.;
    p = o - c; // move square to 0,0,0
    p = rotate(p, (t+6.)/29. * r); // rotate over axis x,y,z
    r = max(p - s, -p - s); // differences

    return max(max(r.x,r.y),r.z); // cube distance function
}


void main()
{
  
    zoom = zoomshift + smoothstep(120.,180.,t+6.)*.6 - smoothstep(240.,300.,t+6.);
    
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


    vec3 xyz, color = vec3(0.), c, grey; // 3d-coordinates, final color, aa-color
    
//float aay = 0.17; // antialiasing
//for (int by=0; by<3; by++)
//{
//	float aax = 0.17;
//	for (int bx=0; bx<3; bx++)
//	{
    vec2 uv = ((gl_FragCoord.xy/R_)  - vec2(.5)) / vec2(1., 16./9.) *1.4;
//	vec2 uv = ((gl_FragCoord.xy/R_)  + vec2(aax,aay)  - vec2(.5)) / vec2(1., 16./9.) *1.4;

// raymarching
    xyz = normalize(vec3(uv, 1.)); // view direction
    
    float l = 1., d, e = .0001; // ray length, current distance, epsilon
    vec3 norm = vec3(0.,0.,0.),
         ex = vec3(e,0.,0.), ey = vec3(0.,e,0.), ez = vec3(0.,0.,e);

    for (int i=0; i<3; i++) // trace to bounding sphere for the faster computation
    {
        d = spheres(xyz*l);
        if (d<e) break;
        l += d;
        if (l>26.) break;
        if (steps<2.) break;
    }

    if (l<26.)
    {
        xyz *= l; // actual point
        c = findSquare(xyz); // find a square at the actual point
        norm = normalize(vec3(
        squareSingle(xyz+ex,c)-squareSingle(xyz-ex,c),
        squareSingle(xyz+ey,c)-squareSingle(xyz-ey,c),
        squareSingle(xyz+ez,c)-squareSingle(xyz-ez,c)));
	}

    
    c = vec3(norm.xy,vec3(1.-l/20.));

    c.z+=c.y/2.; c.y=c.y+c.x; // colour correction

    color += clamp(c, 0., 1.); // accumulate aa-color

//    aax += .33; // end of antialiasing loop 
// 	}
//    aay += .33;
//}  
//    color /= 9.; // normalize aa-color

    grey = vec3(color.r+color.b*greyscale2);
    color = (1.-greyscale)*color+grey*greyscale;

    gl_FragColor = vec4(color * Fade, 1.);
}
