
_setup_servo:

;meArm.c,31 :: 		const float a_min, const float a_max)
;meArm.c,33 :: 		float n_range = (float)n_max - (float)n_min;
	MOVF        FARG_setup_servo_n_max+0, 0 
	MOVWF       R0 
	MOVF        FARG_setup_servo_n_max+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__setup_servo+0 
	MOVF        R1, 0 
	MOVWF       FLOC__setup_servo+1 
	MOVF        R2, 0 
	MOVWF       FLOC__setup_servo+2 
	MOVF        R3, 0 
	MOVWF       FLOC__setup_servo+3 
	MOVF        FARG_setup_servo_n_min+0, 0 
	MOVWF       R0 
	MOVF        FARG_setup_servo_n_min+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__setup_servo+0, 0 
	MOVWF       R0 
	MOVF        FLOC__setup_servo+1, 0 
	MOVWF       R1 
	MOVF        FLOC__setup_servo+2, 0 
	MOVWF       R2 
	MOVF        FLOC__setup_servo+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       setup_servo_n_range_L0+0 
	MOVF        R1, 0 
	MOVWF       setup_servo_n_range_L0+1 
	MOVF        R2, 0 
	MOVWF       setup_servo_n_range_L0+2 
	MOVF        R3, 0 
	MOVWF       setup_servo_n_range_L0+3 
;meArm.c,34 :: 		float a_range = (float)a_max - (float)a_min;
	MOVF        FARG_setup_servo_a_min+0, 0 
	MOVWF       R4 
	MOVF        FARG_setup_servo_a_min+1, 0 
	MOVWF       R5 
	MOVF        FARG_setup_servo_a_min+2, 0 
	MOVWF       R6 
	MOVF        FARG_setup_servo_a_min+3, 0 
	MOVWF       R7 
	MOVF        FARG_setup_servo_a_max+0, 0 
	MOVWF       R0 
	MOVF        FARG_setup_servo_a_max+1, 0 
	MOVWF       R1 
	MOVF        FARG_setup_servo_a_max+2, 0 
	MOVWF       R2 
	MOVF        FARG_setup_servo_a_max+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       setup_servo_a_range_L0+0 
	MOVF        R1, 0 
	MOVWF       setup_servo_a_range_L0+1 
	MOVF        R2, 0 
	MOVWF       setup_servo_a_range_L0+2 
	MOVF        R3, 0 
	MOVWF       setup_servo_a_range_L0+3 
;meArm.c,37 :: 		if(a_range == 0) return false;
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	CALL        _Equals_Double+0, 0
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_setup_servo0
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_setup_servo
L_setup_servo0:
;meArm.c,40 :: 		svo->gain = n_range / a_range;
	MOVLW       4
	ADDWF       FARG_setup_servo_svo+0, 0 
	MOVWF       FLOC__setup_servo+0 
	MOVLW       0
	ADDWFC      FARG_setup_servo_svo+1, 0 
	MOVWF       FLOC__setup_servo+1 
	MOVF        setup_servo_a_range_L0+0, 0 
	MOVWF       R4 
	MOVF        setup_servo_a_range_L0+1, 0 
	MOVWF       R5 
	MOVF        setup_servo_a_range_L0+2, 0 
	MOVWF       R6 
	MOVF        setup_servo_a_range_L0+3, 0 
	MOVWF       R7 
	MOVF        setup_servo_n_range_L0+0, 0 
	MOVWF       R0 
	MOVF        setup_servo_n_range_L0+1, 0 
	MOVWF       R1 
	MOVF        setup_servo_n_range_L0+2, 0 
	MOVWF       R2 
	MOVF        setup_servo_n_range_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVFF       FLOC__setup_servo+0, FSR1
	MOVFF       FLOC__setup_servo+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;meArm.c,41 :: 		svo->zero = (float)n_min - svo->gain * a_min;
	MOVLW       8
	ADDWF       FARG_setup_servo_svo+0, 0 
	MOVWF       FLOC__setup_servo+4 
	MOVLW       0
	ADDWFC      FARG_setup_servo_svo+1, 0 
	MOVWF       FLOC__setup_servo+5 
	MOVF        FARG_setup_servo_n_min+0, 0 
	MOVWF       R0 
	MOVF        FARG_setup_servo_n_min+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__setup_servo+0 
	MOVF        R1, 0 
	MOVWF       FLOC__setup_servo+1 
	MOVF        R2, 0 
	MOVWF       FLOC__setup_servo+2 
	MOVF        R3, 0 
	MOVWF       FLOC__setup_servo+3 
	MOVLW       4
	ADDWF       FARG_setup_servo_svo+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_setup_servo_svo+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        FARG_setup_servo_a_min+0, 0 
	MOVWF       R4 
	MOVF        FARG_setup_servo_a_min+1, 0 
	MOVWF       R5 
	MOVF        FARG_setup_servo_a_min+2, 0 
	MOVWF       R6 
	MOVF        FARG_setup_servo_a_min+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__setup_servo+0, 0 
	MOVWF       R0 
	MOVF        FLOC__setup_servo+1, 0 
	MOVWF       R1 
	MOVF        FLOC__setup_servo+2, 0 
	MOVWF       R2 
	MOVF        FLOC__setup_servo+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVFF       FLOC__setup_servo+4, FSR1
	MOVFF       FLOC__setup_servo+5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;meArm.c,44 :: 		svo->n_min = n_min;
	MOVFF       FARG_setup_servo_svo+0, FSR1
	MOVFF       FARG_setup_servo_svo+1, FSR1H
	MOVF        FARG_setup_servo_n_min+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_setup_servo_n_min+1, 0 
	MOVWF       POSTINC1+0 
;meArm.c,45 :: 		svo->n_max = n_max;
	MOVLW       2
	ADDWF       FARG_setup_servo_svo+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_setup_servo_svo+1, 0 
	MOVWF       FSR1H 
	MOVF        FARG_setup_servo_n_max+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_setup_servo_n_max+1, 0 
	MOVWF       POSTINC1+0 
;meArm.c,47 :: 		return true;
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
;meArm.c,48 :: 		}
L_end_setup_servo:
	RETURN      0
; end of _setup_servo

_rad2Angle:

;meArm.c,50 :: 		float rad2Angle (ServoInfo* svo, const float rad)
;meArm.c,53 :: 		return ((svo->zero) + ((svo->gain) * rad));
	MOVLW       8
	ADDWF       FARG_rad2Angle_svo+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_rad2Angle_svo+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__rad2Angle+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__rad2Angle+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__rad2Angle+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__rad2Angle+3 
	MOVLW       4
	ADDWF       FARG_rad2Angle_svo+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_rad2Angle_svo+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        FARG_rad2Angle_rad+0, 0 
	MOVWF       R4 
	MOVF        FARG_rad2Angle_rad+1, 0 
	MOVWF       R5 
	MOVF        FARG_rad2Angle_rad+2, 0 
	MOVWF       R6 
	MOVF        FARG_rad2Angle_rad+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__rad2Angle+0, 0 
	MOVWF       R4 
	MOVF        FLOC__rad2Angle+1, 0 
	MOVWF       R5 
	MOVF        FLOC__rad2Angle+2, 0 
	MOVWF       R6 
	MOVF        FLOC__rad2Angle+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
;meArm.c,55 :: 		}
L_end_rad2Angle:
	RETURN      0
; end of _rad2Angle

_meArm_calib:

