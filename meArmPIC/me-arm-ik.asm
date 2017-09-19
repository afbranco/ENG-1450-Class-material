
_cart2polar:

;me-arm-ik.c,10 :: 		void cart2polar(float a, float b, float* r, float* theta)
;me-arm-ik.c,14 :: 		*r = sqrt(a*a + b*b);
	MOVF        FARG_cart2polar_a+0, 0 
	MOVWF       R0 
	MOVF        FARG_cart2polar_a+1, 0 
	MOVWF       R1 
	MOVF        FARG_cart2polar_a+2, 0 
	MOVWF       R2 
	MOVF        FARG_cart2polar_a+3, 0 
	MOVWF       R3 
	MOVF        FARG_cart2polar_a+0, 0 
	MOVWF       R4 
	MOVF        FARG_cart2polar_a+1, 0 
	MOVWF       R5 
	MOVF        FARG_cart2polar_a+2, 0 
	MOVWF       R6 
	MOVF        FARG_cart2polar_a+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__cart2polar+0 
	MOVF        R1, 0 
	MOVWF       FLOC__cart2polar+1 
	MOVF        R2, 0 
	MOVWF       FLOC__cart2polar+2 
	MOVF        R3, 0 
	MOVWF       FLOC__cart2polar+3 
	MOVF        FARG_cart2polar_b+0, 0 
	MOVWF       R0 
	MOVF        FARG_cart2polar_b+1, 0 
	MOVWF       R1 
	MOVF        FARG_cart2polar_b+2, 0 
	MOVWF       R2 
	MOVF        FARG_cart2polar_b+3, 0 
	MOVWF       R3 
	MOVF        FARG_cart2polar_b+0, 0 
	MOVWF       R4 
	MOVF        FARG_cart2polar_b+1, 0 
	MOVWF       R5 
	MOVF        FARG_cart2polar_b+2, 0 
	MOVWF       R6 
	MOVF        FARG_cart2polar_b+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__cart2polar+0, 0 
	MOVWF       R4 
	MOVF        FLOC__cart2polar+1, 0 
	MOVWF       R5 
	MOVF        FLOC__cart2polar+2, 0 
	MOVWF       R6 
	MOVF        FLOC__cart2polar+3, 0 
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
	MOVFF       FARG_cart2polar_r+0, FSR1
	MOVFF       FARG_cart2polar_r+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;me-arm-ik.c,17 :: 		if(*r == 0.0) return;
	MOVFF       FARG_cart2polar_r+0, FSR0
	MOVFF       FARG_cart2polar_r+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
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
	GOTO        L_cart2polar0
	GOTO        L_end_cart2polar
L_cart2polar0:
;me-arm-ik.c,19 :: 		c = a / *r;
	MOVFF       FARG_cart2polar_r+0, FSR0
	MOVFF       FARG_cart2polar_r+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVF        POSTINC0+0, 0 
	MOVWF       R6 
	MOVF        POSTINC0+0, 0 
	MOVWF       R7 
	MOVF        FARG_cart2polar_a+0, 0 
	MOVWF       R0 
	MOVF        FARG_cart2polar_a+1, 0 
	MOVWF       R1 
	MOVF        FARG_cart2polar_a+2, 0 
	MOVWF       R2 
	MOVF        FARG_cart2polar_a+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       cart2polar_c_L0+0 
	MOVF        R1, 0 
	MOVWF       cart2polar_c_L0+1 
	MOVF        R2, 0 
	MOVWF       cart2polar_c_L0+2 
	MOVF        R3, 0 
	MOVWF       cart2polar_c_L0+3 
;me-arm-ik.c,20 :: 		s = b / *r;
	MOVFF       FARG_cart2polar_r+0, FSR0
	MOVFF       FARG_cart2polar_r+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVF        POSTINC0+0, 0 
	MOVWF       R6 
	MOVF        POSTINC0+0, 0 
	MOVWF       R7 
	MOVF        FARG_cart2polar_b+0, 0 
	MOVWF       R0 
	MOVF        FARG_cart2polar_b+1, 0 
	MOVWF       R1 
	MOVF        FARG_cart2polar_b+2, 0 
	MOVWF       R2 
	MOVF        FARG_cart2polar_b+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       cart2polar_s_L0+0 
	MOVF        R1, 0 
	MOVWF       cart2polar_s_L0+1 
	MOVF        R2, 0 
	MOVWF       cart2polar_s_L0+2 
	MOVF        R3, 0 
	MOVWF       cart2polar_s_L0+3 
