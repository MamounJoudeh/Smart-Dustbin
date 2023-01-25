
_measure_distance1:

;FinalProject.c,26 :: 		unsigned int measure_distance1(void) {  //sensor 1 used to open the lid using servo [RB6 = TRIGGER, RB7 = ECHO ]
;FinalProject.c,27 :: 		pulse_width = 0;         //Initializing the pulse_width, pulse_width is the Duration of the echo pulse in microseconds
	CLRF       _pulse_width+0
	CLRF       _pulse_width+1
	CLRF       _pulse_width+2
	CLRF       _pulse_width+3
;FinalProject.c,28 :: 		T1overflow = 0;
	CLRF       _T1overflow+0
	CLRF       _T1overflow+1
;FinalProject.c,29 :: 		TMR1L = 0X00;
	CLRF       TMR1L+0
;FinalProject.c,30 :: 		TMR1H = 0X00;
	CLRF       TMR1H+0
;FinalProject.c,31 :: 		PORTB = PORTB | 0x40;    //TRIGGER ON
	BSF        PORTB+0, 6
;FinalProject.c,32 :: 		delay_us(10);
	MOVLW      6
	MOVWF      R13+0
L_measure_distance10:
	DECFSZ     R13+0, 1
	GOTO       L_measure_distance10
	NOP
;FinalProject.c,33 :: 		PORTB = PORTB & 0xBF;    //TRIGGER OFF
	MOVLW      191
	ANDWF      PORTB+0, 1
;FinalProject.c,34 :: 		while(!(PORTB & 0x80));  //WHILE ECHO != 1
L_measure_distance11:
	BTFSC      PORTB+0, 7
	GOTO       L_measure_distance12
	GOTO       L_measure_distance11
L_measure_distance12:
;FinalProject.c,35 :: 		T1CON=0x19;              //START THE TIMER
	MOVLW      25
	MOVWF      T1CON+0
;FinalProject.c,36 :: 		while(PORTB & 0x80);     //WHILE ECHO = 1
L_measure_distance13:
	BTFSS      PORTB+0, 7
	GOTO       L_measure_distance14
	GOTO       L_measure_distance13
L_measure_distance14:
;FinalProject.c,37 :: 		T1CON=0x18;              //STOP THE TIMER
	MOVLW      24
	MOVWF      T1CON+0
;FinalProject.c,38 :: 		pulse_width = ((TMR1H<<8)|TMR1L)+(T1overflow*65536); //READ THE TIMER
	MOVF       TMR1H+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	IORWF      R0+0, 0
	MOVWF      R8+0
	MOVF       R0+1, 0
	MOVWF      R8+1
	MOVLW      0
	IORWF      R8+1, 1
	MOVF       _T1overflow+1, 0
	MOVWF      R4+3
	MOVF       _T1overflow+0, 0
	MOVWF      R4+2
	CLRF       R4+0
	CLRF       R4+1
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	CLRF       R0+2
	CLRF       R0+3
	MOVF       R4+0, 0
	ADDWF      R0+0, 1
	MOVF       R4+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R4+1, 0
	ADDWF      R0+1, 1
	MOVF       R4+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R4+2, 0
	ADDWF      R0+2, 1
	MOVF       R4+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R4+3, 0
	ADDWF      R0+3, 1
	MOVF       R0+0, 0
	MOVWF      _pulse_width+0
	MOVF       R0+1, 0
	MOVWF      _pulse_width+1
	MOVF       R0+2, 0
	MOVWF      _pulse_width+2
	MOVF       R0+3, 0
	MOVWF      _pulse_width+3
;FinalProject.c,39 :: 		Time = pulse_width;
	MOVF       R0+0, 0
	MOVWF      _Time+0
	MOVF       R0+1, 0
	MOVWF      _Time+1
	MOVF       R0+2, 0
	MOVWF      _Time+2
	MOVF       R0+3, 0
	MOVWF      _Time+3
;FinalProject.c,40 :: 		distance1 =  ((Time*34)/(1000))/2;                    //TO GET THE DISTANCE IN CM
	MOVLW      34
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	RRF        R4+3, 1
	RRF        R4+2, 1
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+3, 7
	MOVF       R4+0, 0
	MOVWF      _distance1+0
	MOVF       R4+1, 0
	MOVWF      _distance1+1
;FinalProject.c,41 :: 		return distance1;
	MOVF       R4+0, 0
	MOVWF      R0+0
	MOVF       R4+1, 0
	MOVWF      R0+1
;FinalProject.c,42 :: 		}
L_end_measure_distance1:
	RETURN
