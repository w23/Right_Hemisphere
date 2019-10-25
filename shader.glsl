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
	for(int i=0;i<1;++i){
	float T=t,v=0.,dt,dv;
		dt=0.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.967;dv=0.300;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.312;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.467;dv=-0.142;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.533;dv=0.056;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.000;dv=0.474;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=127.700;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=17.267;dv=-1.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=318.033;dv=1.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=9.000;dv=-1.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		Fade = v;
	}	for(int i=0;i<1;++i){
	float T=t,v=0.,dt,dv;
		dt=0.000;dv=300.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=9.000;dv=-71.100;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=34.100;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=11.967;dv=-20.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-109.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=5.967;dv=-47.231;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=90.000;dv=78.462;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		shift11 = v;
	}	for(int i=0;i<1;++i){
	float T=t,v=0.,dt,dv;
		dt=0.000;dv=2.800;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=8.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-0.100;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=1.967;dv=0.100;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=19.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-0.200;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=2.100;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.200;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=36.833;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.200;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.500;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-0.200;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=27.433;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=4.498;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.967;dv=-0.052;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=15.000;dv=-4.246;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.300;dv=2.791;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.200;dv=-0.245;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.167;dv=0.125;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.200;dv=-0.100;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.133;dv=0.025;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=7.000;dv=-1.595;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=5.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-0.400;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.533;dv=0.350;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.333;dv=-0.050;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=1.100;dv=0.100;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		zoomshift = v;
	}	for(int i=0;i<1;++i){
	float T=t,v=0.,dt,dv;
		dt=0.000;dv=3.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=16.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=1.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.967;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-1.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=47.967;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-1.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.500;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=1.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=2.800;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-1.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.633;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=1.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=23.933;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-2.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=23.967;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=1.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		steps = v;
	}	for(int i=0;i<1;++i){
	float T=t,v=0.,dt,dv;
		dt=0.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=96.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=1.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=12.967;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=2.967;dv=-0.100;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.067;dv=0.100;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=5.967;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=2.000;dv=-0.140;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-0.360;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=4.967;dv=-0.200;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-0.300;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=17.267;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=6.600;dv=0.433;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=4.067;dv=0.267;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		greyscale = v;
	}	for(int i=0;i<1;++i){
	float T=t,v=0.,dt,dv;
		dt=0.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=104.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.850;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.700;dv=-0.420;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.267;dv=-0.202;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=4.000;dv=-0.019;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.233;dv=0.199;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.100;dv=0.591;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.367;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=4.300;dv=-0.500;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		greyscale2 = v;
	}	for(int i=0;i<1;++i){
	float T=t,v=0.,dt,dv;
		dt=0.000;dv=86.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=12.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=78.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.967;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-375.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.967;dv=-10.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=385.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.967;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=1.000;dv=-158.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=55.033;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=150.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=7.933;dv=-6.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-28.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=7.967;dv=-4.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-112.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		timeshift = v;
	}	for(int i=0;i<1;++i){
	float T=t,v=0.,dt,dv;
		dt=0.000;dv=-0.500;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=8.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.438;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.967;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-0.308;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.933;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-0.610;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.967;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.480;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=60.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.700;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=7.933;dv=-0.200;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-0.450;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=7.967;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-0.050;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		shiftX = v;
	}	for(int i=0;i<1;++i){
	float T=t,v=0.,dt,dv;
		dt=0.000;dv=-0.500;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=8.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-0.300;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.967;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.300;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.967;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.780;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.967;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-0.780;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=60.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.100;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=7.933;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-0.100;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		shiftY = v;
	}	for(int i=0;i<1;++i){
	float T=t,v=0.,dt,dv;
		dt=0.000;dv=1.400;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=8.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-0.360;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.967;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.160;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.967;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.000;dv=-0.082;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-0.638;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.967;dv=0.020;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.360;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.967;dv=-0.010;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.350;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=6.967;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=46.033;dv=1.180;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-1.680;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=7.933;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.600;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=7.967;dv=-0.150;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.250;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=23.967;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.250;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=24.967;dv=0.550;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=7.967;dv=-0.260;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		zoomXY = v;
	}	for(int i=0;i<1;++i){
	float T=t,v=0.,dt,dv;
		dt=0.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=29.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=2.133;dv=1.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-1.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=2.867;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.400;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.100;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.133;dv=-0.200;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.700;dv=-0.200;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=3.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=30.000;dv=0.714;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-0.454;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.533;dv=0.340;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-0.260;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.900;dv=0.410;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=10.533;dv=0.250;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-1.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=9.933;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.250;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.233;dv=-0.020;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=1.733;dv=-0.230;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=33.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.618;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=1.967;dv=-0.618;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		red = v;
	}	for(int i=0;i<1;++i){
	float T=t,v=0.,dt,dv;
		dt=0.000;dv=15.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=28.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-3.400;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.467;dv=-2.600;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-5.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.500;dv=-4.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=15.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=42.333;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.600;dv=-15.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=15.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		skip = v;
	}	for(int i=0;i<1;++i){
	float T=t,v=0.,dt,dv;
		dt=0.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=52.000;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.350;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.400;dv=-0.250;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.100;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.500;dv=-0.150;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.400;dv=-0.050;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=14.633;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.250;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.533;dv=-0.150;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.100;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=1.200;dv=-0.200;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=1.200;dv=0.000;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.300;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.333;dv=-0.200;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=0.200;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.600;dv=0.700;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.033;dv=-0.091;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.067;dv=-0.709;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
		dt=0.433;dv=-0.200;if(T<dt){v+=T*dv/dt;break;}T-=dt;v+=dv;
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