;me-arm-ik.c,23 :: 		if(s > 1.0) s = 1.0;
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       127
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_cart2polar1
	MOVLW       0
	MOVWF       cart2polar_s_L0+0 
	MOVLW       0
	MOVWF       cart2polar_s_L0+1 
	MOVLW       0
	MOVWF       cart2polar_s_L0+2 
	MOVLW       127
	MOVWF       cart2polar_s_L0+3 
L_cart2polar1:
;me-arm-ik.c,24 :: 		if(c > 1.0) c = 1.0;
	MOVF        cart2polar_c_L0+0, 0 
	MOVWF       R4 
	MOVF        cart2polar_c_L0+1, 0 
	MOVWF       R5 
	MOVF        cart2polar_c_L0+2, 0 
	MOVWF       R6 
	MOVF        cart2polar_c_L0+3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       127
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_cart2polar2
	MOVLW       0
	MOVWF       cart2polar_c_L0+0 
	MOVLW       0
	MOVWF       cart2polar_c_L0+1 
	MOVLW       0
	MOVWF       cart2polar_c_L0+2 
	MOVLW       127
	MOVWF       cart2polar_c_L0+3 
L_cart2polar2:
;me-arm-ik.c,25 :: 		if(s < -1.0) s = -1.0;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       128
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	MOVF        cart2polar_s_L0+0, 0 
	MOVWF       R0 
	MOVF        cart2polar_s_L0+1, 0 
	MOVWF       R1 
	MOVF        cart2polar_s_L0+2, 0 
	MOVWF       R2 
	MOVF        cart2polar_s_L0+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_cart2polar3
	MOVLW       0
	MOVWF       cart2polar_s_L0+0 
	MOVLW       0
	MOVWF       cart2polar_s_L0+1 
	MOVLW       128
	MOVWF       cart2polar_s_L0+2 
	MOVLW       127
	MOVWF       cart2polar_s_L0+3 
L_cart2polar3:
;me-arm-ik.c,26 :: 		if(c < -1.0) c = -1.0;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       128
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	MOVF        cart2polar_c_L0+0, 0 
	MOVWF       R0 
	MOVF        cart2polar_c_L0+1, 0 
	MOVWF       R1 
	MOVF        cart2polar_c_L0+2, 0 
	MOVWF       R2 
	MOVF        cart2polar_c_L0+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_cart2polar4
	MOVLW       0
	MOVWF       cart2polar_c_L0+0 
	MOVLW       0
	MOVWF       cart2polar_c_L0+1 
	MOVLW       128
	MOVWF       cart2polar_c_L0+2 
	MOVLW       127
	MOVWF       cart2polar_c_L0+3 
L_cart2polar4:
;me-arm-ik.c,29 :: 		*theta = acos(c);
	MOVF        cart2polar_c_L0+0, 0 
	MOVWF       FARG_acos_x+0 
	MOVF        cart2polar_c_L0+1, 0 
	MOVWF       FARG_acos_x+1 
	MOVF        cart2polar_c_L0+2, 0 
	MOVWF       FARG_acos_x+2 
	MOVF        cart2polar_c_L0+3, 0 
	MOVWF       FARG_acos_x+3 
	CALL        _acos+0, 0
	MOVFF       FARG_cart2polar_theta+0, FSR1
	MOVFF       FARG_cart2polar_theta+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;me-arm-ik.c,32 :: 		if(s < 0.0) *theta *= -1.0;
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	MOVF        cart2polar_s_L0+0, 0 
	MOVWF       R0 
	MOVF        cart2polar_s_L0+1, 0 
	MOVWF       R1 
	MOVF        cart2polar_s_L0+2, 0 
	MOVWF       R2 
	MOVF        cart2polar_s_L0+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_cart2polar5
	MOVFF       FARG_cart2polar_theta+0, FSR0
	MOVFF       FARG_cart2polar_theta+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       128
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVFF       FARG_cart2polar_theta+0, FSR1
	MOVFF       FARG_cart2polar_theta+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
