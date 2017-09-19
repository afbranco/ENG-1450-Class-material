#line 1 "C:/Users/Branco/Desktop/meArm/meArm/meArm.c"
#line 1 "c:/users/branco/desktop/mearm/mearm/ik.h"






extern float L1, L2, L3;


void cart2polar(float a, float b, float* r, float* theta);


int cosangle(float opp, float adj1, float adj2, float* theta);


int solve(float x, float y, float z, float* a0, float* a1, float* a2);
#line 1 "c:/users/branco/desktop/mearm/mearm/mearm.h"
#line 19 "c:/users/branco/desktop/mearm/mearm/mearm.h"
typedef struct ServoInfo {
 int n_min, n_max;
 float gain;
 float zero;
 int id;
} ServoInfo;


 void meArm_calib(char *calib);

 void meArm_begin(char portAddr, int pinBase, int pinShoulder, int pinElbow, int pinGripper);

 void meArm_gotoPoint(float x, float y, float z);

 void meArm_goDirectlyTo(float x, float y, float z);


 void meArm_gotoPointCylinder(float theta, float r, float z);
 void meArm_goDirectlyToCylinder(float theta, float r, float z);


 void meArm_openGripper();

 void meArm_closeGripper();

 int meArm_isReachable(float x, float y, float z);


 void meArm_servo(char id, unsigned char pwm);
#line 1 "c:/users/branco/desktop/mearm/mearm/servo.h"




typedef struct
{
 char Port;
 char Pino;
 unsigned PWM;
 union
 {
 char Enable:1;
 };
}Servos;


void ServoInit();

void ServoAttach( char servo, char out, char pin );

void ServoWrite(char srv_id, float angle);
#line 17 "C:/Users/Branco/Desktop/meArm/meArm/meArm.c"
 float meArm_getX();
 float meArm_getY();
 float meArm_getZ();

 float meArm_getR();
 float meArm_getTheta();

 void meArm_polarToCartesian(float theta, float r, float* x, float* y);
 float _x, _y, _z;
 float _r, _t;
 ServoInfo _svoBase, _svoShoulder, _svoElbow, _svoGripper;
 int _pinBase, _pinShoulder, _pinElbow, _pinGripper;

int setup_servo (ServoInfo* svo, const int n_min, const int n_max,
 const float a_min, const float a_max)
{
 float n_range = (float)n_max - (float)n_min;
 float a_range = (float)a_max - (float)a_min;


 if(a_range == 0) return  0 ;


 svo->gain = n_range / a_range;
 svo->zero = (float)n_min - svo->gain * a_min;


 svo->n_min = n_min;
 svo->n_max = n_max;

 return  1 ;
}

float rad2Angle (ServoInfo* svo, const float rad)
{

 return ((svo->zero) + ((svo->gain) * rad));

}


void meArm_calib(char *calib) {


int sweepMinBase=calib[0];
int sweepMaxBase=calib[1];
int sweepMinShoulder=calib[2];
int sweepMaxShoulder=calib[3];
int sweepMinElbow=calib[4];
int sweepMaxElbow=calib[5];
int sweepMinGripper=calib[6];
int sweepMaxGripper=calib[7];

float angleMinBase=- 3.14159265359 /2.0;
float angleMaxBase= 3.14159265359 /2.0;
float angleMinShoulder= 3.14159265359 /4.0;
float angleMaxShoulder=3* 3.14159265359 /4.0;
float angleMinElbow=0.0;
float angleMaxElbow=- 3.14159265359 /4.0;
float angleMinGripper= 3.14159265359 /2.0;
float angleMaxGripper=0.0;
#line 98 "C:/Users/Branco/Desktop/meArm/meArm/meArm.c"
 setup_servo(&_svoBase, sweepMinBase, sweepMaxBase, angleMinBase, angleMaxBase);
 setup_servo(&_svoShoulder, sweepMinShoulder, sweepMaxShoulder, angleMinShoulder, angleMaxShoulder);
 setup_servo(&_svoElbow, sweepMinElbow, sweepMaxElbow, angleMinElbow, angleMaxElbow);
 setup_servo(&_svoGripper, sweepMinGripper, sweepMaxGripper, angleMinGripper, angleMaxGripper);

}


