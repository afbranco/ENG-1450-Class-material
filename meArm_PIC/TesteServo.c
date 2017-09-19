#include "servo.h"

#define SERVO_A 0
#define SERVO_B 1


void main() {
     float angle=0.0;
     TRISB.RB0=0;       // Configura pino como saída
     TRISB.RB1=0;       // Configura pino como saída

     ServoInit();       // Inicializa biblioteca
 
     ServoAttach(SERVO_A,&PORTB,RB0);  // Inicializa Servo A na PORTB.RB0
     ServoAttach(SERVO_B,&PORTB,RB1);  // Inicializa Servo B na PORTB.RB1

     // Movimenta o Servo de 45 e 45 graus
     while(1){
        ServoWrite(SERVO_A,angle);
        ServoWrite(SERVO_B,180.0-angle);
        Delay_ms(1000);
        angle = (angle+45.0);
        if (angle > 180.0) angle=0.0;
     }
}