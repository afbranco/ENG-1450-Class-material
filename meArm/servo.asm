
_ServoInit:

;servo.c,23 :: 		void ServoInit()
;servo.c,27 :: 		for( i = 0; i < N_SERVOS; i++ )
	CLRF        ServoInit_i_L0+0 
L_ServoInit0:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ServoInit15
	MOVLW       4
	SUBWF       ServoInit_i_L0+0, 0 
L__ServoInit15:
	BTFSC       STATUS+0, 0 
	GOTO        L_ServoInit1
;servo.c,29 :: 		Ptr = &armServos[i];
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ServoInit_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _armServos+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_armServos+0)
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       ServoInit_Ptr_L0+0 
	MOVF        R1, 0 
	MOVWF       ServoInit_Ptr_L0+1 
;servo.c,30 :: 		(*Ptr).Port = &PORTB;
	MOVFF       R0, FSR1
	MOVFF       R1, FSR1H
	MOVLW       PORTB+0
	MOVWF       POSTINC1+0 
;servo.c,31 :: 		(*Ptr).Pino = 1;
	MOVLW       1
	ADDWF       ServoInit_Ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      ServoInit_Ptr_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;servo.c,32 :: 		(*Ptr).PWM = TicksMin;
	MOVLW       2
	ADDWF       ServoInit_Ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      ServoInit_Ptr_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
	MOVLW       2
	MOVWF       POSTINC1+0 
;servo.c,33 :: 		(*Ptr).Enable = 0;
	MOVLW       4
	ADDWF       ServoInit_Ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      ServoInit_Ptr_L0+1, 0 
	MOVWF       FSR1H 
	BCF         POSTINC1+0, 0 
;servo.c,27 :: 		for( i = 0; i < N_SERVOS; i++ )
	INCF        ServoInit_i_L0+0, 1 
;servo.c,34 :: 		}
	GOTO        L_ServoInit0
L_ServoInit1:
;servo.c,36 :: 		Timer1 = 65535 - TicksFrame;
	MOVLW       119
	MOVWF       TMR1L+0 
	MOVLW       236
	MOVWF       TMR1L+1 
;servo.c,37 :: 		T1CON = 0b00010000; //Prescaler 1:2
	MOVLW       16
	MOVWF       T1CON+0 
;servo.c,38 :: 		TMR1IE_bit = 1;
	BSF         TMR1IE_bit+0, BitPos(TMR1IE_bit+0) 
;servo.c,39 :: 		PEIE_Bit = 1;
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;servo.c,40 :: 		GIE_Bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;servo.c,41 :: 		TMR1ON_bit = 1;
	BSF         TMR1ON_bit+0, BitPos(TMR1ON_bit+0) 
;servo.c,42 :: 		}
L_end_ServoInit:
	RETURN      0
; end of _ServoInit

_ServoAttach:

;servo.c,45 :: 		void ServoAttach( char servo, char out, char pin )
;servo.c,48 :: 		if (servo > N_SERVOS)
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ServoAttach17
	MOVF        FARG_ServoAttach_servo+0, 0 
	SUBLW       4
L__ServoAttach17:
	BTFSC       STATUS+0, 0 
	GOTO        L_ServoAttach3
;servo.c,49 :: 		return;
	GOTO        L_end_ServoAttach
L_ServoAttach3:
;servo.c,50 :: 		ptr = &armServos[servo];
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        FARG_ServoAttach_servo+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _armServos+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_armServos+0)
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       ServoAttach_ptr_L0+0 
	MOVF        R1, 0 
	MOVWF       ServoAttach_ptr_L0+1 
;servo.c,51 :: 		(*ptr).Port = out;
	MOVFF       R0, FSR1
	MOVFF       R1, FSR1H
	MOVF        FARG_ServoAttach_out+0, 0 
	MOVWF       POSTINC1+0 
;servo.c,52 :: 		(*ptr).Pino = 1 << pin;
	MOVLW       1
	ADDWF       ServoAttach_ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      ServoAttach_ptr_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        FARG_ServoAttach_pin+0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__ServoAttach18:
	BZ          L__ServoAttach19
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__ServoAttach18
L__ServoAttach19:
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;servo.c,53 :: 		(*ptr).Enable = 1;
	MOVLW       4
	ADDWF       ServoAttach_ptr_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      ServoAttach_ptr_L0+1, 0 
	MOVWF       FSR1H 
	BSF         POSTINC1+0, 0 
;servo.c,54 :: 		}
L_end_ServoAttach:
	RETURN      0
; end of _ServoAttach

_Servo_Interrupt:

