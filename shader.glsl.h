/* File generated with Shader Minifier 1.1.4
 * http://www.ctrl-alt-test.fr
 */
#ifndef SHADER_GLSL_H_
# define SHADER_GLSL_H_
# define VAR_T "l"

const char *shader_glsl =
 "#version 120\n"
 "float y,D,v,i,k,z,f,m,x,r,c,a,n;"
 "uniform float l;"
 "vec3 b[16];"
 "float s;"
 "vec3 p(vec3 l,vec3 i)"
 "{"
   "vec3 v=sin(i),f=cos(i);"
   "return l*mat3(f.y,v.z*v.y,-v.y*f.z,-v.x*v.y,f.x*f.z+v.x*v.z*f.y,v.z*f.x-v.x*f.z*f.y,f.x*v.y,v.x*f.z-f.x*v.z*f.y,v.z*v.x+f.x*f.z*f.y);"
 "}"
 "vec3 p(float i,float l,float z)"
 "{"
   "return vec3(i*4.-2.,l*4.-2.,z*4.-2.);"
 "}"
 "float e(vec3 D,vec3 v)"
 "{"
   "vec3 b,i,y=vec3(.5,.5,.001);"
   "i=v;"
   "v.z=(v.z+s)*4.;"
   "b=D-v;"
   "b=p(b,(l+f)/29.*i);"
   "i=max(b-y,-b-y);"
   "return max(max(i.x,i.y),i.z);"
 "}"
 "void main()"
 "{"
   "{"
     "float g=l,o=0.,t[10]=float[](0.,3.9666667,0.0333333,0.4666667,0.5333333,3.,127.7,17.2666667,318.0333333,9.),T[10]=float[](0.,0.3,0.3118975,-0.1418975,0.0561538,0.4738462,0.,-1.,1.,-1.);"
     "for(int u=0;u<10;++u)"
       "{"
         "if(g<t[u])"
           "{"
             "o+=T[u]*g/t[u];"
             "break;"
           "}"
         "o+=T[u];"
         "g-=t[u];"
       "}"
     "y=o;"
   "}"
   "{"
     "float g=l,o=0.,t[8]=float[](0.,3.,9.,0.0333333,11.9666667,0.0333333,5.9666667,90.),T[8]=float[](300.,0.,-71.1,34.1,-20.,-109.,-47.2307692,78.4615385);"
     "for(int u=0;u<8;++u)"
       "{"
         "if(g<t[u])"
           "{"
             "o+=T[u]*g/t[u];"
             "break;"
           "}"
         "o+=T[u];"
         "g-=t[u];"
       "}"
     "D=o;"
   "}"
   "{"
     "float g=l,o=0.,t[27]=float[](0.,8.,0.0333333,1.9666667,19.,0.0333333,2.1,0.0333333,36.8333333,0.0333333,0.5,0.0333333,27.4333333,0.0333333,0.9666667,15.,0.3,0.2,0.1666667,0.2,0.1333333,7.,5.,0.0333333,0.5333333,0.3333333,1.1),T[27]=float[](2.8,0.,-0.1,0.1,0.,-0.2,0.,0.2,0.,0.2,0.,-0.2,0.,4.498,-0.0515385,-4.2464615,2.7905856,-0.2453174,0.1246057,-0.0996845,0.0249211,-1.5951104,0.,-0.4,0.35,-0.05,0.1);"
     "for(int u=0;u<27;++u)"
       "{"
         "if(g<t[u])"
           "{"
             "o+=T[u]*g/t[u];"
             "break;"
           "}"
         "o+=T[u];"
         "g-=t[u];"
       "}"
     "v=o;"
   "}"
   "{"
     "float g=l,o=0.,t[17]=float[](0.,16.,0.0333333,3.9666667,0.0333333,47.9666667,0.0333333,0.5,0.0333333,2.8,0.0333333,0.6333333,0.0333333,23.9333333,0.0333333,23.9666667,0.0333333),T[17]=float[](3.,0.,1.,0.,-1.,0.,-1.,0.,1.,0.,-1.,0.,1.,0.,-2.,0.,1.);"
     "for(int u=0;u<17;++u)"
       "{"
         "if(g<t[u])"
           "{"
             "o+=T[u]*g/t[u];"
             "break;"
           "}"
         "o+=T[u];"
         "g-=t[u];"
       "}"
     "i=o;"
   "}"
   "{"
     "float g=l,o=0.,t[14]=float[](0.,96.,0.0333333,12.9666667,2.9666667,0.0666667,5.9666667,2.,0.0333333,4.9666667,0.0333333,17.2666667,6.6,4.0666667),T[14]=float[](0.,0.,1.,0.,-0.1,0.1,0.,-0.14,-0.36,-0.2,-0.3,0.,0.433125,0.266875);"
     "for(int u=0;u<14;++u)"
       "{"
         "if(g<t[u])"
           "{"
             "o+=T[u]*g/t[u];"
             "break;"
           "}"
         "o+=T[u];"
         "g-=t[u];"
       "}"
     "k=o;"
   "}"
   "{"
     "float g=l,o=0.,t[10]=float[](0.,104.,0.0333333,0.7,3.2666667,4.,0.2333333,0.1,3.3666667,4.3),T[10]=float[](0.,0.,0.8501577,-0.4195584,-0.2018927,-0.0189274,0.1987382,0.5914826,0.,-0.5);"
     "for(int u=0;u<10;++u)"
       "{"
         "if(g<t[u])"
           "{"
             "o+=T[u]*g/t[u];"
             "break;"
           "}"
         "o+=T[u];"
         "g-=t[u];"
       "}"
     "z=o;"
   "}"
   "{"
     "float g=l,o=0.,t[15]=float[](0.,12.,0.0333333,3.9666667,0.0333333,3.9666667,0.0333333,3.9666667,1.,55.0333333,0.0333333,7.9333333,0.0333333,7.9666667,0.0333333),T[15]=float[](86.,0.,78.,0.,-375.,-10.,385.,0.,-158.,0.,150.,-6.,-28.,-4.,-112.);"
     "for(int u=0;u<15;++u)"
       "{"
         "if(g<t[u])"
           "{"
             "o+=T[u]*g/t[u];"
             "break;"
           "}"
         "o+=T[u];"
         "g-=t[u];"
       "}"
     "f=o;"
   "}"
   "{"
     "float g=l,o=0.,t[16]=float[](0.,8.,0.0333333,3.9666667,0.0333333,3.9333333,0.0333333,0.0333333,3.9666667,0.0333333,60.,0.0333333,7.9333333,0.0333333,7.9666667,0.0333333),T[16]=float[](-0.5,0.,0.438,0.,-0.308,0.,0.,-0.61,0.,0.48,0.,0.7,-0.2,-0.45,0.,-0.05);"
     "for(int u=0;u<16;++u)"
       "{"
         "if(g<t[u])"
           "{"
             "o+=T[u]*g/t[u];"
             "break;"
           "}"
         "o+=T[u];"
         "g-=t[u];"
       "}"
     "m=o;"
   "}"
   "{"
     "float g=l,o=0.,t[13]=float[](0.,8.,0.0333333,3.9666667,0.0333333,3.9666667,0.0333333,3.9666667,0.0333333,60.,0.0333333,7.9333333,0.0333333),T[13]=float[](-0.5,0.,-0.3,0.,0.3,0.,0.78,0.,-0.78,0.,0.1,0.,-0.1);"
     "for(int u=0;u<13;++u)"
       "{"
         "if(g<t[u])"
           "{"
             "o+=T[u]*g/t[u];"
             "break;"
           "}"
         "o+=T[u];"
         "g-=t[u];"
       "}"
     "x=o;"
   "}"
   "{"
     "float g=l,o=0.,t[24]=float[](0.,8.,0.0333333,3.9666667,0.0333333,0.9666667,3.,0.0333333,3.9666667,0.0333333,3.9666667,0.0333333,6.9666667,3.,46.0333333,0.0333333,7.9333333,0.0333333,7.9666667,0.0333333,23.9666667,0.0333333,24.9666667,7.9666667),T[24]=float[](1.4,0.,-0.36,0.,0.16,0.,-0.0818182,-0.6381818,0.02,0.36,-0.01,0.35,0.,0.,1.18,-1.68,0.,0.6,-0.15,0.25,0.,0.25,0.55,-0.26);"
     "for(int u=0;u<24;++u)"
       "{"
         "if(g<t[u])"
           "{"
             "o+=T[u]*g/t[u];"
             "break;"
           "}"
         "o+=T[u];"
         "g-=t[u];"
       "}"
     "r=o;"
   "}"
   "{"
     "float g=l,o=0.,t[24]=float[](0.,29.,2.1333333,0.0333333,2.8666667,0.0333333,0.1,0.1333333,0.7,3.,30.,0.0333333,0.5333333,0.0333333,0.9,10.5333333,0.0333333,9.9333333,0.0333333,0.2333333,1.7333333,33.,0.0333333,1.9666667),T[24]=float[](0.,0.,1.,-1.,0.,0.4,0.,-0.2,-0.2,0.,0.714,-0.454,0.34,-0.26,0.41,0.25,-1.,0.,0.25,-0.02,-0.23,0.,0.6184615,-0.6184615);"
     "for(int u=0;u<24;++u)"
       "{"
         "if(g<t[u])"
           "{"
             "o+=T[u]*g/t[u];"
             "break;"
           "}"
         "o+=T[u];"
         "g-=t[u];"
       "}"
     "c=o;"
   "}"
   "{"
     "float g=l,o=0.,t[10]=float[](0.,28.,0.0333333,0.4666667,0.0333333,0.5,0.0333333,42.3333333,0.6,0.0333333),T[10]=float[](15.,0.,-3.4,-2.6,-5.,-4.,15.,0.,-15.,15.);"
     "for(int u=0;u<10;++u)"
       "{"
         "if(g<t[u])"
           "{"
             "o+=T[u]*g/t[u];"
             "break;"
           "}"
         "o+=T[u];"
         "g-=t[u];"
       "}"
     "a=o;"
   "}"
   "{"
     "float g=l,o=0.,t[20]=float[](0.,52.,0.0333333,0.4,0.0333333,0.5,0.4,14.6333333,0.0333333,0.5333333,0.0333333,1.2,1.2,0.0333333,0.3333333,0.0333333,0.6,0.0333333,0.0666667,0.4333333),T[20]=float[](0.,0.,0.35,-0.25,0.1,-0.15,-0.05,0.,0.25,-0.15,0.1,-0.2,0.,0.3,-0.2,0.2,0.7,-0.0910528,-0.7089472,-0.2);"
     "for(int u=0;u<20;++u)"
       "{"
         "if(g<t[u])"
           "{"
             "o+=T[u]*g/t[u];"
             "break;"
           "}"
         "o+=T[u];"
         "g-=t[u];"
       "}"
     "n=o;"
   "}"
   "s=v+smoothstep(120.,180.,l+f)*.6-smoothstep(240.,300.,l+f);"
   "b[0]=p(.044677,.928527,.337524);"
   "b[1]=p(.520019,.026367,.486328);"
   "b[2]=p(.026125,.984497,.337249);"
   "b[3]=p(.635498,.42041,.41748);"
   "b[4]=p(.558349,.929687,.849609);"
   "b[5]=p(.840576,.539917,.436889);"
   "b[6]=p(.096557,.049438,.537475);"
   "b[7]=p(.439819,.906127,.853759);"
   "b[8]=p(.291748,.75415,.479736);"
   "b[9]=p(.572753,.774047,.402343);"
   "b[10]=p(.565551,.614624,.542602);"
   "b[11]=p(.279052,.261779,.26455);"
   "b[12]=p(.62207,.145751,.537809);"
   "b[13]=p(.846801,.8208,.397094);"
   "b[14]=p(.905029,.469421,.400512);"
   "b[15]=p(.725585,.835769,.054077);"
   "b[11]-=D/vec3(70.,110.,-180.);"
   "float g,u,o,t=.0001,T,V=.00015;"
   "vec3 h,d=vec3(0.),F,C,Z,Y,X,W=vec3(.5,.5,.001),U=vec3(0.,0.,0.),S=vec3(t,0.,0.),R=vec3(0.,t,0.),Q=vec3(0.,0.,t);"
   "for(int P=0;P<3;P++)"
     "{"
       "T=.00015;"
       "for(int O=0;O<3;O++)"
         "{"
           "vec2 N=(gl_FragCoord.xy/vec2(1920.,1080.)+vec2(T,V)+vec2(m,x))/vec2(1.,16./9.)*r;"
           "g=1.;"
           "h=normalize(vec3(N,1.));"
           "for(int M=0;M<5;M++)"
             "{"
               "if(M>=int(i))"
                 "break;"
               "u=26.;"
               "for(int L=0;L<15;L++)"
                 "if(L!=int(a))"
                   "F=b[L],F.z=(F.z+s)*4.,u=min(u,length(h*g-F)-.71);"
               "if(u<t)"
                 "break;"
               "g+=u;"
               "if(g>26.)"
                 "break;"
             "}"
           "if(g<26.)"
             "{"
               "if(mod(N.y,.08)<.04)"
                 "g-=n;"
               "h*=g;"
               "u=26.;"
               "for(int L=0;L<15;L++)"
                 "{"
                   "F=b[L];"
                   "Y=F;"
                   "Z=F;"
                   "F.z=(F.z+s)*4.;"
                   "C=h-F;"
                   "C=p(C,(l+f)/29.*Z);"
                   "Z=max(C-W,-C-W);"
                   "o=max(max(Z.x,Z.y),Z.z);"
                   "if(o<u)"
                     "u=o,X=Y;"
                 "}"
               "U=normalize(vec3(e(h+S,X)-e(h-S,X),e(h+R,X)-e(h-R,X),e(h+Q,X)-e(h-Q,X)));"
             "}"
           "F=vec3(U.xy,vec3(1.-g/20.));"
           "F.z+=F.y/2.;"
           "F.y=F.y+F.x;"
           "d+=clamp(F,0.,1.);"
           "T+=.0003;"
         "}"
       "V+=.0003;"
     "}"
   "d/=9.;"
   "d=(1.-k)*d+vec3(d.x+d.z*z)*k;"
   "d.xz+=c*vec2(abs(U.y),d.z/3.);"
   "gl_FragColor=vec4(d*y,1.);"
 "}";

#endif // SHADER_GLSL_H_
