
//LCD
sbit LCD_RS at RD4_bit;
sbit LCD_EN at RD5_bit;
sbit LCD_D4 at RD0_bit;
sbit LCD_D5 at RD1_bit;
sbit LCD_D6 at RD2_bit;
sbit LCD_D7 at RD3_bit;
sbit LCD_RS_Direction at TRISD4_bit;
sbit LCD_EN_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD0_bit;
sbit LCD_D5_Direction at TRISD1_bit;
sbit LCD_D6_Direction at TRISD2_bit;
sbit LCD_D7_Direction at TRISD3_bit;


// Variables:
unsigned int distance1, distance2, Distance1, Distance2, result;
unsigned int garbage_height = 27;  //Garbage height = 27 cm
unsigned long pulse_width;
unsigned long Time;
unsigned int T1overflow;
unsigned char dst[2];
void delay_ms(unsigned int msCnt);
void delay_us(unsigned int usCnt);
unsigned int measure_distance1(void) {  //sensor 1 used to open the lid using servo [RB6 = TRIGGER, RB7 = ECHO ]
pulse_width = 0;         //Initializing the pulse_width, pulse_width is the Duration of the echo pulse in microseconds
T1overflow = 0;
TMR1L = 0X00;
TMR1H = 0X00;
PORTB = PORTB | 0x40;    //TRIGGER ON
delay_us(10);
PORTB = PORTB & 0xBF;    //TRIGGER OFF
while(!(PORTB & 0x80));  //WHILE ECHO != 1
T1CON=0x19;              //START THE TIMER
while(PORTB & 0x80);     //WHILE ECHO = 1
T1CON=0x18;              //STOP THE TIMER
pulse_width = ((TMR1H<<8)|TMR1L)+(T1overflow*65536); //READ THE TIMER
Time = pulse_width;
distance1 =  ((Time*34)/(1000))/2;                    //TO GET THE DISTANCE IN CM
return distance1;
}

unsigned int measure_distanc2(void) {  //sensor 2 used to Display the Level of Garbage [RB1 = TRIGGER, RB3 = ECHO ]
pulse_width = 0;         //Initializing the pulse_width, pulse_width is the Duration of the echo pulse in microseconds
T1overflow = 0;
TMR1L = 0X00;
TMR1H = 0X00;
PORTB = PORTB | 0x02;    //TRIGGER ON
delay_us(10);
PORTB = PORTB & 0xFD;    //TRIGGER OFF
while(!(PORTB & 0x08));  //WHILE ECHO != 1
T1CON=0x19;              //START THE TIMER
while(PORTB & 0x08);     //WHILE ECHO = 1
T1CON=0x18;              //STOP THE TIMER
pulse_width = ((TMR1H<<8)|TMR1L)+(T1overflow*65536); //READ THE TIMER
Time = pulse_width;
distance2 =  ((Time*34)/(1000))/2;                    //TO GET THE DISTANCE IN CM
return distance2;
}

//SERVO FUNCTIONS

void Rotation0() {
unsigned int i;
for(i=0;i<50;i++) {
PORTB = PORTB | 0X04;
Delay_us(800); // pulse of 800us
PORTB = PORTB & 0xFB;
Delay_us(19200);
}
}

void Rotation1() {
unsigned int i;
for(i=0;i<50;i++) {
PORTB = PORTB | 0x04;
Delay_us(2200); // pulse of 2200us
PORTB = PORTB & 0xFB;
Delay_us(17800);
 }
}

// Main function
void main() {     //ECHO is INPUT, TRIGGER is OUTPUT
TRISB = 0x88;     // RB0 = RS for LCD, RB1 = TRIGGER_SENSOR2, RB2 = Servo_PIN, RB3 = ECHO_SENSOR2, RB6 = TRIGGER_SESNOR1, RB7 = ECHO_SENSOR1
TRISC = 0x00;     // RC2 for BUZZER, RC4-RC7 for D2-D5 of LCD  PORTC output
TRISD = 0x00;     //RD2-RD7 for LCD pins, PORTD Output
PORTB = 0x00;
PORTC = 0x00;
PORTD = 0X00;

TMR1H=0;
TMR1L=0;
Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);
Lcd_out(1,1,"SMART");
delay_ms(1000);
Lcd_out(2,1,"DUSTBIN");
delay_ms(1000);
while(1) {
Distance1 = measure_distance1();
delay_ms(500);
if(Distance1 < 30) {
Rotation0();                      // OPENS THE LID
Delay_ms(2000);
Rotation1();                      // CLOSES THE LID
Delay_ms(4000);
 }
else {
Distance2 = measure_distance2();
delay_ms(500);
result = ((garbage_height - Distance2) / garbage_height) * 100 ;
if(Distance2 == garbage_height) {
Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);
Lcd_out(1,1,"FULL");              // DISPLAYS THAT THE GARBAGE IS FULL
delay_ms(1000);
PORTC = PORTC | 0x04;
}
else {
PORTC = PORTC & 0xFB;
Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);
Lcd_out(1,1,"Distance = ");
delay_ms(1000);
ByteToStr(result,dst);
Lcd_out(1,13,dst);                // WILL PRINT THE DUSTBIN PERCENTAGE
Lcd_Cmd(_LCD_CURSOR_OFF);
delay_ms(1000);
Lcd_Cmd(_LCD_CLEAR);
}
}
}
}
void delay_us(unsigned int usCnt){
    unsigned int us=0;
  for(us=0;us<usCnt;us++){
    asm NOP;//0.5 uS
    asm NOP;//0.5uS
  }
}
void delay_ms(unsigned int msCnt){
    unsigned int ms=0;
    unsigned int cc=0;
    for(ms=0;ms<(msCnt);ms++){
    for(cc=0;cc<155;cc++);//1ms
    }
}