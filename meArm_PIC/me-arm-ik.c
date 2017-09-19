//#include <cmath>
#include "ik.h"

const float PI=3.14159265359;
float L1=80; //Shoulder to elbow length
float L2=80; //Elbow to wrise length
float L3=68; //Length from wrist to hand PLUS base centre to shoulder

// Get polar coords from cartesian ones
void cart2polar(float a, float b, float* r, float* theta)
{
     float c,s;
    // Determine magnitude of cartesian coords
    *r = sqrt(a*a + b*b);

    // Don't try to calculate zero-magnitude vectors' angles
    if(*r == 0.0) return;

    c = a / *r;
    s = b / *r;

    // Safety!
    if(s > 1.0) s = 1.0;
    if(c > 1.0) c = 1.0;
    if(s < -1.0) s = -1.0;
    if(c < -1.0) c = -1.0;

    // Calculate angle in 0..PI
    *theta = acos(c);

    // Convert to full range
    if(s < 0.0) *theta *= -1.0;
}

// Get angle from a triangle using cosine rule
int cosangle(float opp, float adj1, float adj2, float* theta)
{
    float den,c;
    // Cosine rule:
    // C^2 = A^2 + B^2 - 2*A*B*cos(angle_AB)
    // cos(angle_AB) = (A^2 + B^2 - C^2)/(2*A*B)
    // C is opposite
    // A, B are adjacent
    den = 2.0*adj1*adj2;

    if(den<0.00000001) return false;
    c = (adj1*adj1 + adj2*adj2 - opp*opp)/den;

    if(c > 1.0 || c < -1.0) return false;

    *theta = (float)acos(c);

    return true;
}

// Solve angles!
int solve(float x, float y, float z, float* a0, float* a1, float* a2)
{
    float r, th0;
    float ang_P, R_;
    float B, C;
    // Solve top-down view
    cart2polar(y, x, &r, &th0);
    
    // Account for the wrist length!
    r -= L3;

    // In arm plane, convert to polar
    cart2polar(r, z, &R_, &ang_P);

    // Solve arm inner angles as required
    if(!cosangle(L2, L1, R_, &B)) return false;
    if(!cosangle(R_, L1, L2, &C)) return false;

    // Solve for servo angles from horizontal
    *a0 = th0;
    *a1 = ang_P + B;
    *a2 = C + *a1 - PI;

    return true;
}