;servo.c,56 :: 		void Servo_Interrupt()
;servo.c,63 :: 		*(unsigned*)&FSR0L = (unsigned)&armServos[servo_idx];
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Servo_Interrupt_servo_idx_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _armServos+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_armServos+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
;servo.c,64 :: 		port = POSTINC0; //Recebe o valor da porta, armServos[x].Port
	MOVF        POSTINC0+0, 0 
	MOVWF       Servo_Interrupt_port_L0+0 
;servo.c,65 :: 		pino = POSTINC0; //Recebe o valor do pino, armServos[x].Pino
	MOVF        POSTINC0+0, 0 
	MOVWF       Servo_Interrupt_pino_L0+0 
;servo.c,66 :: 		((char*)&an)[0] = POSTINC0;
	MOVF        POSTINC0+0, 0 
	MOVWF       Servo_Interrupt_an_L0+0 
;servo.c,67 :: 		((char*)&an)[1] = POSTINC0;//Recebe o angulo, armServos[x].PWM
	MOVF        POSTINC0+0, 0 
	MOVWF       Servo_Interrupt_an_L0+1 
;servo.c,70 :: 		if( INDF0.B0 ) //armServos[x].enable
	BTFSS       INDF0+0, 0 
	GOTO        L_Servo_Interrupt4
;servo.c,72 :: 		FSR0H = 0x0F;
	MOVLW       15
	MOVWF       FSR0H 
;servo.c,73 :: 		FSR0L = port; //Passa para o ponteiro o endereço da porta
	MOVF        Servo_Interrupt_port_L0+0, 0 
	MOVWF       FSR0 
;servo.c,74 :: 		if( !pulso )
	BTFSC       servo_flags+0, 0 
	GOTO        L_Servo_Interrupt5
;servo.c,76 :: 		Timer1 = 65535 - an + 59;//(29) - fator de correção?      54
	MOVF        Servo_Interrupt_an_L0+0, 0 
	SUBLW       255
	MOVWF       TMR1L+0 
	MOVF        Servo_Interrupt_an_L0+1, 0 
	MOVWF       TMR1L+1 
	MOVLW       255
	SUBFWB      TMR1L+1, 1 
	MOVLW       59
	ADDWF       TMR1L+0, 1 
	MOVLW       0
	ADDWFC      TMR1L+1, 1 
;servo.c,77 :: 		INDF0 |= pino;
	MOVF        Servo_Interrupt_pino_L0+0, 0 
	IORWF       INDF0+0, 1 
;servo.c,78 :: 		}
	GOTO        L_Servo_Interrupt6
L_Servo_Interrupt5:
;servo.c,81 :: 		Timer1 = (65535 - TicksFrame) + an + 105;  // +17
	MOVLW       119
	ADDWF       Servo_Interrupt_an_L0+0, 0 
	MOVWF       TMR1L+0 
	MOVLW       236
	ADDWFC      Servo_Interrupt_an_L0+1, 0 
	MOVWF       TMR1L+1 
	MOVLW       105
	ADDWF       TMR1L+0, 1 
	MOVLW       0
	ADDWFC      TMR1L+1, 1 
;servo.c,82 :: 		INDF0 &= ~pino;
	COMF        Servo_Interrupt_pino_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       INDF0+0, 1 
;servo.c,83 :: 		armServos[servo_idx].PWM = appPWM[servo_idx];
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        Servo_Interrupt_servo_idx_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _armServos+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_armServos+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        Servo_Interrupt_servo_idx_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _appPWM+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_appPWM+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;servo.c,84 :: 		++servo_idx &= 3;
	INCF        Servo_Interrupt_servo_idx_L0+0, 1 
	MOVLW       3
	ANDWF       Servo_Interrupt_servo_idx_L0+0, 1 
;servo.c,85 :: 		}
L_Servo_Interrupt6:
;servo.c,86 :: 		pulso = ~pulso;
	BTG         servo_flags+0, 0 
;servo.c,87 :: 		}
	GOTO        L_Servo_Interrupt7
L_Servo_Interrupt4:
;servo.c,90 :: 		Timer1 = (65535 - TicksFrame);
	MOVLW       119
	MOVWF       TMR1L+0 
	MOVLW       236
	MOVWF       TMR1L+1 
;servo.c,91 :: 		++servo_idx &= 3;
	INCF        Servo_Interrupt_servo_idx_L0+0, 1 
	MOVLW       3
	ANDWF       Servo_Interrupt_servo_idx_L0+0, 1 
;servo.c,92 :: 		}
L_Servo_Interrupt7:
;servo.c,93 :: 		}
L_end_Servo_Interrupt:
	RETURN      0
; end of _Servo_Interrupt

_interrupt:

