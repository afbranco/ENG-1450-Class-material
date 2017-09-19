/* meArm library York Hack Space May 2014
 * A simple control library for Phenoptix' meArm
 * Usage:
 *   #include "meArm.h"
 *   arm_begin(1, 10, 9, 6);
 *   arm_openGripper();
 *   arm_gotoPoint(-80, 100, 140);
 *   arm_closeGripper();
 *   arm_gotoPoint(70, 200, 10);
 *   arm_openGripper();
 */
#include "ik.h"
#include "meArm.h"
#include "servo.h"

    //Current x, y and z
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
    
    // Must have a non-zero angle range
    if(a_range == 0) return false;

    // Calculate gain and zero
    svo->gain = n_range / a_range;
    svo->zero = (float)n_min - svo->gain * a_min;

    // Set limits
    svo->n_min = n_min;
    svo->n_max = n_max;

    return true;
}

float rad2Angle (ServoInfo* svo, const float rad)
{
    //angle = (0.5 + (svo->zero) + ((svo->gain) * rad));
    return ((svo->zero) + ((svo->gain) * rad));

}

//Full constructor with calibration data
void meArm_calib(char *calib) {
  //calroutine();

int sweepMinBase=calib[0];
int sweepMaxBase=calib[1];
int sweepMinShoulder=calib[2];
int sweepMaxShoulder=calib[3];
int sweepMinElbow=calib[4];
int sweepMaxElbow=calib[5];
int sweepMinGripper=calib[6];
int sweepMaxGripper=calib[7];

float angleMinBase=-pi/2.0;
float angleMaxBase=pi/2.0;
float angleMinShoulder=pi/4.0;
float angleMaxShoulder=3*pi/4.0;
float angleMinElbow=0.0;
float angleMaxElbow=-pi/4.0;
float angleMinGripper=pi/2.0;
float angleMaxGripper=0.0;

/*
int sweepMinBase=145;
int sweepMaxBase=49;
float angleMinBase=-pi/4.0;
float angleMaxBase=pi/4.0;
int sweepMinShoulder=118;
int sweepMaxShoulder=22;
float angleMinShoulder=pi/4.0;
float angleMaxShoulder=3*pi/4.0;
int sweepMinElbow=144;
int sweepMaxElbow=36;
float angleMinElbow=pi/4.0;
float angleMaxElbow=-pi/4.0;
int sweepMinGripper=75;
int sweepMaxGripper=115;
float angleMinGripper=pi/2.0;
float angleMaxGripper=0.0;
*/

  setup_servo(&_svoBase, sweepMinBase, sweepMaxBase, angleMinBase, angleMaxBase);
  setup_servo(&_svoShoulder, sweepMinShoulder, sweepMaxShoulder, angleMinShoulder, angleMaxShoulder);
  setup_servo(&_svoElbow, sweepMinElbow, sweepMaxElbow, angleMinElbow, angleMaxElbow);
  setup_servo(&_svoGripper, sweepMinGripper, sweepMaxGripper, angleMinGripper, angleMaxGripper);

}

//(char)&SRV_PORT
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
  ServoAttach( _svoBase.id,      portAddr, _pinBase );
  ServoAttach( _svoShoulder.id,  portAddr, _pinShoulder );
  ServoAttach( _svoElbow.id,     portAddr, _pinElbow );
  ServoAttach( _svoGripper.id,   portAddr, _pinGripper );

  meArm_goDirectlyToCylinder(0, 130, 50);
  meArm_openGripper();
}


//Set servos to reach a certain point directly without caring how we get there
void meArm_goDirectlyTo(float x, float y, float z) {
  float radBase,radShoulder,radElbow;
  volatile int solve;
  //PORTD.B4 = ~PORTD.B4;
  solve = solve(x, y, z, &radBase, &radShoulder, &radElbow);
  if (solve) {
    ServoWrite(_svoBase.id,rad2Angle(&_svoBase,radBase));
    ServoWrite(_svoShoulder.id,rad2Angle(&_svoShoulder,radShoulder));
    ServoWrite(_svoElbow.id,rad2Angle(&_svoElbow,radElbow));
    _x = x; _y = y; _z = z;
  }
}

//Travel smoothly from current point to another point
void meArm_gotoPoint(float x, float y, float z) {
  //Starting points - current pos
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

//Get x and y from theta and r
void meArm_polarToCartesian(float theta, float r, float* x, float* y){
    _r = r;
    _t = theta;
    *x = r*sin(theta);
    *y = r*cos(theta);
}

//Same as above but for cylindrical polar coodrinates
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

//Check to see if possible
int meArm_isReachable(float x, float y, float z) {
  float radBase,radShoulder,radElbow;
  return (solve(x, y, z, &radBase, &radShoulder, &radElbow));
}

//Grab something
void meArm_openGripper() {
  ServoWrite(_svoGripper.id,rad2Angle(&_svoGripper,pi/2.0));
  Delay_ms(300);
}

//Let go of something
void meArm_closeGripper() {
  ServoWrite(_svoGripper.id,20.0);
  Delay_ms(200);
  ServoWrite(_svoGripper.id,rad2Angle(&_svoGripper,0.0));
  Delay_ms(100);
}

//Current x, y and z
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