#line 1 "C:/Users/Branco/Desktop/meArm/meArm/servo.c"
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
#line 4 "C:/Users/Branco/Desktop/meArm/meArm/servo.c"
const N_SERVOS = 4;



const unsigned TicksFrame = 5000;
const unsigned TicksMin = 544;
const unsigned TicksMax = 2400;
const unsigned TicksCenter = (TicksMax-TicksMin)+TicksMin;

unsigned Timer1 at TMR1L;


Servos armServos[N_SERVOS];
unsigned appPWM[N_SERVOS];
static char flags = 0;
 sbit pulso at flags.B0;



void ServoInit()
{
char i;
Servos *Ptr;
 for( i = 0; i < N_SERVOS; i++ )
 {
 Ptr = &armServos[i];
 (*Ptr).Port = &PORTB;
 (*Ptr).Pino = 1;
 (*Ptr).PWM = TicksMin;
 (*Ptr).Enable = 0;
 }

 Timer1 = 65535 - TicksFrame;
 T1CON = 0b00010000;
 TMR1IE_bit = 1;
 PEIE_Bit = 1;
 GIE_Bit = 1;
 TMR1ON_bit = 1;
}


void ServoAttach( char servo, char out, char pin )
{
Servos *ptr;
 if (servo > N_SERVOS)
 return;
 ptr = &armServos[servo];
 (*ptr).Port = out;
 (*ptr).Pino = 1 << pin;
 (*ptr).Enable = 1;
}

void Servo_Interrupt()
{
 static char servo_idx = 0;
 char port, pino;
 unsigned an;


 *(unsigned*)&FSR0L = (unsigned)&armServos[servo_idx];
 port = POSTINC0;
 pino = POSTINC0;
 ((char*)&an)[0] = POSTINC0;
 ((char*)&an)[1] = POSTINC0;


 if( INDF0.B0 )
 {
 FSR0H = 0x0F;
 FSR0L = port;
 if( !pulso )
 {
 Timer1 = 65535 - an + 59;
 INDF0 |= pino;
 }
 else
 {
 Timer1 = (65535 - TicksFrame) + an + 105;
 INDF0 &= ~pino;
 armServos[servo_idx].PWM = appPWM[servo_idx];
 ++servo_idx &= 3;
 }
 pulso = ~pulso;
 }
 else
 {
 Timer1 = (65535 - TicksFrame);
 ++servo_idx &= 3;
 }
}


void interrupt()
{
 if( TMR1IF_Bit ) {
 Servo_Interrupt();
 TMR1IF_Bit = 0;
 }
}
unsigned int ang2pwm(float graus){
 unsigned int pwm;
 pwm = (((graus/180.0)*(TicksMax-TicksMin))+TicksMin);

 pwm = (pwm > TicksMax)? TicksMax : pwm;
 pwm = (pwm < TicksMin)? TicksMin : pwm;
 return pwm;
 }

void ServoWrite(char srv_id, float Angle){
 if (srv_id < N_SERVOS){
 appPWM[srv_id] = ang2pwm(Angle);
 }
}
