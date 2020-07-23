// Right Hemisphere 4 kb intro
// by SandS & Jetlag
// https://www.pouet.net/prod.php?which=83559

// watch in fulscreen to enable vsync mode


precision highp float;

#define maxZ 26.

#define fps 60.

#define LastFrame 9180
#define totalEnvelopes 13 // number of envelopes used


int ef[]=int[215] // envelope data: key frames numbers
(
    0,239,240,268,300,480,8142,LastFrame, // fade
    0,180,720,721,1440,1441,1800,7200,7680,8294,LastFrame, // shift11
    0,480,481,600,1740,1742,1868,1870,4080,4082,4112,4114,5760,5761,5820,6720,6738,6750,6760,6772,6780,7200,7500,7502,7534,7554,7620,LastFrame, // zoomshift
	0,960,961,1200,1201,4080,4081,4112,4113,4282,4283,4322,4323,5760,5761,7200,7201,LastFrame, // steps
    0,5760,5761,6540,6718,6722,7080,7200,7202,7500,7501,8538,LastFrame, // greyscale
    0,6240,6242,6284,6480,6720,6734,6740,6942,7200,LastFrame, // greyscale2
    0,720,721,960,961,1200,1201,1440,1500,4802,4803,5280,5281,5760,5761,LastFrame, // timeshift
    0,480,481,720,721,960,961,1200,1201,4802,4803,5280,5281,5760,5761,LastFrame, // shiftX
    0,480,481,720,721,960,961,1200,1201,4802,4803,5280,5281,LastFrame, // shiftY
    0,480,481,720,721,780,960,961,1200,1201,1440,1441,2040,4802,4803,5280,5281,5760,5761,7200,7201,8700,LastFrame, // zoomXY
    0,1740,1868,1870,2042,2044,2050,2058,2100,2280,4080,4082,4114,4116,4170,4802,4803,5400,5402,5416,5520,7500,7502,7620,LastFrame, // red
    0,1680,1681,1692,1722,1740,1741,4284,4320,4322,LastFrame, // skip
    0,3120,3122,3146,3148,3178,3202,4080,4082,4114,4116,4188,4260,4262,4282,4284,4320,4322,4326,4352,LastFrame // distort
);

float ev[]=float[215] // envelope data: nodes values
(
    0.,.3,.6,.47,.53,1.,1.,0., // fade
    300.,300.,228.9,263.,243.,134.,86.77,165.23,160.,148.53867,133., // shift11
    2.8,2.8,2.7,2.8,2.8,2.6,2.5,2.8,2.8,3.,3.,2.8,2.8,7.298,7.246,3.,5.79,5.545,5.67,5.57,5.595,4.,4.,3.6,3.95,3.9,4.,4., // zoomshift
    3.,3.,4.,4.,3.,3.,2.,2.,3.,3.,2.,2.,3.,3.,1.,1.,2.,2., // steps
    0.,0.,1.,1.,.9,1.,1.,.86,.5,.3,0.,0.,.7, // greyscale
    0.,0.,.85,.43,.23,.21,.4,1.,1.,.5,.5, // greyscale2
    86.,86.,164.,164.,-211.,-221.,164.,164.,6.,6.,156.,150.,122.,118.,6.,6., // timeshift
    -.5,-.5,-.062,-.062,-.37,-.37,-.98,-.98,-.5,-.5,.2,0.,-.45,-.45,-.5,-.5, // shiftX
    -.5,-.5,-.8,-.8,-.5,-.5,.28,.28,-.5,-.5,-.4,-.4,-.5,-.5, // shiftY
    1.4,1.4,1.04,1.04,1.2,1.2,1.12,.48,.5,.86,.85,1.2,1.2,2.38,.7,.7,1.3,1.15,1.4,1.4,1.65,2.2,1.94, // zoomXY
    0.,0.,1.,0.,0.,.4,.4,.2,0.,0.,.7,.26,.6,.34,.75,1.,0.,0.,.25,.23,0.,0.,.6,0.,0., // red
    15.,15.,14.,14.,0.,0.,15.,15.,0.,15.,15., // skip
    0.,0.,.35,.1,.2,.05,0.,0.,.25,.1,.2,0.,0.,.3,.1,.3,1.,.9,.2,0.,0. // distort
),
	parameter[totalEnvelopes], // array with current envelopes values
    zoom, t;


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


void mainImage(out vec4 outcolor, vec2 fragCoord)
{

    t = iTime;
	for (int i=0, j=0; i<totalEnvelopes; i++) // fill parameter[] with current envelopes values
    {
		for (; j<216; j++) if(ef[j+1]>=int(t*fps)) break;
		parameter[i] = mix(ev[j], ev[j+1], (t*fps - float(ef[j])) / float(ef[j+1] - ef[j]) );
        for (; j<216; j++) if(ef[j+1]==0) break;
    }
    t += parameter[6]; // add timeshift


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
    coordVar = fragCoord / iResolution.xy;
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
        if (l>maxZ) break;
    }

    
    if (l<maxZ)
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
    
    outcolor = vec4(color * parameter[0], 1.); // parameter[0] ~ fade
}
