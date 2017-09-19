#line 1 "C:/Users/Branco/Desktop/meArm/meArm/me-arm-ik.c"
#line 1 "c:/users/branco/desktop/mearm/mearm/ik.h"






extern float L1, L2, L3;


void cart2polar(float a, float b, float* r, float* theta);


int cosangle(float opp, float adj1, float adj2, float* theta);


int solve(float x, float y, float z, float* a0, float* a1, float* a2);
#line 4 "C:/Users/Branco/Desktop/meArm/meArm/me-arm-ik.c"
const float PI=3.14159265359;
float L1=80;
float L2=80;
float L3=68;


void cart2polar(float a, float b, float* r, float* theta)
{
 float c,s;

 *r = sqrt(a*a + b*b);


 if(*r == 0.0) return;

 c = a / *r;
 s = b / *r;


 if(s > 1.0) s = 1.0;
 if(c > 1.0) c = 1.0;
 if(s < -1.0) s = -1.0;
 if(c < -1.0) c = -1.0;


 *theta = acos(c);


 if(s < 0.0) *theta *= -1.0;
}


int cosangle(float opp, float adj1, float adj2, float* theta)
{
 float den,c;





 den = 2.0*adj1*adj2;

 if(den<0.00000001) return  0 ;
 c = (adj1*adj1 + adj2*adj2 - opp*opp)/den;

 if(c > 1.0 || c < -1.0) return  0 ;

 *theta = (float)acos(c);

 return  1 ;
}


int solve(float x, float y, float z, float* a0, float* a1, float* a2)
{
 float r, th0;
 float ang_P, R_;
 float B, C;

 cart2polar(y, x, &r, &th0);


 r -= L3;


 cart2polar(r, z, &R_, &ang_P);


 if(!cosangle(L2, L1, R_, &B)) return  0 ;
 if(!cosangle(R_, L1, L2, &C)) return  0 ;


 *a0 = th0;
 *a1 = ang_P + B;
 *a2 = C + *a1 - PI;

 return  1 ;
}