void meArm_begin(char portAddr, int pinBase, int pinShoulder, int pinElbow, int pinGripper) {
 _pinBase = pinBase;
 _pinShoulder = pinShoulder;
 _pinElbow = pinElbow;
 _pinGripper = pinGripper;
 _svoBase.id = 0;
 _svoShoulder.id = 1;
 _svoElbow.id = 2;
 _svoGripper.id = 3;

 ServoInit();
 ServoAttach( _svoBase.id, portAddr, _pinBase );
 ServoAttach( _svoShoulder.id, portAddr, _pinShoulder );
 ServoAttach( _svoElbow.id, portAddr, _pinElbow );
 ServoAttach( _svoGripper.id, portAddr, _pinGripper );

 meArm_goDirectlyToCylinder(0, 130, 50);
 meArm_openGripper();
}



void meArm_goDirectlyTo(float x, float y, float z) {
 float radBase,radShoulder,radElbow;
 volatile int solve;

 solve = solve(x, y, z, &radBase, &radShoulder, &radElbow);
 if (solve) {
 ServoWrite(_svoBase.id,rad2Angle(&_svoBase,radBase));
 ServoWrite(_svoShoulder.id,rad2Angle(&_svoShoulder,radShoulder));
 ServoWrite(_svoElbow.id,rad2Angle(&_svoElbow,radElbow));
 _x = x; _y = y; _z = z;
 }
}


void meArm_gotoPoint(float x, float y, float z) {

 float x0 = _x;
 float y0 = _y;
 float z0 = _z;
 float dist = sqrt((x0-x)*(x0-x)+(y0-y)*(y0-y)+(z0-z)*(z0-z));
 int step = 10;
 int i;
 for (i = 0; i<dist; i+= step) {
 meArm_goDirectlyTo(x0 + (x-x0)*i/dist, y0 + (y-y0) * i/dist, z0 + (z-z0) * i/dist);
 Delay_ms(50);
 }
 meArm_goDirectlyTo(x, y, z);
 Delay_ms(50);
}


void meArm_polarToCartesian(float theta, float r, float* x, float* y){
 _r = r;
 _t = theta;
 *x = r*sin(theta);
 *y = r*cos(theta);
}


void meArm_gotoPointCylinder(float theta, float r, float z){
 float x, y;
 meArm_polarToCartesian(theta, r, &x, &y);
 meArm_gotoPoint(x,y,z);
}

void meArm_goDirectlyToCylinder(float theta, float r, float z){
 float x, y;
 meArm_polarToCartesian(theta, r, &x, &y);
 meArm_goDirectlyTo(x,y,z);
}


int meArm_isReachable(float x, float y, float z) {
 float radBase,radShoulder,radElbow;
 return (solve(x, y, z, &radBase, &radShoulder, &radElbow));
}


void meArm_openGripper() {
 ServoWrite(_svoGripper.id,rad2Angle(&_svoGripper, 3.14159265359 /2.0));
 Delay_ms(300);
}


void meArm_closeGripper() {
 ServoWrite(_svoGripper.id,20.0);
 Delay_ms(200);
 ServoWrite(_svoGripper.id,rad2Angle(&_svoGripper,0.0));
 Delay_ms(100);
}


float meArm_getX() {
 return _x;
}
float meArm_getY() {
 return _y;
}
float meArm_getZ() {
 return _z;
}


float meArm_getR() {
 return _r;
}
float meArm_getTheta() {
 return _t;
}

void meArm_servo(char id, float angle){
 ServoWrite(id,angle);
}