L_cart2polar5:
;me-arm-ik.c,33 :: 		}
L_end_cart2polar:
	RETURN      0
; end of _cart2polar

_cosangle:

;me-arm-ik.c,36 :: 		int cosangle(float opp, float adj1, float adj2, float* theta)
;me-arm-ik.c,44 :: 		den = 2.0*adj1*adj2;
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       128
	MOVWF       R3 
	MOVF        FARG_cosangle_adj1+0, 0 
	MOVWF       R4 
	MOVF        FARG_cosangle_adj1+1, 0 
	MOVWF       R5 
	MOVF        FARG_cosangle_adj1+2, 0 
	MOVWF       R6 
	MOVF        FARG_cosangle_adj1+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FARG_cosangle_adj2+0, 0 
	MOVWF       R4 
	MOVF        FARG_cosangle_adj2+1, 0 
	MOVWF       R5 
	MOVF        FARG_cosangle_adj2+2, 0 
	MOVWF       R6 
	MOVF        FARG_cosangle_adj2+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       cosangle_den_L0+0 
	MOVF        R1, 0 
	MOVWF       cosangle_den_L0+1 
	MOVF        R2, 0 
	MOVWF       cosangle_den_L0+2 
	MOVF        R3, 0 
	MOVWF       cosangle_den_L0+3 
;me-arm-ik.c,46 :: 		if(den<0.00000001) return false;
	MOVLW       119
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       43
	MOVWF       R6 
	MOVLW       100
	MOVWF       R7 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_cosangle6
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_cosangle
L_cosangle6:
;me-arm-ik.c,47 :: 		c = (adj1*adj1 + adj2*adj2 - opp*opp)/den;
	MOVF        FARG_cosangle_adj1+0, 0 
	MOVWF       R0 
	MOVF        FARG_cosangle_adj1+1, 0 
	MOVWF       R1 
	MOVF        FARG_cosangle_adj1+2, 0 
	MOVWF       R2 
	MOVF        FARG_cosangle_adj1+3, 0 
	MOVWF       R3 
	MOVF        FARG_cosangle_adj1+0, 0 
	MOVWF       R4 
	MOVF        FARG_cosangle_adj1+1, 0 
	MOVWF       R5 
	MOVF        FARG_cosangle_adj1+2, 0 
	MOVWF       R6 
	MOVF        FARG_cosangle_adj1+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__cosangle+0 
	MOVF        R1, 0 
	MOVWF       FLOC__cosangle+1 
	MOVF        R2, 0 
	MOVWF       FLOC__cosangle+2 
	MOVF        R3, 0 
	MOVWF       FLOC__cosangle+3 
	MOVF        FARG_cosangle_adj2+0, 0 
	MOVWF       R0 
	MOVF        FARG_cosangle_adj2+1, 0 
	MOVWF       R1 
	MOVF        FARG_cosangle_adj2+2, 0 
	MOVWF       R2 
	MOVF        FARG_cosangle_adj2+3, 0 
	MOVWF       R3 
	MOVF        FARG_cosangle_adj2+0, 0 
	MOVWF       R4 
	MOVF        FARG_cosangle_adj2+1, 0 
	MOVWF       R5 
	MOVF        FARG_cosangle_adj2+2, 0 
	MOVWF       R6 
	MOVF        FARG_cosangle_adj2+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        FLOC__cosangle+0, 0 
	MOVWF       R4 
	MOVF        FLOC__cosangle+1, 0 
	MOVWF       R5 
	MOVF        FLOC__cosangle+2, 0 
	MOVWF       R6 
	MOVF        FLOC__cosangle+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__cosangle+0 
	MOVF        R1, 0 
	MOVWF       FLOC__cosangle+1 
	MOVF        R2, 0 
	MOVWF       FLOC__cosangle+2 
	MOVF        R3, 0 
	MOVWF       FLOC__cosangle+3 
	MOVF        FARG_cosangle_opp+0, 0 
	MOVWF       R0 
	MOVF        FARG_cosangle_opp+1, 0 
	MOVWF       R1 
	MOVF        FARG_cosangle_opp+2, 0 
	MOVWF       R2 
	MOVF        FARG_cosangle_opp+3, 0 
	MOVWF       R3 
	MOVF        FARG_cosangle_opp+0, 0 
	MOVWF       R4 
	MOVF        FARG_cosangle_opp+1, 0 
	MOVWF       R5 
	MOVF        FARG_cosangle_opp+2, 0 
	MOVWF       R6 
	MOVF        FARG_cosangle_opp+3, 0 
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
	MOVF        FLOC__cosangle+0, 0 
	MOVWF       R0 
	MOVF        FLOC__cosangle+1, 0 
	MOVWF       R1 
	MOVF        FLOC__cosangle+2, 0 
	MOVWF       R2 
	MOVF        FLOC__cosangle+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        cosangle_den_L0+0, 0 
	MOVWF       R4 
	MOVF        cosangle_den_L0+1, 0 
	MOVWF       R5 
	MOVF        cosangle_den_L0+2, 0 
	MOVWF       R6 
	MOVF        cosangle_den_L0+3, 0 
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       cosangle_c_L0+0 
	MOVF        R1, 0 
	MOVWF       cosangle_c_L0+1 
	MOVF        R2, 0 
	MOVWF       cosangle_c_L0+2 
	MOVF        R3, 0 
	MOVWF       cosangle_c_L0+3 