; end of _measure_distance1

_measure_distanc2:

;FinalProject.c,44 :: 		unsigned int measure_distanc2(void) {  //sensor 2 used to Display the Level of Garbage [RB1 = TRIGGER, RB3 = ECHO ]
;FinalProject.c,45 :: 		pulse_width = 0;         //Initializing the pulse_width, pulse_width is the Duration of the echo pulse in microseconds
	CLRF       _pulse_width+0
	CLRF       _pulse_width+1
	CLRF       _pulse_width+2
	CLRF       _pulse_width+3
;FinalProject.c,46 :: 		T1overflow = 0;
	CLRF       _T1overflow+0
	CLRF       _T1overflow+1
;FinalProject.c,47 :: 		TMR1L = 0X00;
	CLRF       TMR1L+0
;FinalProject.c,48 :: 		TMR1H = 0X00;
	CLRF       TMR1H+0
;FinalProject.c,49 :: 		PORTB = PORTB | 0x02;    //TRIGGER ON
	BSF        PORTB+0, 1
;FinalProject.c,50 :: 		delay_us(10);
	MOVLW      6
	MOVWF      R13+0
L_measure_distanc25:
	DECFSZ     R13+0, 1
	GOTO       L_measure_distanc25
	NOP
;FinalProject.c,51 :: 		PORTB = PORTB & 0xFD;    //TRIGGER OFF
	MOVLW      253
	ANDWF      PORTB+0, 1
;FinalProject.c,52 :: 		while(!(PORTB & 0x08));  //WHILE ECHO != 1
L_measure_distanc26:
	BTFSC      PORTB+0, 3
	GOTO       L_measure_distanc27
	GOTO       L_measure_distanc26
L_measure_distanc27:
;FinalProject.c,53 :: 		T1CON=0x19;              //START THE TIMER
	MOVLW      25
	MOVWF      T1CON+0
;FinalProject.c,54 :: 		while(PORTB & 0x08);     //WHILE ECHO = 1
L_measure_distanc28:
	BTFSS      PORTB+0, 3
	GOTO       L_measure_distanc29
	GOTO       L_measure_distanc28
L_measure_distanc29:
;FinalProject.c,55 :: 		T1CON=0x18;              //STOP THE TIMER
	MOVLW      24
	MOVWF      T1CON+0
;FinalProject.c,56 :: 		pulse_width = ((TMR1H<<8)|TMR1L)+(T1overflow*65536); //READ THE TIMER
	MOVF       TMR1H+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	IORWF      R0+0, 0
	MOVWF      R8+0
	MOVF       R0+1, 0
	MOVWF      R8+1
	MOVLW      0
	IORWF      R8+1, 1
	MOVF       _T1overflow+1, 0
	MOVWF      R4+3
	MOVF       _T1overflow+0, 0
	MOVWF      R4+2
	CLRF       R4+0
	CLRF       R4+1
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	CLRF       R0+2
	CLRF       R0+3
	MOVF       R4+0, 0
	ADDWF      R0+0, 1
	MOVF       R4+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R4+1, 0
	ADDWF      R0+1, 1
	MOVF       R4+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R4+2, 0
	ADDWF      R0+2, 1
	MOVF       R4+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R4+3, 0
	ADDWF      R0+3, 1
	MOVF       R0+0, 0
	MOVWF      _pulse_width+0
	MOVF       R0+1, 0
	MOVWF      _pulse_width+1
	MOVF       R0+2, 0
	MOVWF      _pulse_width+2
	MOVF       R0+3, 0
	MOVWF      _pulse_width+3
;FinalProject.c,57 :: 		Time = pulse_width;
	MOVF       R0+0, 0
	MOVWF      _Time+0
	MOVF       R0+1, 0
	MOVWF      _Time+1
	MOVF       R0+2, 0
	MOVWF      _Time+2
	MOVF       R0+3, 0
	MOVWF      _Time+3
;FinalProject.c,58 :: 		distance2 =  ((Time*34)/(1000))/2;                    //TO GET THE DISTANCE IN CM
	MOVLW      34
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	RRF        R4+3, 1
	RRF        R4+2, 1
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+3, 7
	MOVF       R4+0, 0
	MOVWF      _distance2+0
	MOVF       R4+1, 0
	MOVWF      _distance2+1
;FinalProject.c,59 :: 		return distance2;
	MOVF       R4+0, 0
	MOVWF      R0+0
	MOVF       R4+1, 0
	MOVWF      R0+1
;FinalProject.c,60 :: 		}
L_end_measure_distanc2:
	RETURN
