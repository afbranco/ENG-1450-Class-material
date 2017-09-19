#ifndef SERVO_H
#define SERVO_H

//Registro de configuracao para cada servo
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

//Inicializa os servos ainda não configurados
void ServoInit();
//Adiciona um novo servomotor
void ServoAttach( char servo, char out, char pin );

void ServoWrite(char srv_id, float angle);

#endif // SERVO_H