;me-arm-ik.c,49 :: 		if(c > 1.0 || c < -1.0) return false;
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       127
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__cosangle12
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       128
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	MOVF        cosangle_c_L0+0, 0 
	MOVWF       R0 
	MOVF        cosangle_c_L0+1, 0 
	MOVWF       R1 
	MOVF        cosangle_c_L0+2, 0 
	MOVWF       R2 
	MOVF        cosangle_c_L0+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__cosangle12
	GOTO        L_cosangle9
L__cosangle12:
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_cosangle
L_cosangle9:
;me-arm-ik.c,51 :: 		*theta = (float)acos(c);
	MOVF        cosangle_c_L0+0, 0 
	MOVWF       FARG_acos_x+0 
	MOVF        cosangle_c_L0+1, 0 
	MOVWF       FARG_acos_x+1 
	MOVF        cosangle_c_L0+2, 0 
	MOVWF       FARG_acos_x+2 
	MOVF        cosangle_c_L0+3, 0 
	MOVWF       FARG_acos_x+3 
	CALL        _acos+0, 0
	MOVFF       FARG_cosangle_theta+0, FSR1
	MOVFF       FARG_cosangle_theta+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;me-arm-ik.c,53 :: 		return true;
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
;me-arm-ik.c,54 :: 		}
L_end_cosangle:
	RETURN      0
; end of _cosangle

_solve:

;me-arm-ik.c,57 :: 		int solve(float x, float y, float z, float* a0, float* a1, float* a2)
;me-arm-ik.c,63 :: 		cart2polar(y, x, &r, &th0);
	MOVF        FARG_solve_y+0, 0 
	MOVWF       FARG_cart2polar_a+0 
	MOVF        FARG_solve_y+1, 0 
	MOVWF       FARG_cart2polar_a+1 
	MOVF        FARG_solve_y+2, 0 
	MOVWF       FARG_cart2polar_a+2 
	MOVF        FARG_solve_y+3, 0 
	MOVWF       FARG_cart2polar_a+3 
	MOVF        FARG_solve_x+0, 0 
	MOVWF       FARG_cart2polar_b+0 
	MOVF        FARG_solve_x+1, 0 
	MOVWF       FARG_cart2polar_b+1 
	MOVF        FARG_solve_x+2, 0 
	MOVWF       FARG_cart2polar_b+2 
	MOVF        FARG_solve_x+3, 0 
	MOVWF       FARG_cart2polar_b+3 
	MOVLW       solve_r_L0+0
	MOVWF       FARG_cart2polar_r+0 
	MOVLW       hi_addr(solve_r_L0+0)
	MOVWF       FARG_cart2polar_r+1 
	MOVLW       solve_th0_L0+0
	MOVWF       FARG_cart2polar_theta+0 
	MOVLW       hi_addr(solve_th0_L0+0)
	MOVWF       FARG_cart2polar_theta+1 
	CALL        _cart2polar+0, 0
