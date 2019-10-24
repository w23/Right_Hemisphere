/* File generated with Shader Minifier 1.1.4
 * http://www.ctrl-alt-test.fr
 */
#ifndef SHADER_GLSL_H_
# define SHADER_GLSL_H_
# define VAR_FADE "y"
# define VAR_DISTORT "n"
# define VAR_GREYSCALE "x"
# define VAR_GREYSCALE2 "l"
# define VAR_RED "d"
# define VAR_SCENE "A"
# define VAR_SHIFT11 "m"
# define VAR_SHIFTX "a"
# define VAR_SHIFTY "s"
# define VAR_SKIP "c"
# define VAR_STEPS "i"
# define VAR_T "v"
# define VAR_TIMESHIFT "f"
# define VAR_ZOOMXY "k"
# define VAR_ZOOMSHIFT "z"

const char *shader_glsl =
 "#define deltaAA 1./(3.*710.)\n"
 "uniform float v,y,m,z,i,x,l,f,a,s,k,d,c,n,A;"
 "vec3 r[16];"
 "float e;"
 "vec3 p(vec3 y,vec3 v)"
 "{"
   "vec3 f=sin(v),i=cos(v);"
   "return y*mat3(i.y,f.z*f.y,-f.y*i.z,-f.x*f.y,i.x*i.z+f.x*f.z*i.y,f.z*i.x-f.x*i.z*i.y,i.x*f.y,f.x*i.z-i.x*f.z*i.y,f.z*f.x+i.x*i.z*i.y);"
 "}"
 "vec3 p(float y,float v,float x)"
 "{"
   "return vec3(y*4.-2.,v*4.-2.,x*4.-2.);"
 "}"
 "float h(vec3 y,vec3 i)"
 "{"
   "vec3 r,x,z=vec3(.5,.5,.001);"
   "x=i;"
   "i.z=(i.z+e)*4.;"
   "r=y-i;"
   "r=p(r,(v+f)/29.*x);"
   "x=max(r-z,-r-z);"
   "return max(max(x.x,x.y),x.z);"
 "}"
 "vec2 t(in vec2 i,in vec2 f)"
 "{"
   "return vec2(i.x*f.x-i.y*f.y,i.y*f.x+i.x*f.y);"
 "}"
 "vec2 h(vec2 i)"
 "{"
   "return vec2(log(length(i)),atan(i.y,i.x));"
 "}"
 "void main()"
 "{"
   "e=z+smoothstep(120.,180.,v+f)*.6-smoothstep(240.,300.,v+f);"
   "float b,g,o,u=.0001,F,C=deltaAA/2.;"
   "vec3 w,Z=vec3(0.),Y,X,W,V,U,T,S=vec3(.5,.5,.001),R=vec3(0.,0.,0.),Q=vec3(u,0.,0.),P=vec3(0.,u,0.),O=vec3(0.,0.,u);"
   "for(int N=0;N<3;N++)"
     "{"
       "F=deltaAA/2.;"
       "for(int M=0;M<3;M++)"
         "{"
           "vec2 L=(gl_FragCoord.xy/vec2(1920.,1080.)+vec2(F,C)+vec2(a,s))/vec2(1.,16./9.)*k;"
           "if(A<1.)"
             "{"
               "r[0]=p(.044677,.928527,.337524);"
               "r[1]=p(.520019,.026367,.486328);"
               "r[2]=p(.026125,.984497,.337249);"
               "r[3]=p(.635498,.42041,.41748);"
               "r[4]=p(.558349,.929687,.849609);"
               "r[5]=p(.840576,.539917,.436889);"
               "r[6]=p(.096557,.049438,.537475);"
               "r[7]=p(.439819,.906127,.853759);"
               "r[8]=p(.291748,.75415,.479736);"
               "r[9]=p(.572753,.774047,.402343);"
               "r[10]=p(.565551,.614624,.542602);"
               "r[11]=p(.279052,.261779,.26455);"
               "r[12]=p(.62207,.145751,.537809);"
               "r[13]=p(.846801,.8208,.397094);"
               "r[14]=p(.905029,.469421,.400512);"
               "r[15]=p(.725585,.835769,.054077);"
               "r[11]-=m/vec3(70.,110.,-180.);"
               "b=1.;"
               "w=normalize(vec3(L,1.));"
               "for(int K=0;K<5;K++)"
                 "{"
                   "if(K>=int(i))"
                     "break;"
                   "g=26.;"
                   "for(int J=0;J<15;J++)"
                     "if(J!=int(c))"
                       "Y=r[J],Y.z=(Y.z+e)*4.,g=min(g,length(w*b-Y)-.71);"
                   "if(g<u)"
                     "break;"
                   "b+=g;"
                   "if(b>26.)"
                     "break;"
                 "}"
               "if(b<26.)"
                 "{"
                   "if(mod(L.y,.08)<.04)"
                     "b-=n;"
                   "w*=b;"
                   "g=26.;"
                   "for(int J=0;J<15;J++)"
                     "{"
                       "Y=r[J];"
                       "U=Y;"
                       "V=Y;"
                       "Y.z=(Y.z+e)*4.;"
                       "W=w-Y;"
                       "W=p(W,(v+f)/29.*V);"
                       "V=max(W-S,-W-S);"
                       "o=max(max(V.x,V.y),V.z);"
                       "if(o<g)"
                         "g=o,T=U;"
                     "}"
                   "R=normalize(vec3(h(w+Q,T)-h(w-Q,T),h(w+P,T)-h(w-P,T),h(w+O,T)-h(w-O,T)));"
                 "}"
               "Y=vec3(R.xy,vec3(1.-b/20.));"
               "Y.z+=Y.y/2.;"
               "Y.y=Y.y+Y.x;"
               "Z+=clamp(Y,0.,1.);"
               "X=vec3(Z.x+Z.z*l);"
               "Z=(1.-x)*Z+X*x;"
               "Z.xz+=d*vec2(abs(R.y),Z.z/3.);"
             "}"
           "else"
             "{"
               "vec2 J,K,I=L;"
               "for(int H=0;H<9;H++)"
                 "J=t(I,vec2(2.,2.1))+vec2(.3,-2.-x),K=t(h(t(I,vec2(l-2.,1.6))+vec2(-1.4,-1.75)),vec2(-2.,1.6)),K/=pow(length(K),2.),I=h(t(J,vec2(cos(K.y)*exp(K.x),sin(K.y)*exp(K.x))));"
               "I=abs(I);"
               "Z+=vec3(I.y,pow(length(I)/3.5,1.8),I.x/3.);"
             "}"
           "F+=deltaAA;"
         "}"
       "C+=deltaAA;"
     "}"
   "Z/=9.;"
   "gl_FragColor=vec4(Z*y,1.);"
 "}";

#endif // SHADER_GLSL_H_
