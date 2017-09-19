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
#ifndef MEARM_H
#define MEARM_H

//#include <servo.h>

#define pi 3.14159265359

typedef struct ServoInfo {
    int n_min, n_max;   // PWM 'soft' limits - should be just within range
    float gain;         // PWM per radian
    float zero;         // Theoretical PWM for zero angle
    int id;             // Servor Id in the servo list [0..3]
} ServoInfo;

    //Full constructor uses calibration data, or can just give pins
    void meArm_calib(char *calib);
    //required before running
    void meArm_begin(char portAddr, int pinBase, int pinShoulder, int pinElbow, int pinGripper);
    //Travel smoothly from current point to another point
    void meArm_gotoPoint(float x, float y, float z);
    //Set servos to reach a certain point directly without caring how we get there
    void meArm_goDirectlyTo(float x, float y, float z);

    //Same as above but for cylindrical polar coodrinates
    void meArm_gotoPointCylinder(float theta, float r, float z);
    void meArm_goDirectlyToCylinder(float theta, float r, float z);

    //Grab something
    void meArm_openGripper();
    //Let go of something
    void meArm_closeGripper();
    //Check to see if possible
    int meArm_isReachable(float x, float y, float z);

    // Write to the servos
    void meArm_servo(char id, unsigned char pwm);

#endif