;me-arm-ik.c,66 :: 		r -= L3;
	MOVF        _L3+0, 0 
	MOVWF       R4 
	MOVF        _L3+1, 0 
	MOVWF       R5 
	MOVF        _L3+2, 0 
	MOVWF       R6 
	MOVF        _L3+3, 0 
	MOVWF       R7 
	MOVF        solve_r_L0+0, 0 
	MOVWF       R0 
	MOVF        solve_r_L0+1, 0 
	MOVWF       R1 
	MOVF        solve_r_L0+2, 0 
	MOVWF       R2 
	MOVF        solve_r_L0+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       solve_r_L0+0 
	MOVF        R1, 0 
	MOVWF       solve_r_L0+1 
	MOVF        R2, 0 
	MOVWF       solve_r_L0+2 
	MOVF        R3, 0 
	MOVWF       solve_r_L0+3 
;me-arm-ik.c,69 :: 		cart2polar(r, z, &R_, &ang_P);
	MOVF        R0, 0 
	MOVWF       FARG_cart2polar_a+0 
	MOVF        R1, 0 
	MOVWF       FARG_cart2polar_a+1 
	MOVF        R2, 0 
	MOVWF       FARG_cart2polar_a+2 
	MOVF        R3, 0 
	MOVWF       FARG_cart2polar_a+3 
	MOVF        FARG_solve_z+0, 0 
	MOVWF       FARG_cart2polar_b+0 
	MOVF        FARG_solve_z+1, 0 
	MOVWF       FARG_cart2polar_b+1 
	MOVF        FARG_solve_z+2, 0 
	MOVWF       FARG_cart2polar_b+2 
	MOVF        FARG_solve_z+3, 0 
	MOVWF       FARG_cart2polar_b+3 
	MOVLW       solve_R__L0+0
	MOVWF       FARG_cart2polar_r+0 
	MOVLW       hi_addr(solve_R__L0+0)
	MOVWF       FARG_cart2polar_r+1 
	MOVLW       solve_ang_P_L0+0
	MOVWF       FARG_cart2polar_theta+0 
	MOVLW       hi_addr(solve_ang_P_L0+0)
	MOVWF       FARG_cart2polar_theta+1 
	CALL        _cart2polar+0, 0
