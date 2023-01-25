#line 1 "C:/Users/user/Downloads/FinalProject.c"


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



unsigned int distance1, distance2;
unsigned int garbage_height = 27;
unsigned long pulse_width;
unsigned long Time;
unsigned int T1overflow;
unsigned char dst[2];
void delay_ms(unsigned int msCnt);
void delay_us(unsigned int usCnt);
unsigned int measure_distance1(void) {
pulse_width = 0;
T1overflow = 0;
TMR1L = 0X00;
TMR1H = 0X00;
PORTB = PORTB | 0x40;
delay_us(10);
PORTB = PORTB & 0xBF;
while(!(PORTB & 0x80));
T1CON=0x19;
while(PORTB & 0x80);
T1CON=0x18;
pulse_width = ((TMR1H<<8)|TMR1L)+(T1overflow*65536);
Time = pulse_width;
distance1 = ((Time*34)/(1000))/2;
return distance1;
}

unsigned int measure_distanc2(void) {
pulse_width = 0;
T1overflow = 0;
TMR1L = 0X00;
TMR1H = 0X00;
PORTB = PORTB | 0x02;
delay_us(10);
PORTB = PORTB & 0xFD;
while(!(PORTB & 0x08));
T1CON=0x19;
while(PORTB & 0x08);
T1CON=0x18;
pulse_width = ((TMR1H<<8)|TMR1L)+(T1overflow*65536);
Time = pulse_width;
distance2 = ((Time*34)/(1000))/2;
return distance2;
}


void Rotation0() {
unsigned int i;
for(i=0;i<50;i++) {
PORTB = PORTB | 0X04;
Delay_us(800);
PORTB = PORTB & 0xFB;
Delay_us(19200);
}
}

void Rotation180() {
unsigned int i;
for(i=0;i<50;i++) {
PORTB.F0 = 1;
Delay_us(2200);
PORTB.F0 = 0;
Delay_us(17800);
}
}


void main() {
TRISB = 0x88;
TRISC = 0x00;
TRISD = 0x00;
PORTB = 0x00;
PORTC = 0x00;
PORTD = 0X00;

TMR1H=0;
TMR1L=0;

while(1) {
distance1 = measure_distance1();
delay_ms(1000);

Lcd_Init();
if(distance1 < 30) {
Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);
Lcd_out(1,1,"Distance= ");
delay_ms(1000);
ByteToStr(distance1,dst);
Lcd_out(1,13,dst);
Lcd_Cmd(_LCD_CURSOR_OFF);
delay_ms(1000);
Lcd_Cmd(_LCD_CLEAR);
}
else {
Lcd_Cmd(_LCD_CLEAR);
Lcd_out(1,1,"EMPTY");
Lcd_Cmd(_LCD_CURSOR_OFF);
delay_ms(1000);
}
#line 127 "C:/Users/user/Downloads/FinalProject.c"
}
}

void delay_us(unsigned int usCnt){
 unsigned int us=0;
 for(us=0;us<usCnt;us++){
 asm NOP;
 asm NOP;
 }
}

void delay_ms(unsigned int msCnt){
 unsigned int ms=0;
 unsigned int cc=0;
 for(ms=0;ms<(msCnt);ms++){
 for(cc=0;cc<155;cc++);
 }
}