;meArm.c,58 :: 		void meArm_calib(char *calib) {
;meArm.c,61 :: 		int sweepMinBase=calib[0];
	MOVFF       FARG_meArm_calib_calib+0, FSR0
	MOVFF       FARG_meArm_calib_calib+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       meArm_calib_sweepMinBase_L0+0 
	MOVLW       0
	MOVWF       meArm_calib_sweepMinBase_L0+1 
	MOVLW       0
	MOVWF       meArm_calib_sweepMinBase_L0+1 
;meArm.c,62 :: 		int sweepMaxBase=calib[1];
	MOVLW       1
	ADDWF       FARG_meArm_calib_calib+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_meArm_calib_calib+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       meArm_calib_sweepMaxBase_L0+0 
	MOVLW       0
	MOVWF       meArm_calib_sweepMaxBase_L0+1 
	MOVLW       0
	MOVWF       meArm_calib_sweepMaxBase_L0+1 
;meArm.c,63 :: 		int sweepMinShoulder=calib[2];
	MOVLW       2
	ADDWF       FARG_meArm_calib_calib+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_meArm_calib_calib+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       meArm_calib_sweepMinShoulder_L0+0 
	MOVLW       0
	MOVWF       meArm_calib_sweepMinShoulder_L0+1 
	MOVLW       0
	MOVWF       meArm_calib_sweepMinShoulder_L0+1 
;meArm.c,64 :: 		int sweepMaxShoulder=calib[3];
	MOVLW       3
	ADDWF       FARG_meArm_calib_calib+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_meArm_calib_calib+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       meArm_calib_sweepMaxShoulder_L0+0 
	MOVLW       0
	MOVWF       meArm_calib_sweepMaxShoulder_L0+1 
	MOVLW       0
	MOVWF       meArm_calib_sweepMaxShoulder_L0+1 
;meArm.c,65 :: 		int sweepMinElbow=calib[4];
	MOVLW       4
	ADDWF       FARG_meArm_calib_calib+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_meArm_calib_calib+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       meArm_calib_sweepMinElbow_L0+0 
	MOVLW       0
	MOVWF       meArm_calib_sweepMinElbow_L0+1 
	MOVLW       0
	MOVWF       meArm_calib_sweepMinElbow_L0+1 
;meArm.c,66 :: 		int sweepMaxElbow=calib[5];
	MOVLW       5
	ADDWF       FARG_meArm_calib_calib+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_meArm_calib_calib+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       meArm_calib_sweepMaxElbow_L0+0 
	MOVLW       0
	MOVWF       meArm_calib_sweepMaxElbow_L0+1 
	MOVLW       0
	MOVWF       meArm_calib_sweepMaxElbow_L0+1 
;meArm.c,67 :: 		int sweepMinGripper=calib[6];
	MOVLW       6
	ADDWF       FARG_meArm_calib_calib+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_meArm_calib_calib+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       meArm_calib_sweepMinGripper_L0+0 
	MOVLW       0
	MOVWF       meArm_calib_sweepMinGripper_L0+1 
	MOVLW       0
	MOVWF       meArm_calib_sweepMinGripper_L0+1 
;meArm.c,68 :: 		int sweepMaxGripper=calib[7];
	MOVLW       7
	ADDWF       FARG_meArm_calib_calib+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_meArm_calib_calib+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       meArm_calib_sweepMaxGripper_L0+0 
	MOVLW       0
	MOVWF       meArm_calib_sweepMaxGripper_L0+1 
	MOVLW       0
	MOVWF       meArm_calib_sweepMaxGripper_L0+1 
;meArm.c,70 :: 		float angleMinBase=-pi/2.0;
	MOVLW       ?ICSmeArm_calib_angleMinBase_L0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICSmeArm_calib_angleMinBase_L0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICSmeArm_calib_angleMinBase_L0+0)
	MOVWF       TBLPTRU 
	MOVLW       meArm_calib_angleMinBase_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(meArm_calib_angleMinBase_L0+0)
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;meArm.c,98 :: 		setup_servo(&_svoBase, sweepMinBase, sweepMaxBase, angleMinBase, angleMaxBase);
	MOVLW       __svoBase+0
	MOVWF       FARG_setup_servo_svo+0 
	MOVLW       hi_addr(__svoBase+0)
	MOVWF       FARG_setup_servo_svo+1 
	MOVF        meArm_calib_sweepMinBase_L0+0, 0 
	MOVWF       FARG_setup_servo_n_min+0 
	MOVF        meArm_calib_sweepMinBase_L0+1, 0 
	MOVWF       FARG_setup_servo_n_min+1 
	MOVF        meArm_calib_sweepMaxBase_L0+0, 0 
	MOVWF       FARG_setup_servo_n_max+0 
	MOVF        meArm_calib_sweepMaxBase_L0+1, 0 
	MOVWF       FARG_setup_servo_n_max+1 
	MOVF        meArm_calib_angleMinBase_L0+0, 0 
	MOVWF       FARG_setup_servo_a_min+0 
	MOVF        meArm_calib_angleMinBase_L0+1, 0 
	MOVWF       FARG_setup_servo_a_min+1 
	MOVF        meArm_calib_angleMinBase_L0+2, 0 
	MOVWF       FARG_setup_servo_a_min+2 
	MOVF        meArm_calib_angleMinBase_L0+3, 0 
	MOVWF       FARG_setup_servo_a_min+3 
	MOVF        meArm_calib_angleMaxBase_L0+0, 0 
	MOVWF       FARG_setup_servo_a_max+0 
	MOVF        meArm_calib_angleMaxBase_L0+1, 0 
	MOVWF       FARG_setup_servo_a_max+1 
	MOVF        meArm_calib_angleMaxBase_L0+2, 0 
	MOVWF       FARG_setup_servo_a_max+2 
	MOVF        meArm_calib_angleMaxBase_L0+3, 0 
	MOVWF       FARG_setup_servo_a_max+3 
	CALL        _setup_servo+0, 0
;meArm.c,99 :: 		setup_servo(&_svoShoulder, sweepMinShoulder, sweepMaxShoulder, angleMinShoulder, angleMaxShoulder);
	MOVLW       __svoShoulder+0
	MOVWF       FARG_setup_servo_svo+0 
	MOVLW       hi_addr(__svoShoulder+0)
	MOVWF       FARG_setup_servo_svo+1 
	MOVF        meArm_calib_sweepMinShoulder_L0+0, 0 
	MOVWF       FARG_setup_servo_n_min+0 
	MOVF        meArm_calib_sweepMinShoulder_L0+1, 0 
	MOVWF       FARG_setup_servo_n_min+1 
	MOVF        meArm_calib_sweepMaxShoulder_L0+0, 0 
	MOVWF       FARG_setup_servo_n_max+0 
	MOVF        meArm_calib_sweepMaxShoulder_L0+1, 0 
	MOVWF       FARG_setup_servo_n_max+1 
	MOVF        meArm_calib_angleMinShoulder_L0+0, 0 
	MOVWF       FARG_setup_servo_a_min+0 
	MOVF        meArm_calib_angleMinShoulder_L0+1, 0 
	MOVWF       FARG_setup_servo_a_min+1 
	MOVF        meArm_calib_angleMinShoulder_L0+2, 0 
	MOVWF       FARG_setup_servo_a_min+2 
	MOVF        meArm_calib_angleMinShoulder_L0+3, 0 
	MOVWF       FARG_setup_servo_a_min+3 
	MOVF        meArm_calib_angleMaxShoulder_L0+0, 0 
	MOVWF       FARG_setup_servo_a_max+0 
	MOVF        meArm_calib_angleMaxShoulder_L0+1, 0 
	MOVWF       FARG_setup_servo_a_max+1 
	MOVF        meArm_calib_angleMaxShoulder_L0+2, 0 
	MOVWF       FARG_setup_servo_a_max+2 
	MOVF        meArm_calib_angleMaxShoulder_L0+3, 0 
	MOVWF       FARG_setup_servo_a_max+3 
	CALL        _setup_servo+0, 0
;meArm.c,100 :: 		setup_servo(&_svoElbow, sweepMinElbow, sweepMaxElbow, angleMinElbow, angleMaxElbow);
	MOVLW       __svoElbow+0
	MOVWF       FARG_setup_servo_svo+0 
	MOVLW       hi_addr(__svoElbow+0)
	MOVWF       FARG_setup_servo_svo+1 
	MOVF        meArm_calib_sweepMinElbow_L0+0, 0 
	MOVWF       FARG_setup_servo_n_min+0 
	MOVF        meArm_calib_sweepMinElbow_L0+1, 0 
	MOVWF       FARG_setup_servo_n_min+1 
	MOVF        meArm_calib_sweepMaxElbow_L0+0, 0 
	MOVWF       FARG_setup_servo_n_max+0 
	MOVF        meArm_calib_sweepMaxElbow_L0+1, 0 
	MOVWF       FARG_setup_servo_n_max+1 
	MOVF        meArm_calib_angleMinElbow_L0+0, 0 
	MOVWF       FARG_setup_servo_a_min+0 
	MOVF        meArm_calib_angleMinElbow_L0+1, 0 
	MOVWF       FARG_setup_servo_a_min+1 
	MOVF        meArm_calib_angleMinElbow_L0+2, 0 
	MOVWF       FARG_setup_servo_a_min+2 
	MOVF        meArm_calib_angleMinElbow_L0+3, 0 
	MOVWF       FARG_setup_servo_a_min+3 
	MOVF        meArm_calib_angleMaxElbow_L0+0, 0 
	MOVWF       FARG_setup_servo_a_max+0 
	MOVF        meArm_calib_angleMaxElbow_L0+1, 0 
	MOVWF       FARG_setup_servo_a_max+1 
	MOVF        meArm_calib_angleMaxElbow_L0+2, 0 
	MOVWF       FARG_setup_servo_a_max+2 
	MOVF        meArm_calib_angleMaxElbow_L0+3, 0 
	MOVWF       FARG_setup_servo_a_max+3 
	CALL        _setup_servo+0, 0
