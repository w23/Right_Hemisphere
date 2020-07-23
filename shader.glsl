// Right Hemisphere 4 kb intro
// by SandS & Jetlag
// https://www.pouet.net/prod.php?which=83559

// watch in fulscreen to enable vsync mode

#version 120
//precision highp float;
uniform float t;

varying float	parameter[13]; // array with current envelopes values

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


float squareSingle(vec3 o, vec3 c) // input: ray position, square center
{
    vec3 p, r; // moved vector, rotation
    vec3 s = vec3(.5,.5,.001); // square size

    r = c;
    c.z = ( c.z + zoom ) * 4.;
    p = o - c; // move square to 0,0,0
    p = rotate(p, t/29. * r); // rotate over axis x,y,z // rotate over axis x,y,z
    r = max(p - s, -p - s); // differences

    return max(max(r.x,r.y),r.z); // cube distance function
}

void main()
{
   /* FIXME */  // t += parameter[6]; // add timeshift

    zoom = parameter[2] + smoothstep(120.,180.,t)*.6 - smoothstep(240.,300.,t); // parameter[2] ~ zoomshift

    float l, d, d2, e = .0001, aax, aay = 0.17; // ray length, current distance, epsilon, anti-aliasing

    // objects coordinates
    vec3 massive[] = vec3[15]
    (
	    vec3(.044677,.928527,.337524),
	    vec3(.520019,.026367,.486328),
	    vec3(.026125,.984497,.337249),
	    vec3(.635498,.42041, .41748),
	    vec3(.558349,.929687,.849609),
	    vec3(.840576,.539917,.436889),
	    vec3(.096557,.049438,.537475),
	    vec3(.439819,.906127,.853759),
	    vec3(.291748,.75415, .479736),
	    vec3(.572753,.774047,.402343),
	    vec3(.565551,.614624,.542602),
	    vec3(.279052,.261779,.16455) - parameter[1]/vec3(70.,110.,-180.), // parameter[1] ~ shift11
	    vec3(.62207, .145751,.537809),
	    vec3(.846801,.8208,  .397094),
	    vec3(.905029,.469421,.400512)
    ),

    xyz, color = vec3(0.), c, grey, // 3d-coordinates, final color, aa-color
    p, r, found1, found2, s = vec3(.5,.5,.001), // moved vector, center, rotation, found square, square size
    norm = vec3(0.), ex = vec3(e,0.,0.), ey = vec3(0.,e,0.), ez = vec3(0.,0.,e);

    vec2 coordVar, uv;
    
//aay = 0.17; // antialiasing
//for (int by=0; by<3; by++)
//{
//	aax = 0.17;
//	for (int bx=0; bx<3; bx++)
//{
//	coordVar = (fragCoord + vec2(aax,aay)) / iResolution.xy;
    coordVar = gl_FragCoord.xy / vec2(1920., 1080.);
    uv = (coordVar + vec2(parameter[7],parameter[8])) / vec2(1., 16./9.) *parameter[9]; // paremeter[7] ~ shiftX

// raymarching
	l = 1.;
    xyz = normalize(vec3(uv, 1.)); // view direction


    for (int i=0; i<5; i++) // trace to bounding sphere for the faster computation
    {
        if (i>=int(parameter[3])) break; // parameter[3] ~ steps
		d = 26.; // distance
	    for (int j=0; j<15; j++) if(j!=int(4.))
	    {
	        c = massive[j]*4.-vec3(2.);
	        c.z = ( c.z + zoom ) * 4.;
	        d = min( d, length(xyz*l - c)-0.71 ); // sphere distance function
	    }
//        if (d<e) break;
        l += d;
        if (l>26.) break;
    }

    
    if (l<26.)
    {
       if (mod(uv.y,.08)<.04) l-=parameter[12]; // parameter[12] ~ distort
        xyz *= l; // actual point
        
	    d = 26.;
	    for (int j=0; j<15; j++)
	    {
	        c = massive[j]*4.-vec3(2.);
	        found1 = c;
	        r = c;
	        c.z = ( c.z + zoom ) * 4.;
	        p = xyz - c; // move square to 0,0,0
	        p = rotate(p, t/29. * r); // rotate over axis x,y,z
	        r = max(p - s, -p - s); // differences
	        d2 = max(max(r.x,r.y),r.z); // cube distance function
	        if (d2 < d)
	        {
	            d = d2;
	            found2 = found1;
	        }
	    }        
//        c = findSquare(xyz); // find a square at the actual point
        norm = normalize(vec3(
        squareSingle(xyz+ex,found2)-squareSingle(xyz-ex,found2),
        squareSingle(xyz+ey,found2)-squareSingle(xyz-ey,found2),
        squareSingle(xyz+ez,found2)-squareSingle(xyz-ez,found2)));
	}

    
    c = vec3(norm.xy,1.-l/20.);
    c+= vec3(0.,c.r,c.g/2.); // colour correction
//    c.b+=c.g/2.; c.g=c.g+c.r; // colour correction
    color += clamp(c, 0., 1.); // accumulate aa-color

//    aax += .33; // end of antialiasing loop 
//}
//    aay += .33;
//}  
//    color /= 9.; // normalize aa-color


    color = (1.-parameter[4])*color + vec3(color.r+color.b*parameter[5]) * parameter[4]; // parameter[4] ~ greyscale
	color.xz+=parameter[10]*vec2(abs(norm.y),color.b/4.); // parameter[10] ~ red
    
    gl_FragColor = vec4(color * parameter[0], 1.); // parameter[0] ~ fade
}