; end of _measure_distanc2

_Rotation0:

;FinalProject.c,63 :: 		void Rotation0() {
;FinalProject.c,65 :: 		for(i=0;i<50;i++) {
	CLRF       R1+0
	CLRF       R1+1
L_Rotation010:
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Rotation040
	MOVLW      50
	SUBWF      R1+0, 0
L__Rotation040:
	BTFSC      STATUS+0, 0
	GOTO       L_Rotation011
;FinalProject.c,66 :: 		PORTB = PORTB | 0X04;
	BSF        PORTB+0, 2
;FinalProject.c,67 :: 		Delay_us(800); // pulse of 800us
	MOVLW      3
	MOVWF      R12+0
	MOVLW      18
	MOVWF      R13+0
L_Rotation013:
	DECFSZ     R13+0, 1
	GOTO       L_Rotation013
	DECFSZ     R12+0, 1
	GOTO       L_Rotation013
	NOP
;FinalProject.c,68 :: 		PORTB = PORTB & 0xFB;
	MOVLW      251
	ANDWF      PORTB+0, 1
;FinalProject.c,69 :: 		Delay_us(19200);
	MOVLW      50
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_Rotation014:
	DECFSZ     R13+0, 1
	GOTO       L_Rotation014
	DECFSZ     R12+0, 1
	GOTO       L_Rotation014
	NOP
	NOP
;FinalProject.c,65 :: 		for(i=0;i<50;i++) {
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;FinalProject.c,70 :: 		}
	GOTO       L_Rotation010
L_Rotation011:
;FinalProject.c,71 :: 		}
L_end_Rotation0:
	RETURN
; end of _Rotation0

_Rotation180:

;FinalProject.c,73 :: 		void Rotation180() {
;FinalProject.c,75 :: 		for(i=0;i<50;i++) {
	CLRF       R1+0
	CLRF       R1+1
L_Rotation18015:
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Rotation18042
	MOVLW      50
	SUBWF      R1+0, 0
L__Rotation18042:
	BTFSC      STATUS+0, 0
	GOTO       L_Rotation18016
;FinalProject.c,76 :: 		PORTB.F0 = 1;
	BSF        PORTB+0, 0
;FinalProject.c,77 :: 		Delay_us(2200); // pulse of 2200us
	MOVLW      6
	MOVWF      R12+0
	MOVLW      181
	MOVWF      R13+0
L_Rotation18018:
	DECFSZ     R13+0, 1
	GOTO       L_Rotation18018
	DECFSZ     R12+0, 1
	GOTO       L_Rotation18018
	NOP
	NOP
;FinalProject.c,78 :: 		PORTB.F0 = 0;
	BCF        PORTB+0, 0
;FinalProject.c,79 :: 		Delay_us(17800);
	MOVLW      47
	MOVWF      R12+0
	MOVLW      58
	MOVWF      R13+0
L_Rotation18019:
	DECFSZ     R13+0, 1
	GOTO       L_Rotation18019
	DECFSZ     R12+0, 1
	GOTO       L_Rotation18019
	NOP
;FinalProject.c,75 :: 		for(i=0;i<50;i++) {
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;FinalProject.c,80 :: 		}
	GOTO       L_Rotation18015
L_Rotation18016:
;FinalProject.c,81 :: 		}
L_end_Rotation180:
	RETURN
; end of _Rotation180

_main:

;FinalProject.c,84 :: 		void main() {     //ECHO is INPUT, TRIGGER is OUTPUT
;FinalProject.c,85 :: 		TRISB = 0x88;     // RB0 = RS for LCD, RB1 = TRIGGER_SENSOR2, RB2 = Servo_PIN, RB3 = ECHO_SENSOR2, RB6 = TRIGGER_SESNOR1, RB7 = ECHO_SENSOR1
	MOVLW      136
	MOVWF      TRISB+0
;FinalProject.c,86 :: 		TRISC = 0x00;     // RC2 for BUZZER, RC4-RC7 for D2-D5 of LCD  PORTC output
	CLRF       TRISC+0
;FinalProject.c,87 :: 		TRISD = 0x00;     //RD2-RD7 for LCD pins, PORTD Output
	CLRF       TRISD+0
;FinalProject.c,88 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;FinalProject.c,89 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;FinalProject.c,90 :: 		PORTD = 0X00;
	CLRF       PORTD+0
;FinalProject.c,92 :: 		TMR1H=0;
	CLRF       TMR1H+0
;FinalProject.c,93 :: 		TMR1L=0;
	CLRF       TMR1L+0
;FinalProject.c,95 :: 		while(1) {
L_main20:
;FinalProject.c,96 :: 		distance1 = measure_distance1();
	CALL       _measure_distance1+0
	MOVF       R0+0, 0
	MOVWF      _distance1+0
	MOVF       R0+1, 0
	MOVWF      _distance1+1
;FinalProject.c,97 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main22:
	DECFSZ     R13+0, 1
	GOTO       L_main22
	DECFSZ     R12+0, 1
	GOTO       L_main22
	DECFSZ     R11+0, 1
	GOTO       L_main22
	NOP
	NOP
;FinalProject.c,99 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;FinalProject.c,100 :: 		if(distance1 < 30) {
	MOVLW      0
	SUBWF      _distance1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main44
	MOVLW      30
	SUBWF      _distance1+0, 0
L__main44:
	BTFSC      STATUS+0, 0
	GOTO       L_main23
;FinalProject.c,101 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;FinalProject.c,102 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;FinalProject.c,103 :: 		Lcd_out(1,1,"Distance= ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_FinalProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;FinalProject.c,104 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main24:
	DECFSZ     R13+0, 1
	GOTO       L_main24
	DECFSZ     R12+0, 1
	GOTO       L_main24
	DECFSZ     R11+0, 1
	GOTO       L_main24
	NOP
	NOP
;FinalProject.c,105 :: 		ByteToStr(distance1,dst);
	MOVF       _distance1+0, 0
	MOVWF      FARG_ByteToStr_input+0
	MOVLW      _dst+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;FinalProject.c,106 :: 		Lcd_out(1,13,dst);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _dst+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;FinalProject.c,107 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;FinalProject.c,108 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main25:
	DECFSZ     R13+0, 1
	GOTO       L_main25
	DECFSZ     R12+0, 1
	GOTO       L_main25
	DECFSZ     R11+0, 1
	GOTO       L_main25
	NOP
	NOP
;FinalProject.c,109 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;FinalProject.c,110 :: 		}
	GOTO       L_main26
L_main23:
;FinalProject.c,112 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;FinalProject.c,113 :: 		Lcd_out(1,1,"EMPTY");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_FinalProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;FinalProject.c,114 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;FinalProject.c,115 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main27:
	DECFSZ     R13+0, 1
	GOTO       L_main27
	DECFSZ     R12+0, 1
	GOTO       L_main27
	DECFSZ     R11+0, 1
	GOTO       L_main27
	NOP
	NOP
;FinalProject.c,116 :: 		}
L_main26:
;FinalProject.c,127 :: 		}
	GOTO       L_main20
;FinalProject.c,128 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_delay_us:

;FinalProject.c,130 :: 		void delay_us(unsigned int usCnt){
;FinalProject.c,131 :: 		unsigned int us=0;
	CLRF       delay_us_us_L0+0
	CLRF       delay_us_us_L0+1
;FinalProject.c,132 :: 		for(us=0;us<usCnt;us++){
	CLRF       delay_us_us_L0+0
	CLRF       delay_us_us_L0+1
L_delay_us28:
	MOVF       FARG_delay_us_usCnt+1, 0
	SUBWF      delay_us_us_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__delay_us46
	MOVF       FARG_delay_us_usCnt+0, 0
	SUBWF      delay_us_us_L0+0, 0
L__delay_us46:
	BTFSC      STATUS+0, 0
	GOTO       L_delay_us29
;FinalProject.c,133 :: 		asm NOP;//0.5 uS
	NOP
;FinalProject.c,134 :: 		asm NOP;//0.5uS
	NOP
;FinalProject.c,132 :: 		for(us=0;us<usCnt;us++){
	INCF       delay_us_us_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       delay_us_us_L0+1, 1
;FinalProject.c,135 :: 		}
	GOTO       L_delay_us28
L_delay_us29:
;FinalProject.c,136 :: 		}
L_end_delay_us:
	RETURN
; end of _delay_us

_delay_ms:

;FinalProject.c,138 :: 		void delay_ms(unsigned int msCnt){
;FinalProject.c,139 :: 		unsigned int ms=0;
	CLRF       delay_ms_ms_L0+0
	CLRF       delay_ms_ms_L0+1
	CLRF       delay_ms_cc_L0+0
	CLRF       delay_ms_cc_L0+1
;FinalProject.c,141 :: 		for(ms=0;ms<(msCnt);ms++){
	CLRF       delay_ms_ms_L0+0
	CLRF       delay_ms_ms_L0+1
L_delay_ms31:
	MOVF       FARG_delay_ms_msCnt+1, 0
	SUBWF      delay_ms_ms_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__delay_ms48
	MOVF       FARG_delay_ms_msCnt+0, 0
	SUBWF      delay_ms_ms_L0+0, 0
L__delay_ms48:
	BTFSC      STATUS+0, 0
	GOTO       L_delay_ms32
;FinalProject.c,142 :: 		for(cc=0;cc<155;cc++);//1ms
	CLRF       delay_ms_cc_L0+0
	CLRF       delay_ms_cc_L0+1
L_delay_ms34:
	MOVLW      0
	SUBWF      delay_ms_cc_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__delay_ms49
	MOVLW      155
	SUBWF      delay_ms_cc_L0+0, 0
L__delay_ms49:
	BTFSC      STATUS+0, 0
	GOTO       L_delay_ms35
	INCF       delay_ms_cc_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       delay_ms_cc_L0+1, 1
	GOTO       L_delay_ms34
L_delay_ms35:
;FinalProject.c,141 :: 		for(ms=0;ms<(msCnt);ms++){
	INCF       delay_ms_ms_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       delay_ms_ms_L0+1, 1
;FinalProject.c,143 :: 		}
	GOTO       L_delay_ms31
L_delay_ms32:
;FinalProject.c,144 :: 		}
L_end_delay_ms:
	RETURN
; end of _delay_ms