;meArm.c,101 :: 		setup_servo(&_svoGripper, sweepMinGripper, sweepMaxGripper, angleMinGripper, angleMaxGripper);
	MOVLW       __svoGripper+0
	MOVWF       FARG_setup_servo_svo+0 
	MOVLW       hi_addr(__svoGripper+0)
	MOVWF       FARG_setup_servo_svo+1 
	MOVF        meArm_calib_sweepMinGripper_L0+0, 0 
	MOVWF       FARG_setup_servo_n_min+0 
	MOVF        meArm_calib_sweepMinGripper_L0+1, 0 
	MOVWF       FARG_setup_servo_n_min+1 
	MOVF        meArm_calib_sweepMaxGripper_L0+0, 0 
	MOVWF       FARG_setup_servo_n_max+0 
	MOVF        meArm_calib_sweepMaxGripper_L0+1, 0 
	MOVWF       FARG_setup_servo_n_max+1 
	MOVF        meArm_calib_angleMinGripper_L0+0, 0 
	MOVWF       FARG_setup_servo_a_min+0 
	MOVF        meArm_calib_angleMinGripper_L0+1, 0 
	MOVWF       FARG_setup_servo_a_min+1 
	MOVF        meArm_calib_angleMinGripper_L0+2, 0 
	MOVWF       FARG_setup_servo_a_min+2 
	MOVF        meArm_calib_angleMinGripper_L0+3, 0 
	MOVWF       FARG_setup_servo_a_min+3 
	MOVF        meArm_calib_angleMaxGripper_L0+0, 0 
	MOVWF       FARG_setup_servo_a_max+0 
	MOVF        meArm_calib_angleMaxGripper_L0+1, 0 
	MOVWF       FARG_setup_servo_a_max+1 
	MOVF        meArm_calib_angleMaxGripper_L0+2, 0 
	MOVWF       FARG_setup_servo_a_max+2 
	MOVF        meArm_calib_angleMaxGripper_L0+3, 0 
	MOVWF       FARG_setup_servo_a_max+3 
	CALL        _setup_servo+0, 0
;meArm.c,103 :: 		}
L_end_meArm_calib:
	RETURN      0
; end of _meArm_calib

_meArm_begin:

;meArm.c,106 :: 		void meArm_begin(char portAddr, int pinBase, int pinShoulder, int pinElbow, int pinGripper) {
;meArm.c,107 :: 		_pinBase = pinBase;
	MOVF        FARG_meArm_begin_pinBase+0, 0 
	MOVWF       __pinBase+0 
	MOVF        FARG_meArm_begin_pinBase+1, 0 
	MOVWF       __pinBase+1 
;meArm.c,108 :: 		_pinShoulder = pinShoulder;
	MOVF        FARG_meArm_begin_pinShoulder+0, 0 
	MOVWF       __pinShoulder+0 
	MOVF        FARG_meArm_begin_pinShoulder+1, 0 
	MOVWF       __pinShoulder+1 
;meArm.c,109 :: 		_pinElbow = pinElbow;
	MOVF        FARG_meArm_begin_pinElbow+0, 0 
	MOVWF       __pinElbow+0 
	MOVF        FARG_meArm_begin_pinElbow+1, 0 
	MOVWF       __pinElbow+1 
;meArm.c,110 :: 		_pinGripper = pinGripper;
	MOVF        FARG_meArm_begin_pinGripper+0, 0 
	MOVWF       __pinGripper+0 
	MOVF        FARG_meArm_begin_pinGripper+1, 0 
	MOVWF       __pinGripper+1 
;meArm.c,111 :: 		_svoBase.id = 0;
	CLRF        __svoBase+12 
	CLRF        __svoBase+13 
;meArm.c,112 :: 		_svoShoulder.id = 1;
	MOVLW       1
	MOVWF       __svoShoulder+12 
	MOVLW       0
	MOVWF       __svoShoulder+13 
;meArm.c,113 :: 		_svoElbow.id = 2;
	MOVLW       2
	MOVWF       __svoElbow+12 
	MOVLW       0
	MOVWF       __svoElbow+13 
;meArm.c,114 :: 		_svoGripper.id = 3;
	MOVLW       3
	MOVWF       __svoGripper+12 
	MOVLW       0
	MOVWF       __svoGripper+13 
;meArm.c,116 :: 		ServoInit();
	CALL        _ServoInit+0, 0
;meArm.c,117 :: 		ServoAttach( _svoBase.id,      portAddr, _pinBase );
	MOVF        __svoBase+12, 0 
	MOVWF       FARG_ServoAttach_servo+0 
	MOVF        FARG_meArm_begin_portAddr+0, 0 
	MOVWF       FARG_ServoAttach_out+0 
	MOVF        __pinBase+0, 0 
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;meArm.c,118 :: 		ServoAttach( _svoShoulder.id,  portAddr, _pinShoulder );
	MOVF        __svoShoulder+12, 0 
	MOVWF       FARG_ServoAttach_servo+0 
	MOVF        FARG_meArm_begin_portAddr+0, 0 
	MOVWF       FARG_ServoAttach_out+0 
	MOVF        __pinShoulder+0, 0 
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;meArm.c,119 :: 		ServoAttach( _svoElbow.id,     portAddr, _pinElbow );
	MOVF        __svoElbow+12, 0 
	MOVWF       FARG_ServoAttach_servo+0 
	MOVF        FARG_meArm_begin_portAddr+0, 0 
	MOVWF       FARG_ServoAttach_out+0 
	MOVF        __pinElbow+0, 0 
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;meArm.c,120 :: 		ServoAttach( _svoGripper.id,   portAddr, _pinGripper );
	MOVF        __svoGripper+12, 0 
	MOVWF       FARG_ServoAttach_servo+0 
	MOVF        FARG_meArm_begin_portAddr+0, 0 
	MOVWF       FARG_ServoAttach_out+0 
	MOVF        __pinGripper+0, 0 
	MOVWF       FARG_ServoAttach_pin+0 
	CALL        _ServoAttach+0, 0
;meArm.c,122 :: 		meArm_goDirectlyToCylinder(0, 130, 50);
	CLRF        FARG_meArm_goDirectlyToCylinder_theta+0 
	CLRF        FARG_meArm_goDirectlyToCylinder_theta+1 
	CLRF        FARG_meArm_goDirectlyToCylinder_theta+2 
	CLRF        FARG_meArm_goDirectlyToCylinder_theta+3 
	MOVLW       0
	MOVWF       FARG_meArm_goDirectlyToCylinder_r+0 
	MOVLW       0
	MOVWF       FARG_meArm_goDirectlyToCylinder_r+1 
	MOVLW       2
	MOVWF       FARG_meArm_goDirectlyToCylinder_r+2 
	MOVLW       134
	MOVWF       FARG_meArm_goDirectlyToCylinder_r+3 
	MOVLW       0
	MOVWF       FARG_meArm_goDirectlyToCylinder_z+0 
	MOVLW       0
	MOVWF       FARG_meArm_goDirectlyToCylinder_z+1 
	MOVLW       72
	MOVWF       FARG_meArm_goDirectlyToCylinder_z+2 
	MOVLW       132
	MOVWF       FARG_meArm_goDirectlyToCylinder_z+3 
	CALL        _meArm_goDirectlyToCylinder+0, 0
;meArm.c,123 :: 		meArm_openGripper();
	CALL        _meArm_openGripper+0, 0
;meArm.c,124 :: 		}
L_end_meArm_begin:
	RETURN      0
; end of _meArm_begin

_meArm_goDirectlyTo:

