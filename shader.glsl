// Right Hemisphere 4 kb intro
// by SandS & Jetlag
// https://www.pouet.net/prod.php?which=83559

// watch in fulscreen to enable vsync mode

#version 120
uniform float t;
varying float	w[13]; // array with current envelopes values

float zoom, time;

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
    p = rotate(p, time/29. * r); // rotate over axis x,y,z // rotate over axis x,y,z
    r = max(p - s, -p - s); // differences

    return max(max(r.x,r.y),r.z); // cube distance function
}

void main()
{
		time = t + w[6]; // add timeshift
    zoom = w[2] + smoothstep(120.,180.,time)*.6 - smoothstep(240.,300.,time); // w[2] ~ zoomshift

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
	    vec3(.279052,.261779,.16455) - w[1]/vec3(70.,110.,-180.), // w[1] ~ shift11
	    vec3(.62207, .145751,.537809),
	    vec3(.846801,.8208,  .397094),
	    vec3(.905029,.469421,.400512)
    ),

    xyz, color = vec3(0.), c, grey, // 3d-coordinates, final color, aa-color
    p, r, found1, found2, s = vec3(.5,.5,.001), // moved vector, center, rotation, found square, square size
    norm = vec3(0.), ex = vec3(e,0.,0.), ey = vec3(0.,e,0.), ez = vec3(0.,0.,e);

/* AA preamble */
//aay = 0.17; // antialiasing
//for (int by=0; by<3; by++)
//{
//	aax = 0.17;
//	for (int bx=0; bx<3; bx++)
//{
    //vec2 uv = ((gl_FragCoord.xy + vec2(aax,aay)) / vec2(1920., 1080.) + vec2(w[7],w[8])) / vec2(1., 16./9.) *w[9]; // paremeter[7] ~ shiftX
    //vec2 uv = ((gl_FragCoord.xy + vec2(aax,aay)) / vec2(1280., 720.) + vec2(w[7],w[8])) / vec2(1., 16./9.) *w[9]; // paremeter[7] ~ shiftX
/* end AA preable */
    vec2 uv = (gl_FragCoord.xy / vec2(1280., 720.) + vec2(w[7],w[8])) / vec2(1., 16./9.) *w[9]; // paremeter[7] ~ shiftX

// raymarching
	l = 1.;
    xyz = normalize(vec3(uv, 1.)); // view direction


    for (int i=0; i<5; i++) // trace to bounding sphere for the faster computation
    {
        if (i>=int(w[3])) break; // w[3] ~ steps
		d = 26.; // distance
	    for (int j=0; j<15; j++) if(j!=int(w[11])) // w[11] ~ skip
	    {
	        c = massive[j]*4.-vec3(2.);
	        c.z = ( c.z + zoom ) * 4.;
	        d = min( d, length(xyz*l - c)-0.71 ); // sphere distance function
	    }
        l += d;
        if (l>26.) break;
    }

    
    if (l<26.)
    {
       if (mod(uv.y,.08)<.04) l-=w[12]; // w[12] ~ distort
        xyz *= l; // actual point
        
	    d = 26.;
	    for (int j=0; j<15; j++)
	    {
	        c = massive[j]*4.-vec3(2.);
	        found1 = c;
	        r = c;
	        c.z = ( c.z + zoom ) * 4.;
	        p = xyz - c; // move square to 0,0,0
	        p = rotate(p, time/29. * r); // rotate over axis x,y,z
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

    
    c = vec3(norm.xy,1.-l/20.);
    c+= vec3(0.,c.x,c.y/2.); // colour correction
    color += clamp(c, 0., 1.); // accumulate aa-color

		/* AA
    aax += .33; // end of antialiasing loop
}
    aay += .33;
}
    color /= 9.; // normalize aa-color
		*/


    color = (1.-w[4])*color + vec3(color.x+color.z*w[5]) * w[4]; // w[4] ~ greyscale
	color.xz+=w[10]*vec2(abs(norm.y),color.z/4.); // w[10] ~ red
    
    gl_FragColor = vec4(color * w[0], 1.); // w[0] ~ fade
}