;servo.c,96 :: 		void interrupt()
;servo.c,98 :: 		if( TMR1IF_Bit ) {
	BTFSS       TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
	GOTO        L_interrupt8
;servo.c,99 :: 		Servo_Interrupt();
	CALL        _Servo_Interrupt+0, 0
;servo.c,100 :: 		TMR1IF_Bit = 0;
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;servo.c,101 :: 		}
L_interrupt8:
;servo.c,102 :: 		}
L_end_interrupt:
L__interrupt22:
	RETFIE      1
; end of _interrupt

_ang2pwm:

;servo.c,103 :: 		unsigned int ang2pwm(float graus){
;servo.c,105 :: 		pwm = (((graus/180.0)*(TicksMax-TicksMin))+TicksMin);
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       52
	MOVWF       R6 
	MOVLW       134
	MOVWF       R7 
	MOVF        FARG_ang2pwm_graus+0, 0 
	MOVWF       R0 
	MOVF        FARG_ang2pwm_graus+1, 0 
	MOVWF       R1 
	MOVF        FARG_ang2pwm_graus+2, 0 
	MOVWF       R2 
	MOVF        FARG_ang2pwm_graus+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       104
	MOVWF       R6 
	MOVLW       137
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       8
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       ang2pwm_pwm_L0+0 
	MOVF        R1, 0 
	MOVWF       ang2pwm_pwm_L0+1 
;servo.c,107 :: 		pwm = (pwm > TicksMax)? TicksMax : pwm;
	MOVF        R1, 0 
	SUBLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L__ang2pwm24
	MOVF        R0, 0 
	SUBLW       96
L__ang2pwm24:
	BTFSC       STATUS+0, 0 
	GOTO        L_ang2pwm9
	MOVLW       96
	MOVWF       R1 
	MOVLW       9
	MOVWF       R2 
	GOTO        L_ang2pwm10
L_ang2pwm9:
	MOVF        ang2pwm_pwm_L0+0, 0 
	MOVWF       R1 
	MOVF        ang2pwm_pwm_L0+1, 0 
	MOVWF       R2 
L_ang2pwm10:
	MOVF        R1, 0 
	MOVWF       ang2pwm_pwm_L0+0 
	MOVF        R2, 0 
	MOVWF       ang2pwm_pwm_L0+1 
;servo.c,108 :: 		pwm = (pwm < TicksMin)? TicksMin : pwm;
	MOVLW       2
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ang2pwm25
	MOVLW       32
	SUBWF       R1, 0 
L__ang2pwm25:
	BTFSC       STATUS+0, 0 
	GOTO        L_ang2pwm11
	MOVLW       32
	MOVWF       R0 
	MOVLW       2
	MOVWF       R1 
	GOTO        L_ang2pwm12
L_ang2pwm11:
	MOVF        ang2pwm_pwm_L0+0, 0 
	MOVWF       R0 
	MOVF        ang2pwm_pwm_L0+1, 0 
	MOVWF       R1 
L_ang2pwm12:
	MOVF        R0, 0 
	MOVWF       ang2pwm_pwm_L0+0 
	MOVF        R1, 0 
	MOVWF       ang2pwm_pwm_L0+1 
;servo.c,109 :: 		return pwm;
;servo.c,110 :: 		}
L_end_ang2pwm:
	RETURN      0
; end of _ang2pwm

_ServoWrite:

;servo.c,112 :: 		void ServoWrite(char srv_id, float Angle){
;servo.c,113 :: 		if (srv_id < N_SERVOS){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ServoWrite27
	MOVLW       4
	SUBWF       FARG_ServoWrite_srv_id+0, 0 
L__ServoWrite27:
	BTFSC       STATUS+0, 0 
	GOTO        L_ServoWrite13
;servo.c,114 :: 		appPWM[srv_id] = ang2pwm(Angle);
	MOVF        FARG_ServoWrite_srv_id+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _appPWM+0
	ADDWF       R0, 0 
	MOVWF       FLOC__ServoWrite+0 
	MOVLW       hi_addr(_appPWM+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__ServoWrite+1 
	MOVF        FARG_ServoWrite_Angle+0, 0 
	MOVWF       FARG_ang2pwm_graus+0 
	MOVF        FARG_ServoWrite_Angle+1, 0 
	MOVWF       FARG_ang2pwm_graus+1 
	MOVF        FARG_ServoWrite_Angle+2, 0 
	MOVWF       FARG_ang2pwm_graus+2 
	MOVF        FARG_ServoWrite_Angle+3, 0 
	MOVWF       FARG_ang2pwm_graus+3 
	CALL        _ang2pwm+0, 0
	MOVFF       FLOC__ServoWrite+0, FSR1
	MOVFF       FLOC__ServoWrite+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;servo.c,115 :: 		}
L_ServoWrite13:
;servo.c,116 :: 		}
L_end_ServoWrite:
	RETURN      0
; end of _ServoWrite