;meArm.c,128 :: 		void meArm_goDirectlyTo(float x, float y, float z) {
;meArm.c,132 :: 		solve = solve(x, y, z, &radBase, &radShoulder, &radElbow);
	MOVF        FARG_meArm_goDirectlyTo_x+0, 0 
	MOVWF       FARG_solve_x+0 
	MOVF        FARG_meArm_goDirectlyTo_x+1, 0 
	MOVWF       FARG_solve_x+1 
	MOVF        FARG_meArm_goDirectlyTo_x+2, 0 
	MOVWF       FARG_solve_x+2 
	MOVF        FARG_meArm_goDirectlyTo_x+3, 0 
	MOVWF       FARG_solve_x+3 
	MOVF        FARG_meArm_goDirectlyTo_y+0, 0 
	MOVWF       FARG_solve_y+0 
	MOVF        FARG_meArm_goDirectlyTo_y+1, 0 
	MOVWF       FARG_solve_y+1 
	MOVF        FARG_meArm_goDirectlyTo_y+2, 0 
	MOVWF       FARG_solve_y+2 
	MOVF        FARG_meArm_goDirectlyTo_y+3, 0 
	MOVWF       FARG_solve_y+3 
	MOVF        FARG_meArm_goDirectlyTo_z+0, 0 
	MOVWF       FARG_solve_z+0 
	MOVF        FARG_meArm_goDirectlyTo_z+1, 0 
	MOVWF       FARG_solve_z+1 
	MOVF        FARG_meArm_goDirectlyTo_z+2, 0 
	MOVWF       FARG_solve_z+2 
	MOVF        FARG_meArm_goDirectlyTo_z+3, 0 
	MOVWF       FARG_solve_z+3 
	MOVLW       meArm_goDirectlyTo_radBase_L0+0
	MOVWF       FARG_solve_a0+0 
	MOVLW       hi_addr(meArm_goDirectlyTo_radBase_L0+0)
	MOVWF       FARG_solve_a0+1 
	MOVLW       meArm_goDirectlyTo_radShoulder_L0+0
	MOVWF       FARG_solve_a1+0 
	MOVLW       hi_addr(meArm_goDirectlyTo_radShoulder_L0+0)
	MOVWF       FARG_solve_a1+1 
	MOVLW       meArm_goDirectlyTo_radElbow_L0+0
	MOVWF       FARG_solve_a2+0 
	MOVLW       hi_addr(meArm_goDirectlyTo_radElbow_L0+0)
	MOVWF       FARG_solve_a2+1 
	CALL        _solve+0, 0
	MOVF        R0, 0 
	MOVWF       meArm_goDirectlyTo_solve_L0+0 
	MOVF        R1, 0 
	MOVWF       meArm_goDirectlyTo_solve_L0+1 
;meArm.c,133 :: 		if (solve) {
	MOVF        meArm_goDirectlyTo_solve_L0+0, 0 
	IORWF       meArm_goDirectlyTo_solve_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_meArm_goDirectlyTo1
;meArm.c,134 :: 		ServoWrite(_svoBase.id,rad2Angle(&_svoBase,radBase));
	MOVLW       __svoBase+0
	MOVWF       FARG_rad2Angle_svo+0 
	MOVLW       hi_addr(__svoBase+0)
	MOVWF       FARG_rad2Angle_svo+1 
	MOVF        meArm_goDirectlyTo_radBase_L0+0, 0 
	MOVWF       FARG_rad2Angle_rad+0 
	MOVF        meArm_goDirectlyTo_radBase_L0+1, 0 
	MOVWF       FARG_rad2Angle_rad+1 
	MOVF        meArm_goDirectlyTo_radBase_L0+2, 0 
	MOVWF       FARG_rad2Angle_rad+2 
	MOVF        meArm_goDirectlyTo_radBase_L0+3, 0 
	MOVWF       FARG_rad2Angle_rad+3 
	CALL        _rad2Angle+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	MOVF        __svoBase+12, 0 
	MOVWF       FARG_ServoWrite_srv_id+0 
	CALL        _ServoWrite+0, 0
;meArm.c,135 :: 		ServoWrite(_svoShoulder.id,rad2Angle(&_svoShoulder,radShoulder));
	MOVLW       __svoShoulder+0
	MOVWF       FARG_rad2Angle_svo+0 
	MOVLW       hi_addr(__svoShoulder+0)
	MOVWF       FARG_rad2Angle_svo+1 
	MOVF        meArm_goDirectlyTo_radShoulder_L0+0, 0 
	MOVWF       FARG_rad2Angle_rad+0 
	MOVF        meArm_goDirectlyTo_radShoulder_L0+1, 0 
	MOVWF       FARG_rad2Angle_rad+1 
	MOVF        meArm_goDirectlyTo_radShoulder_L0+2, 0 
	MOVWF       FARG_rad2Angle_rad+2 
	MOVF        meArm_goDirectlyTo_radShoulder_L0+3, 0 
	MOVWF       FARG_rad2Angle_rad+3 
	CALL        _rad2Angle+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	MOVF        __svoShoulder+12, 0 
	MOVWF       FARG_ServoWrite_srv_id+0 
	CALL        _ServoWrite+0, 0
;meArm.c,136 :: 		ServoWrite(_svoElbow.id,rad2Angle(&_svoElbow,radElbow));
	MOVLW       __svoElbow+0
	MOVWF       FARG_rad2Angle_svo+0 
	MOVLW       hi_addr(__svoElbow+0)
	MOVWF       FARG_rad2Angle_svo+1 
	MOVF        meArm_goDirectlyTo_radElbow_L0+0, 0 
	MOVWF       FARG_rad2Angle_rad+0 
	MOVF        meArm_goDirectlyTo_radElbow_L0+1, 0 
	MOVWF       FARG_rad2Angle_rad+1 
	MOVF        meArm_goDirectlyTo_radElbow_L0+2, 0 
	MOVWF       FARG_rad2Angle_rad+2 
	MOVF        meArm_goDirectlyTo_radElbow_L0+3, 0 
	MOVWF       FARG_rad2Angle_rad+3 
	CALL        _rad2Angle+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	MOVF        __svoElbow+12, 0 
	MOVWF       FARG_ServoWrite_srv_id+0 
	CALL        _ServoWrite+0, 0
;meArm.c,137 :: 		_x = x; _y = y; _z = z;
	MOVF        FARG_meArm_goDirectlyTo_x+0, 0 
	MOVWF       __x+0 
	MOVF        FARG_meArm_goDirectlyTo_x+1, 0 
	MOVWF       __x+1 
	MOVF        FARG_meArm_goDirectlyTo_x+2, 0 
	MOVWF       __x+2 
	MOVF        FARG_meArm_goDirectlyTo_x+3, 0 
	MOVWF       __x+3 
	MOVF        FARG_meArm_goDirectlyTo_y+0, 0 
	MOVWF       __y+0 
	MOVF        FARG_meArm_goDirectlyTo_y+1, 0 
	MOVWF       __y+1 
	MOVF        FARG_meArm_goDirectlyTo_y+2, 0 
	MOVWF       __y+2 
	MOVF        FARG_meArm_goDirectlyTo_y+3, 0 
	MOVWF       __y+3 
	MOVF        FARG_meArm_goDirectlyTo_z+0, 0 
	MOVWF       __z+0 
	MOVF        FARG_meArm_goDirectlyTo_z+1, 0 
	MOVWF       __z+1 
	MOVF        FARG_meArm_goDirectlyTo_z+2, 0 
	MOVWF       __z+2 
	MOVF        FARG_meArm_goDirectlyTo_z+3, 0 
	MOVWF       __z+3 
;meArm.c,138 :: 		}
L_meArm_goDirectlyTo1:
;meArm.c,139 :: 		}
L_end_meArm_goDirectlyTo:
	RETURN      0
; end of _meArm_goDirectlyTo

_meArm_gotoPoint:

