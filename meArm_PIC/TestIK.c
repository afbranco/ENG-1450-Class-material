#include "meArm.h"
#define ARM_ID 6
#include "armData.h"

void main() {
     TRISB = 0x00;
     meArm_calib(armData);
     meArm_begin(&PORTB,RB0,RB1,RB2,RB3);
     
     meArm_gotoPoint(30.0,90.0,60.0);
     Delay_ms(2000);
     meArm_gotoPoint(30.0,300.0,10.0);
}