;me-arm-ik.c,72 :: 		if(!cosangle(L2, L1, R_, &B)) return false;
	MOVF        _L2+0, 0 
	MOVWF       FARG_cosangle_opp+0 
	MOVF        _L2+1, 0 
	MOVWF       FARG_cosangle_opp+1 
	MOVF        _L2+2, 0 
	MOVWF       FARG_cosangle_opp+2 
	MOVF        _L2+3, 0 
	MOVWF       FARG_cosangle_opp+3 
	MOVF        _L1+0, 0 
	MOVWF       FARG_cosangle_adj1+0 
	MOVF        _L1+1, 0 
	MOVWF       FARG_cosangle_adj1+1 
	MOVF        _L1+2, 0 
	MOVWF       FARG_cosangle_adj1+2 
	MOVF        _L1+3, 0 
	MOVWF       FARG_cosangle_adj1+3 
	MOVF        solve_R__L0+0, 0 
	MOVWF       FARG_cosangle_adj2+0 
	MOVF        solve_R__L0+1, 0 
	MOVWF       FARG_cosangle_adj2+1 
	MOVF        solve_R__L0+2, 0 
	MOVWF       FARG_cosangle_adj2+2 
	MOVF        solve_R__L0+3, 0 
	MOVWF       FARG_cosangle_adj2+3 
	MOVLW       solve_B_L0+0
	MOVWF       FARG_cosangle_theta+0 
	MOVLW       hi_addr(solve_B_L0+0)
	MOVWF       FARG_cosangle_theta+1 
	CALL        _cosangle+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_solve10
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_solve
L_solve10:
;me-arm-ik.c,73 :: 		if(!cosangle(R_, L1, L2, &C)) return false;
	MOVF        solve_R__L0+0, 0 
	MOVWF       FARG_cosangle_opp+0 
	MOVF        solve_R__L0+1, 0 
	MOVWF       FARG_cosangle_opp+1 
	MOVF        solve_R__L0+2, 0 
	MOVWF       FARG_cosangle_opp+2 
	MOVF        solve_R__L0+3, 0 
	MOVWF       FARG_cosangle_opp+3 
	MOVF        _L1+0, 0 
	MOVWF       FARG_cosangle_adj1+0 
	MOVF        _L1+1, 0 
	MOVWF       FARG_cosangle_adj1+1 
	MOVF        _L1+2, 0 
	MOVWF       FARG_cosangle_adj1+2 
	MOVF        _L1+3, 0 
	MOVWF       FARG_cosangle_adj1+3 
	MOVF        _L2+0, 0 
	MOVWF       FARG_cosangle_adj2+0 
	MOVF        _L2+1, 0 
	MOVWF       FARG_cosangle_adj2+1 
	MOVF        _L2+2, 0 
	MOVWF       FARG_cosangle_adj2+2 
	MOVF        _L2+3, 0 
	MOVWF       FARG_cosangle_adj2+3 
	MOVLW       solve_C_L0+0
	MOVWF       FARG_cosangle_theta+0 
	MOVLW       hi_addr(solve_C_L0+0)
	MOVWF       FARG_cosangle_theta+1 
	CALL        _cosangle+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_solve11
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_solve
L_solve11:
;me-arm-ik.c,76 :: 		*a0 = th0;
	MOVFF       FARG_solve_a0+0, FSR1
	MOVFF       FARG_solve_a0+1, FSR1H
	MOVF        solve_th0_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        solve_th0_L0+1, 0 
	MOVWF       POSTINC1+0 
	MOVF        solve_th0_L0+2, 0 
	MOVWF       POSTINC1+0 
	MOVF        solve_th0_L0+3, 0 
	MOVWF       POSTINC1+0 
;me-arm-ik.c,77 :: 		*a1 = ang_P + B;
	MOVF        solve_ang_P_L0+0, 0 
	MOVWF       R0 
	MOVF        solve_ang_P_L0+1, 0 
	MOVWF       R1 
	MOVF        solve_ang_P_L0+2, 0 
	MOVWF       R2 
	MOVF        solve_ang_P_L0+3, 0 
	MOVWF       R3 
	MOVF        solve_B_L0+0, 0 
	MOVWF       R4 
	MOVF        solve_B_L0+1, 0 
	MOVWF       R5 
	MOVF        solve_B_L0+2, 0 
	MOVWF       R6 
	MOVF        solve_B_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVFF       FARG_solve_a1+0, FSR1
	MOVFF       FARG_solve_a1+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;me-arm-ik.c,78 :: 		*a2 = C + *a1 - PI;
	MOVFF       FARG_solve_a1+0, FSR2
	MOVFF       FARG_solve_a1+1, FSR2H
	MOVF        solve_C_L0+0, 0 
	MOVWF       R0 
	MOVF        solve_C_L0+1, 0 
	MOVWF       R1 
	MOVF        solve_C_L0+2, 0 
	MOVWF       R2 
	MOVF        solve_C_L0+3, 0 
	MOVWF       R3 
	MOVF        POSTINC2+0, 0 
	MOVWF       R4 
	MOVF        POSTINC2+0, 0 
	MOVWF       R5 
	MOVF        POSTINC2+0, 0 
	MOVWF       R6 
	MOVF        POSTINC2+0, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       219
	MOVWF       R4 
	MOVLW       15
	MOVWF       R5 
	MOVLW       73
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVFF       FARG_solve_a2+0, FSR1
	MOVFF       FARG_solve_a2+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;me-arm-ik.c,80 :: 		return true;
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
;me-arm-ik.c,81 :: 		}
L_end_solve:
	RETURN      0
; end of _solve