;meArm.c,142 :: 		void meArm_gotoPoint(float x, float y, float z) {
;meArm.c,144 :: 		float x0 = _x;
	MOVF        __x+0, 0 
	MOVWF       meArm_gotoPoint_x0_L0+0 
	MOVF        __x+1, 0 
	MOVWF       meArm_gotoPoint_x0_L0+1 
	MOVF        __x+2, 0 
	MOVWF       meArm_gotoPoint_x0_L0+2 
	MOVF        __x+3, 0 
	MOVWF       meArm_gotoPoint_x0_L0+3 
;meArm.c,145 :: 		float y0 = _y;
	MOVF        __y+0, 0 
	MOVWF       meArm_gotoPoint_y0_L0+0 
	MOVF        __y+1, 0 
	MOVWF       meArm_gotoPoint_y0_L0+1 
	MOVF        __y+2, 0 
	MOVWF       meArm_gotoPoint_y0_L0+2 
	MOVF        __y+3, 0 
	MOVWF       meArm_gotoPoint_y0_L0+3 
;meArm.c,146 :: 		float z0 = _z;
	MOVF        __z+0, 0 
	MOVWF       meArm_gotoPoint_z0_L0+0 
	MOVF        __z+1, 0 
	MOVWF       meArm_gotoPoint_z0_L0+1 
	MOVF        __z+2, 0 
	MOVWF       meArm_gotoPoint_z0_L0+2 
	MOVF        __z+3, 0 
	MOVWF       meArm_gotoPoint_z0_L0+3 
;meArm.c,147 :: 		float dist = sqrt((x0-x)*(x0-x)+(y0-y)*(y0-y)+(z0-z)*(z0-z));
	MOVF        FARG_meArm_gotoPoint_x+0, 0 
	MOVWF       R4 
	MOVF        FARG_meArm_gotoPoint_x+1, 0 
	MOVWF       R5 
	MOVF        FARG_meArm_gotoPoint_x+2, 0 
	MOVWF       R6 
	MOVF        FARG_meArm_gotoPoint_x+3, 0 
	MOVWF       R7 
	MOVF        __x+0, 0 
	MOVWF       R0 
	MOVF        __x+1, 0 
	MOVWF       R1 
	MOVF        __x+2, 0 
	MOVWF       R2 
	MOVF        __x+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__meArm_gotoPoint+0 
	MOVF        R1, 0 
	MOVWF       FLOC__meArm_gotoPoint+1 
	MOVF        R2, 0 
	MOVWF       FLOC__meArm_gotoPoint+2 
	MOVF        R3, 0 
	MOVWF       FLOC__meArm_gotoPoint+3 
	MOVF        FARG_meArm_gotoPoint_y+0, 0 
	MOVWF       R4 
	MOVF        FARG_meArm_gotoPoint_y+1, 0 
	MOVWF       R5 
	MOVF        FARG_meArm_gotoPoint_y+2, 0 
	MOVWF       R6 
	MOVF        FARG_meArm_gotoPoint_y+3, 0 
	MOVWF       R7 
	MOVF        meArm_gotoPoint_y0_L0+0, 0 
	MOVWF       R0 
	MOVF        meArm_gotoPoint_y0_L0+1, 0 
	MOVWF       R1 
	MOVF        meArm_gotoPoint_y0_L0+2, 0 
	MOVWF       R2 
	MOVF        meArm_gotoPoint_y0_L0+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__meArm_gotoPoint+0, 0 
	MOVWF       R4 
	MOVF        FLOC__meArm_gotoPoint+1, 0 
	MOVWF       R5 
	MOVF        FLOC__meArm_gotoPoint+2, 0 
	MOVWF       R6 
	MOVF        FLOC__meArm_gotoPoint+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__meArm_gotoPoint+0 
	MOVF        R1, 0 
	MOVWF       FLOC__meArm_gotoPoint+1 
	MOVF        R2, 0 
	MOVWF       FLOC__meArm_gotoPoint+2 
	MOVF        R3, 0 
	MOVWF       FLOC__meArm_gotoPoint+3 
	MOVF        FARG_meArm_gotoPoint_z+0, 0 
	MOVWF       R4 
	MOVF        FARG_meArm_gotoPoint_z+1, 0 
	MOVWF       R5 
	MOVF        FARG_meArm_gotoPoint_z+2, 0 
	MOVWF       R6 
	MOVF        FARG_meArm_gotoPoint_z+3, 0 
	MOVWF       R7 
	MOVF        meArm_gotoPoint_z0_L0+0, 0 
	MOVWF       R0 
	MOVF        meArm_gotoPoint_z0_L0+1, 0 
	MOVWF       R1 
	MOVF        meArm_gotoPoint_z0_L0+2, 0 
	MOVWF       R2 
	MOVF        meArm_gotoPoint_z0_L0+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__meArm_gotoPoint+0, 0 
	MOVWF       R4 
	MOVF        FLOC__meArm_gotoPoint+1, 0 
	MOVWF       R5 
	MOVF        FLOC__meArm_gotoPoint+2, 0 
	MOVWF       R6 
	MOVF        FLOC__meArm_gotoPoint+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_sqrt_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_sqrt_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_sqrt_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_sqrt_x+3 
	CALL        _sqrt+0, 0
	MOVF        R0, 0 
	MOVWF       meArm_gotoPoint_dist_L0+0 
	MOVF        R1, 0 
	MOVWF       meArm_gotoPoint_dist_L0+1 
	MOVF        R2, 0 
	MOVWF       meArm_gotoPoint_dist_L0+2 
	MOVF        R3, 0 
	MOVWF       meArm_gotoPoint_dist_L0+3 
;meArm.c,148 :: 		int step = 10;
	MOVLW       10
	MOVWF       meArm_gotoPoint_step_L0+0 
	MOVLW       0
	MOVWF       meArm_gotoPoint_step_L0+1 
;meArm.c,150 :: 		for (i = 0; i<dist; i+= step) {
	CLRF        meArm_gotoPoint_i_L0+0 
	CLRF        meArm_gotoPoint_i_L0+1 
L_meArm_gotoPoint2:
	MOVF        meArm_gotoPoint_i_L0+0, 0 
	MOVWF       R0 
	MOVF        meArm_gotoPoint_i_L0+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        meArm_gotoPoint_dist_L0+0, 0 
	MOVWF       R4 
	MOVF        meArm_gotoPoint_dist_L0+1, 0 
	MOVWF       R5 
	MOVF        meArm_gotoPoint_dist_L0+2, 0 
	MOVWF       R6 
	MOVF        meArm_gotoPoint_dist_L0+3, 0 
	MOVWF       R7 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_meArm_gotoPoint3
;meArm.c,151 :: 		meArm_goDirectlyTo(x0 + (x-x0)*i/dist, y0 + (y-y0) * i/dist, z0 + (z-z0) * i/dist);
	MOVF        meArm_gotoPoint_x0_L0+0, 0 
	MOVWF       R4 
	MOVF        meArm_gotoPoint_x0_L0+1, 0 
	MOVWF       R5 
	MOVF        meArm_gotoPoint_x0_L0+2, 0 
	MOVWF       R6 
	MOVF        meArm_gotoPoint_x0_L0+3, 0 
	MOVWF       R7 
	MOVF        FARG_meArm_gotoPoint_x+0, 0 
	MOVWF       R0 
	MOVF        FARG_meArm_gotoPoint_x+1, 0 
	MOVWF       R1 
	MOVF        FARG_meArm_gotoPoint_x+2, 0 
	MOVWF       R2 
	MOVF        FARG_meArm_gotoPoint_x+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__meArm_gotoPoint+4 
	MOVF        R1, 0 
	MOVWF       FLOC__meArm_gotoPoint+5 
	MOVF        R2, 0 
	MOVWF       FLOC__meArm_gotoPoint+6 
	MOVF        R3, 0 
	MOVWF       FLOC__meArm_gotoPoint+7 
	MOVF        meArm_gotoPoint_i_L0+0, 0 
	MOVWF       R0 
	MOVF        meArm_gotoPoint_i_L0+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__meArm_gotoPoint+0 
	MOVF        R1, 0 
	MOVWF       FLOC__meArm_gotoPoint+1 
	MOVF        R2, 0 
	MOVWF       FLOC__meArm_gotoPoint+2 
	MOVF        R3, 0 
	MOVWF       FLOC__meArm_gotoPoint+3 
	MOVF        FLOC__meArm_gotoPoint+4, 0 
	MOVWF       R0 
	MOVF        FLOC__meArm_gotoPoint+5, 0 
	MOVWF       R1 
	MOVF        FLOC__meArm_gotoPoint+6, 0 
	MOVWF       R2 
	MOVF        FLOC__meArm_gotoPoint+7, 0 
	MOVWF       R3 
	MOVF        FLOC__meArm_gotoPoint+0, 0 
	MOVWF       R4 
	MOVF        FLOC__meArm_gotoPoint+1, 0 
	MOVWF       R5 
	MOVF        FLOC__meArm_gotoPoint+2, 0 
	MOVWF       R6 
	MOVF        FLOC__meArm_gotoPoint+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        meArm_gotoPoint_dist_L0+0, 0 
	MOVWF       R4 
	MOVF        meArm_gotoPoint_dist_L0+1, 0 
	MOVWF       R5 
	MOVF        meArm_gotoPoint_dist_L0+2, 0 
	MOVWF       R6 
	MOVF        meArm_gotoPoint_dist_L0+3, 0 
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        meArm_gotoPoint_x0_L0+0, 0 
	MOVWF       R4 
	MOVF        meArm_gotoPoint_x0_L0+1, 0 
	MOVWF       R5 
	MOVF        meArm_gotoPoint_x0_L0+2, 0 
	MOVWF       R6 
	MOVF        meArm_gotoPoint_x0_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_meArm_goDirectlyTo_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_meArm_goDirectlyTo_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_meArm_goDirectlyTo_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_meArm_goDirectlyTo_x+3 
	MOVF        meArm_gotoPoint_y0_L0+0, 0 
	MOVWF       R4 
	MOVF        meArm_gotoPoint_y0_L0+1, 0 
	MOVWF       R5 
	MOVF        meArm_gotoPoint_y0_L0+2, 0 
	MOVWF       R6 
	MOVF        meArm_gotoPoint_y0_L0+3, 0 
	MOVWF       R7 
	MOVF        FARG_meArm_gotoPoint_y+0, 0 
	MOVWF       R0 
	MOVF        FARG_meArm_gotoPoint_y+1, 0 
	MOVWF       R1 
	MOVF        FARG_meArm_gotoPoint_y+2, 0 
	MOVWF       R2 
	MOVF        FARG_meArm_gotoPoint_y+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        FLOC__meArm_gotoPoint+0, 0 
	MOVWF       R4 
	MOVF        FLOC__meArm_gotoPoint+1, 0 
	MOVWF       R5 
	MOVF        FLOC__meArm_gotoPoint+2, 0 
	MOVWF       R6 
	MOVF        FLOC__meArm_gotoPoint+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        meArm_gotoPoint_dist_L0+0, 0 
	MOVWF       R4 
	MOVF        meArm_gotoPoint_dist_L0+1, 0 
	MOVWF       R5 
	MOVF        meArm_gotoPoint_dist_L0+2, 0 
	MOVWF       R6 
	MOVF        meArm_gotoPoint_dist_L0+3, 0 
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        meArm_gotoPoint_y0_L0+0, 0 
	MOVWF       R4 
	MOVF        meArm_gotoPoint_y0_L0+1, 0 
	MOVWF       R5 
	MOVF        meArm_gotoPoint_y0_L0+2, 0 
	MOVWF       R6 
	MOVF        meArm_gotoPoint_y0_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_meArm_goDirectlyTo_y+0 
	MOVF        R1, 0 
	MOVWF       FARG_meArm_goDirectlyTo_y+1 
	MOVF        R2, 0 
	MOVWF       FARG_meArm_goDirectlyTo_y+2 
	MOVF        R3, 0 
	MOVWF       FARG_meArm_goDirectlyTo_y+3 
	MOVF        meArm_gotoPoint_z0_L0+0, 0 
	MOVWF       R4 
	MOVF        meArm_gotoPoint_z0_L0+1, 0 
	MOVWF       R5 
	MOVF        meArm_gotoPoint_z0_L0+2, 0 
	MOVWF       R6 
	MOVF        meArm_gotoPoint_z0_L0+3, 0 
	MOVWF       R7 
	MOVF        FARG_meArm_gotoPoint_z+0, 0 
	MOVWF       R0 
	MOVF        FARG_meArm_gotoPoint_z+1, 0 
	MOVWF       R1 
	MOVF        FARG_meArm_gotoPoint_z+2, 0 
	MOVWF       R2 
	MOVF        FARG_meArm_gotoPoint_z+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        FLOC__meArm_gotoPoint+0, 0 
	MOVWF       R4 
	MOVF        FLOC__meArm_gotoPoint+1, 0 
	MOVWF       R5 
	MOVF        FLOC__meArm_gotoPoint+2, 0 
	MOVWF       R6 
	MOVF        FLOC__meArm_gotoPoint+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        meArm_gotoPoint_dist_L0+0, 0 
	MOVWF       R4 
	MOVF        meArm_gotoPoint_dist_L0+1, 0 
	MOVWF       R5 
	MOVF        meArm_gotoPoint_dist_L0+2, 0 
	MOVWF       R6 
	MOVF        meArm_gotoPoint_dist_L0+3, 0 
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        meArm_gotoPoint_z0_L0+0, 0 
	MOVWF       R4 
	MOVF        meArm_gotoPoint_z0_L0+1, 0 
	MOVWF       R5 
	MOVF        meArm_gotoPoint_z0_L0+2, 0 
	MOVWF       R6 
	MOVF        meArm_gotoPoint_z0_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_meArm_goDirectlyTo_z+0 
	MOVF        R1, 0 
	MOVWF       FARG_meArm_goDirectlyTo_z+1 
	MOVF        R2, 0 
	MOVWF       FARG_meArm_goDirectlyTo_z+2 
	MOVF        R3, 0 
	MOVWF       FARG_meArm_goDirectlyTo_z+3 
	CALL        _meArm_goDirectlyTo+0, 0
;meArm.c,152 :: 		Delay_ms(50);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_meArm_gotoPoint5:
	DECFSZ      R13, 1, 1
	BRA         L_meArm_gotoPoint5
	DECFSZ      R12, 1, 1
	BRA         L_meArm_gotoPoint5
	NOP
	NOP
;meArm.c,150 :: 		for (i = 0; i<dist; i+= step) {
	MOVF        meArm_gotoPoint_step_L0+0, 0 
	ADDWF       meArm_gotoPoint_i_L0+0, 1 
	MOVF        meArm_gotoPoint_step_L0+1, 0 
	ADDWFC      meArm_gotoPoint_i_L0+1, 1 
;meArm.c,153 :: 		}
	GOTO        L_meArm_gotoPoint2
L_meArm_gotoPoint3:
;meArm.c,154 :: 		meArm_goDirectlyTo(x, y, z);
	MOVF        FARG_meArm_gotoPoint_x+0, 0 
	MOVWF       FARG_meArm_goDirectlyTo_x+0 
	MOVF        FARG_meArm_gotoPoint_x+1, 0 
	MOVWF       FARG_meArm_goDirectlyTo_x+1 
	MOVF        FARG_meArm_gotoPoint_x+2, 0 
	MOVWF       FARG_meArm_goDirectlyTo_x+2 
	MOVF        FARG_meArm_gotoPoint_x+3, 0 
	MOVWF       FARG_meArm_goDirectlyTo_x+3 
	MOVF        FARG_meArm_gotoPoint_y+0, 0 
	MOVWF       FARG_meArm_goDirectlyTo_y+0 
	MOVF        FARG_meArm_gotoPoint_y+1, 0 
	MOVWF       FARG_meArm_goDirectlyTo_y+1 
	MOVF        FARG_meArm_gotoPoint_y+2, 0 
	MOVWF       FARG_meArm_goDirectlyTo_y+2 
	MOVF        FARG_meArm_gotoPoint_y+3, 0 
	MOVWF       FARG_meArm_goDirectlyTo_y+3 
	MOVF        FARG_meArm_gotoPoint_z+0, 0 
	MOVWF       FARG_meArm_goDirectlyTo_z+0 
	MOVF        FARG_meArm_gotoPoint_z+1, 0 
	MOVWF       FARG_meArm_goDirectlyTo_z+1 
	MOVF        FARG_meArm_gotoPoint_z+2, 0 
	MOVWF       FARG_meArm_goDirectlyTo_z+2 
	MOVF        FARG_meArm_gotoPoint_z+3, 0 
	MOVWF       FARG_meArm_goDirectlyTo_z+3 
	CALL        _meArm_goDirectlyTo+0, 0
;meArm.c,155 :: 		Delay_ms(50);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_meArm_gotoPoint6:
	DECFSZ      R13, 1, 1
	BRA         L_meArm_gotoPoint6
	DECFSZ      R12, 1, 1
	BRA         L_meArm_gotoPoint6
	NOP
	NOP
;meArm.c,156 :: 		}
L_end_meArm_gotoPoint:
	RETURN      0
; end of _meArm_gotoPoint

_meArm_polarToCartesian:

;meArm.c,159 :: 		void meArm_polarToCartesian(float theta, float r, float* x, float* y){
;meArm.c,160 :: 		_r = r;
	MOVF        FARG_meArm_polarToCartesian_r+0, 0 
	MOVWF       __r+0 
	MOVF        FARG_meArm_polarToCartesian_r+1, 0 
	MOVWF       __r+1 
	MOVF        FARG_meArm_polarToCartesian_r+2, 0 
	MOVWF       __r+2 
	MOVF        FARG_meArm_polarToCartesian_r+3, 0 
	MOVWF       __r+3 
;meArm.c,161 :: 		_t = theta;
	MOVF        FARG_meArm_polarToCartesian_theta+0, 0 
	MOVWF       __t+0 
	MOVF        FARG_meArm_polarToCartesian_theta+1, 0 
	MOVWF       __t+1 
	MOVF        FARG_meArm_polarToCartesian_theta+2, 0 
	MOVWF       __t+2 
	MOVF        FARG_meArm_polarToCartesian_theta+3, 0 
	MOVWF       __t+3 
;meArm.c,162 :: 		*x = r*sin(theta);
	MOVF        FARG_meArm_polarToCartesian_theta+0, 0 
	MOVWF       FARG_sin_f+0 
	MOVF        FARG_meArm_polarToCartesian_theta+1, 0 
	MOVWF       FARG_sin_f+1 
	MOVF        FARG_meArm_polarToCartesian_theta+2, 0 
	MOVWF       FARG_sin_f+2 
	MOVF        FARG_meArm_polarToCartesian_theta+3, 0 
	MOVWF       FARG_sin_f+3 
	CALL        _sin+0, 0
	MOVF        FARG_meArm_polarToCartesian_r+0, 0 
	MOVWF       R4 
	MOVF        FARG_meArm_polarToCartesian_r+1, 0 
	MOVWF       R5 
	MOVF        FARG_meArm_polarToCartesian_r+2, 0 
	MOVWF       R6 
	MOVF        FARG_meArm_polarToCartesian_r+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVFF       FARG_meArm_polarToCartesian_x+0, FSR1
	MOVFF       FARG_meArm_polarToCartesian_x+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;meArm.c,163 :: 		*y = r*cos(theta);
	MOVF        FARG_meArm_polarToCartesian_theta+0, 0 
	MOVWF       FARG_cos_f+0 
	MOVF        FARG_meArm_polarToCartesian_theta+1, 0 
	MOVWF       FARG_cos_f+1 
	MOVF        FARG_meArm_polarToCartesian_theta+2, 0 
	MOVWF       FARG_cos_f+2 
	MOVF        FARG_meArm_polarToCartesian_theta+3, 0 
	MOVWF       FARG_cos_f+3 
	CALL        _cos+0, 0
	MOVF        FARG_meArm_polarToCartesian_r+0, 0 
	MOVWF       R4 
	MOVF        FARG_meArm_polarToCartesian_r+1, 0 
	MOVWF       R5 
	MOVF        FARG_meArm_polarToCartesian_r+2, 0 
	MOVWF       R6 
	MOVF        FARG_meArm_polarToCartesian_r+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVFF       FARG_meArm_polarToCartesian_y+0, FSR1
	MOVFF       FARG_meArm_polarToCartesian_y+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;meArm.c,164 :: 		}
L_end_meArm_polarToCartesian:
	RETURN      0
; end of _meArm_polarToCartesian

_meArm_gotoPointCylinder:

;meArm.c,167 :: 		void meArm_gotoPointCylinder(float theta, float r, float z){
;meArm.c,169 :: 		meArm_polarToCartesian(theta, r, &x, &y);
	MOVF        FARG_meArm_gotoPointCylinder_theta+0, 0 
	MOVWF       FARG_meArm_polarToCartesian_theta+0 
	MOVF        FARG_meArm_gotoPointCylinder_theta+1, 0 
	MOVWF       FARG_meArm_polarToCartesian_theta+1 
	MOVF        FARG_meArm_gotoPointCylinder_theta+2, 0 
	MOVWF       FARG_meArm_polarToCartesian_theta+2 
	MOVF        FARG_meArm_gotoPointCylinder_theta+3, 0 
	MOVWF       FARG_meArm_polarToCartesian_theta+3 
	MOVF        FARG_meArm_gotoPointCylinder_r+0, 0 
	MOVWF       FARG_meArm_polarToCartesian_r+0 
	MOVF        FARG_meArm_gotoPointCylinder_r+1, 0 
	MOVWF       FARG_meArm_polarToCartesian_r+1 
	MOVF        FARG_meArm_gotoPointCylinder_r+2, 0 
	MOVWF       FARG_meArm_polarToCartesian_r+2 
	MOVF        FARG_meArm_gotoPointCylinder_r+3, 0 
	MOVWF       FARG_meArm_polarToCartesian_r+3 
	MOVLW       meArm_gotoPointCylinder_x_L0+0
	MOVWF       FARG_meArm_polarToCartesian_x+0 
	MOVLW       hi_addr(meArm_gotoPointCylinder_x_L0+0)
	MOVWF       FARG_meArm_polarToCartesian_x+1 
	MOVLW       meArm_gotoPointCylinder_y_L0+0
	MOVWF       FARG_meArm_polarToCartesian_y+0 
	MOVLW       hi_addr(meArm_gotoPointCylinder_y_L0+0)
	MOVWF       FARG_meArm_polarToCartesian_y+1 
	CALL        _meArm_polarToCartesian+0, 0
;meArm.c,170 :: 		meArm_gotoPoint(x,y,z);
	MOVF        meArm_gotoPointCylinder_x_L0+0, 0 
	MOVWF       FARG_meArm_gotoPoint_x+0 
	MOVF        meArm_gotoPointCylinder_x_L0+1, 0 
	MOVWF       FARG_meArm_gotoPoint_x+1 
	MOVF        meArm_gotoPointCylinder_x_L0+2, 0 
	MOVWF       FARG_meArm_gotoPoint_x+2 
	MOVF        meArm_gotoPointCylinder_x_L0+3, 0 
	MOVWF       FARG_meArm_gotoPoint_x+3 
	MOVF        meArm_gotoPointCylinder_y_L0+0, 0 
	MOVWF       FARG_meArm_gotoPoint_y+0 
	MOVF        meArm_gotoPointCylinder_y_L0+1, 0 
	MOVWF       FARG_meArm_gotoPoint_y+1 
	MOVF        meArm_gotoPointCylinder_y_L0+2, 0 
	MOVWF       FARG_meArm_gotoPoint_y+2 
	MOVF        meArm_gotoPointCylinder_y_L0+3, 0 
	MOVWF       FARG_meArm_gotoPoint_y+3 
	MOVF        FARG_meArm_gotoPointCylinder_z+0, 0 
	MOVWF       FARG_meArm_gotoPoint_z+0 
	MOVF        FARG_meArm_gotoPointCylinder_z+1, 0 
	MOVWF       FARG_meArm_gotoPoint_z+1 
	MOVF        FARG_meArm_gotoPointCylinder_z+2, 0 
	MOVWF       FARG_meArm_gotoPoint_z+2 
	MOVF        FARG_meArm_gotoPointCylinder_z+3, 0 
	MOVWF       FARG_meArm_gotoPoint_z+3 
	CALL        _meArm_gotoPoint+0, 0
;meArm.c,171 :: 		}
L_end_meArm_gotoPointCylinder:
	RETURN      0
; end of _meArm_gotoPointCylinder

_meArm_goDirectlyToCylinder:

;meArm.c,173 :: 		void meArm_goDirectlyToCylinder(float theta, float r, float z){
;meArm.c,175 :: 		meArm_polarToCartesian(theta, r, &x, &y);
	MOVF        FARG_meArm_goDirectlyToCylinder_theta+0, 0 
	MOVWF       FARG_meArm_polarToCartesian_theta+0 
	MOVF        FARG_meArm_goDirectlyToCylinder_theta+1, 0 
	MOVWF       FARG_meArm_polarToCartesian_theta+1 
	MOVF        FARG_meArm_goDirectlyToCylinder_theta+2, 0 
	MOVWF       FARG_meArm_polarToCartesian_theta+2 
	MOVF        FARG_meArm_goDirectlyToCylinder_theta+3, 0 
	MOVWF       FARG_meArm_polarToCartesian_theta+3 
	MOVF        FARG_meArm_goDirectlyToCylinder_r+0, 0 
	MOVWF       FARG_meArm_polarToCartesian_r+0 
	MOVF        FARG_meArm_goDirectlyToCylinder_r+1, 0 
	MOVWF       FARG_meArm_polarToCartesian_r+1 
	MOVF        FARG_meArm_goDirectlyToCylinder_r+2, 0 
	MOVWF       FARG_meArm_polarToCartesian_r+2 
	MOVF        FARG_meArm_goDirectlyToCylinder_r+3, 0 
	MOVWF       FARG_meArm_polarToCartesian_r+3 
	MOVLW       meArm_goDirectlyToCylinder_x_L0+0
	MOVWF       FARG_meArm_polarToCartesian_x+0 
	MOVLW       hi_addr(meArm_goDirectlyToCylinder_x_L0+0)
	MOVWF       FARG_meArm_polarToCartesian_x+1 
	MOVLW       meArm_goDirectlyToCylinder_y_L0+0
	MOVWF       FARG_meArm_polarToCartesian_y+0 
	MOVLW       hi_addr(meArm_goDirectlyToCylinder_y_L0+0)
	MOVWF       FARG_meArm_polarToCartesian_y+1 
	CALL        _meArm_polarToCartesian+0, 0
;meArm.c,176 :: 		meArm_goDirectlyTo(x,y,z);
	MOVF        meArm_goDirectlyToCylinder_x_L0+0, 0 
	MOVWF       FARG_meArm_goDirectlyTo_x+0 
	MOVF        meArm_goDirectlyToCylinder_x_L0+1, 0 
	MOVWF       FARG_meArm_goDirectlyTo_x+1 
	MOVF        meArm_goDirectlyToCylinder_x_L0+2, 0 
	MOVWF       FARG_meArm_goDirectlyTo_x+2 
	MOVF        meArm_goDirectlyToCylinder_x_L0+3, 0 
	MOVWF       FARG_meArm_goDirectlyTo_x+3 
	MOVF        meArm_goDirectlyToCylinder_y_L0+0, 0 
	MOVWF       FARG_meArm_goDirectlyTo_y+0 
	MOVF        meArm_goDirectlyToCylinder_y_L0+1, 0 
	MOVWF       FARG_meArm_goDirectlyTo_y+1 
	MOVF        meArm_goDirectlyToCylinder_y_L0+2, 0 
	MOVWF       FARG_meArm_goDirectlyTo_y+2 
	MOVF        meArm_goDirectlyToCylinder_y_L0+3, 0 
	MOVWF       FARG_meArm_goDirectlyTo_y+3 
	MOVF        FARG_meArm_goDirectlyToCylinder_z+0, 0 
	MOVWF       FARG_meArm_goDirectlyTo_z+0 
	MOVF        FARG_meArm_goDirectlyToCylinder_z+1, 0 
	MOVWF       FARG_meArm_goDirectlyTo_z+1 
	MOVF        FARG_meArm_goDirectlyToCylinder_z+2, 0 
	MOVWF       FARG_meArm_goDirectlyTo_z+2 
	MOVF        FARG_meArm_goDirectlyToCylinder_z+3, 0 
	MOVWF       FARG_meArm_goDirectlyTo_z+3 
	CALL        _meArm_goDirectlyTo+0, 0
;meArm.c,177 :: 		}
L_end_meArm_goDirectlyToCylinder:
	RETURN      0
; end of _meArm_goDirectlyToCylinder

_meArm_isReachable:

;meArm.c,180 :: 		int meArm_isReachable(float x, float y, float z) {
;meArm.c,182 :: 		return (solve(x, y, z, &radBase, &radShoulder, &radElbow));
	MOVF        FARG_meArm_isReachable_x+0, 0 
	MOVWF       FARG_solve_x+0 
	MOVF        FARG_meArm_isReachable_x+1, 0 
	MOVWF       FARG_solve_x+1 
	MOVF        FARG_meArm_isReachable_x+2, 0 
	MOVWF       FARG_solve_x+2 
	MOVF        FARG_meArm_isReachable_x+3, 0 
	MOVWF       FARG_solve_x+3 
	MOVF        FARG_meArm_isReachable_y+0, 0 
	MOVWF       FARG_solve_y+0 
	MOVF        FARG_meArm_isReachable_y+1, 0 
	MOVWF       FARG_solve_y+1 
	MOVF        FARG_meArm_isReachable_y+2, 0 
	MOVWF       FARG_solve_y+2 
	MOVF        FARG_meArm_isReachable_y+3, 0 
	MOVWF       FARG_solve_y+3 
	MOVF        FARG_meArm_isReachable_z+0, 0 
	MOVWF       FARG_solve_z+0 
	MOVF        FARG_meArm_isReachable_z+1, 0 
	MOVWF       FARG_solve_z+1 
	MOVF        FARG_meArm_isReachable_z+2, 0 
	MOVWF       FARG_solve_z+2 
	MOVF        FARG_meArm_isReachable_z+3, 0 
	MOVWF       FARG_solve_z+3 
	MOVLW       meArm_isReachable_radBase_L0+0
	MOVWF       FARG_solve_a0+0 
	MOVLW       hi_addr(meArm_isReachable_radBase_L0+0)
	MOVWF       FARG_solve_a0+1 
	MOVLW       meArm_isReachable_radShoulder_L0+0
	MOVWF       FARG_solve_a1+0 
	MOVLW       hi_addr(meArm_isReachable_radShoulder_L0+0)
	MOVWF       FARG_solve_a1+1 
	MOVLW       meArm_isReachable_radElbow_L0+0
	MOVWF       FARG_solve_a2+0 
	MOVLW       hi_addr(meArm_isReachable_radElbow_L0+0)
	MOVWF       FARG_solve_a2+1 
	CALL        _solve+0, 0
;meArm.c,183 :: 		}
L_end_meArm_isReachable:
	RETURN      0
; end of _meArm_isReachable

_meArm_openGripper:

;meArm.c,186 :: 		void meArm_openGripper() {
;meArm.c,187 :: 		ServoWrite(_svoGripper.id,rad2Angle(&_svoGripper,pi/2.0));
	MOVLW       __svoGripper+0
	MOVWF       FARG_rad2Angle_svo+0 
	MOVLW       hi_addr(__svoGripper+0)
	MOVWF       FARG_rad2Angle_svo+1 
	MOVLW       219
	MOVWF       FARG_rad2Angle_rad+0 
	MOVLW       15
	MOVWF       FARG_rad2Angle_rad+1 
	MOVLW       73
	MOVWF       FARG_rad2Angle_rad+2 
	MOVLW       127
	MOVWF       FARG_rad2Angle_rad+3 
	CALL        _rad2Angle+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	MOVF        __svoGripper+12, 0 
	MOVWF       FARG_ServoWrite_srv_id+0 
	CALL        _ServoWrite+0, 0
;meArm.c,188 :: 		Delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_meArm_openGripper7:
	DECFSZ      R13, 1, 1
	BRA         L_meArm_openGripper7
	DECFSZ      R12, 1, 1
	BRA         L_meArm_openGripper7
	DECFSZ      R11, 1, 1
	BRA         L_meArm_openGripper7
	NOP
	NOP
;meArm.c,189 :: 		}
L_end_meArm_openGripper:
	RETURN      0
; end of _meArm_openGripper

_meArm_closeGripper:

;meArm.c,192 :: 		void meArm_closeGripper() {
;meArm.c,193 :: 		ServoWrite(_svoGripper.id,20.0);
	MOVF        __svoGripper+12, 0 
	MOVWF       FARG_ServoWrite_srv_id+0 
	MOVLW       0
	MOVWF       FARG_ServoWrite_angle+0 
	MOVLW       0
	MOVWF       FARG_ServoWrite_angle+1 
	MOVLW       32
	MOVWF       FARG_ServoWrite_angle+2 
	MOVLW       131
	MOVWF       FARG_ServoWrite_angle+3 
	CALL        _ServoWrite+0, 0
;meArm.c,194 :: 		Delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_meArm_closeGripper8:
	DECFSZ      R13, 1, 1
	BRA         L_meArm_closeGripper8
	DECFSZ      R12, 1, 1
	BRA         L_meArm_closeGripper8
	DECFSZ      R11, 1, 1
	BRA         L_meArm_closeGripper8
;meArm.c,195 :: 		ServoWrite(_svoGripper.id,rad2Angle(&_svoGripper,0.0));
	MOVLW       __svoGripper+0
	MOVWF       FARG_rad2Angle_svo+0 
	MOVLW       hi_addr(__svoGripper+0)
	MOVWF       FARG_rad2Angle_svo+1 
	CLRF        FARG_rad2Angle_rad+0 
	CLRF        FARG_rad2Angle_rad+1 
	CLRF        FARG_rad2Angle_rad+2 
	CLRF        FARG_rad2Angle_rad+3 
	CALL        _rad2Angle+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        R1, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        R2, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        R3, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	MOVF        __svoGripper+12, 0 
	MOVWF       FARG_ServoWrite_srv_id+0 
	CALL        _ServoWrite+0, 0
;meArm.c,196 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_meArm_closeGripper9:
	DECFSZ      R13, 1, 1
	BRA         L_meArm_closeGripper9
	DECFSZ      R12, 1, 1
	BRA         L_meArm_closeGripper9
	DECFSZ      R11, 1, 1
	BRA         L_meArm_closeGripper9
	NOP
;meArm.c,197 :: 		}
L_end_meArm_closeGripper:
	RETURN      0
; end of _meArm_closeGripper

_meArm_getX:

;meArm.c,200 :: 		float meArm_getX() {
;meArm.c,201 :: 		return _x;
	MOVF        __x+0, 0 
	MOVWF       R0 
	MOVF        __x+1, 0 
	MOVWF       R1 
	MOVF        __x+2, 0 
	MOVWF       R2 
	MOVF        __x+3, 0 
	MOVWF       R3 
;meArm.c,202 :: 		}
L_end_meArm_getX:
	RETURN      0
; end of _meArm_getX

_meArm_getY:

;meArm.c,203 :: 		float meArm_getY() {
;meArm.c,204 :: 		return _y;
	MOVF        __y+0, 0 
	MOVWF       R0 
	MOVF        __y+1, 0 
	MOVWF       R1 
	MOVF        __y+2, 0 
	MOVWF       R2 
	MOVF        __y+3, 0 
	MOVWF       R3 
;meArm.c,205 :: 		}
L_end_meArm_getY:
	RETURN      0
; end of _meArm_getY

_meArm_getZ:

;meArm.c,206 :: 		float meArm_getZ() {
;meArm.c,207 :: 		return _z;
	MOVF        __z+0, 0 
	MOVWF       R0 
	MOVF        __z+1, 0 
	MOVWF       R1 
	MOVF        __z+2, 0 
	MOVWF       R2 
	MOVF        __z+3, 0 
	MOVWF       R3 
;meArm.c,208 :: 		}
L_end_meArm_getZ:
	RETURN      0
; end of _meArm_getZ

_meArm_getR:

;meArm.c,211 :: 		float meArm_getR() {
;meArm.c,212 :: 		return _r;
	MOVF        __r+0, 0 
	MOVWF       R0 
	MOVF        __r+1, 0 
	MOVWF       R1 
	MOVF        __r+2, 0 
	MOVWF       R2 
	MOVF        __r+3, 0 
	MOVWF       R3 
;meArm.c,213 :: 		}
L_end_meArm_getR:
	RETURN      0
; end of _meArm_getR

_meArm_getTheta:

;meArm.c,214 :: 		float meArm_getTheta() {
;meArm.c,215 :: 		return _t;
	MOVF        __t+0, 0 
	MOVWF       R0 
	MOVF        __t+1, 0 
	MOVWF       R1 
	MOVF        __t+2, 0 
	MOVWF       R2 
	MOVF        __t+3, 0 
	MOVWF       R3 
;meArm.c,216 :: 		}
L_end_meArm_getTheta:
	RETURN      0
; end of _meArm_getTheta

_meArm_servo:

;meArm.c,218 :: 		void meArm_servo(char id, float angle){
;meArm.c,219 :: 		ServoWrite(id,angle);
	MOVF        FARG_meArm_servo_id+0, 0 
	MOVWF       FARG_ServoWrite_srv_id+0 
	MOVF        FARG_meArm_servo_angle+0, 0 
	MOVWF       FARG_ServoWrite_angle+0 
	MOVF        FARG_meArm_servo_angle+1, 0 
	MOVWF       FARG_ServoWrite_angle+1 
	MOVF        FARG_meArm_servo_angle+2, 0 
	MOVWF       FARG_ServoWrite_angle+2 
	MOVF        FARG_meArm_servo_angle+3, 0 
	MOVWF       FARG_ServoWrite_angle+3 
	CALL        _ServoWrite+0, 0
;meArm.c,220 :: 		}
L_end_meArm_servo:
	RETURN      0
; end of _meArm_servo
