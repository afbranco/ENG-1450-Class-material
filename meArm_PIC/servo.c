#include "servo.h"

 //Numero maximo de servos
const N_SERVOS = 4;

//Tick = 4 / clock(8MHz) * Prescaler
//Tick = (4 / 8) * 2 = 1us
const unsigned TicksFrame =  5000;   // 20 ms / 8 servos / Tick
const unsigned TicksMin = 544;      // posicao 0º = 1 ms / Tick
const unsigned TicksMax = 2400;      // posicao 180º = 2 ms / Tick
const unsigned TicksCenter =  (TicksMax-TicksMin)+TicksMin;  // posicao 90º = 1.5 ms / Tick

unsigned Timer1 at TMR1L;

//cria os servos
Servos armServos[N_SERVOS];
unsigned appPWM[N_SERVOS];
static char flags = 0;
    sbit pulso at flags.B0;


//Inicializa os servos ainda não configurados
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
     T1CON = 0b00010000; //Prescaler 1:2
     TMR1IE_bit = 1;
     PEIE_Bit = 1;
     GIE_Bit = 1;
     TMR1ON_bit = 1;
}

//Adiciona um novo servomotor
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

        //Passa o valor do endereço para o ponteiro
        *(unsigned*)&FSR0L = (unsigned)&armServos[servo_idx];
        port = POSTINC0; //Recebe o valor da porta, armServos[x].Port
        pino = POSTINC0; //Recebe o valor do pino, armServos[x].Pino
        ((char*)&an)[0] = POSTINC0;
        ((char*)&an)[1] = POSTINC0;//Recebe o angulo, armServos[x].PWM

        //Servo habilitado?
        if( INDF0.B0 ) //armServos[x].enable
        {
            FSR0H = 0x0F;
            FSR0L = port; //Passa para o ponteiro o endereço da porta
            if( !pulso )
            {
              Timer1 = 65535 - an + 59;//(29) - fator de correção?      54
              INDF0 |= pino;
            }
            else
            {
              Timer1 = (65535 - TicksFrame) + an + 105;  // +17
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
    // Não deixa passar dos limites
    pwm = (pwm > TicksMax)? TicksMax : pwm;
    pwm = (pwm < TicksMin)? TicksMin : pwm;
    return pwm;
    }

void ServoWrite(char srv_id, float Angle){
     if (srv_id < N_SERVOS){
         appPWM[srv_id] = ang2pwm(Angle);
     }
}