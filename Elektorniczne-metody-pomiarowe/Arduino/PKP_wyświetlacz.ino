/*
  LiquidCrystal Library - Hello World

 Demonstrates the use a 16x2 LCD display.  The LiquidCrystal
 library works with all LCD displays that are compatible with the
 Hitachi HD44780 driver. There are many of them out there, and you
 can usually tell them by the 16-pin interface.

 This sketch prints "Hello World!" to the LCD
 and shows the time.

  The circuit:
 * LCD RS pin to digital pin 12
 * LCD Enable pin to digital pin 11
 * LCD D4 pin to digital pin 5
 * LCD D5 pin to digital pin 4
 * LCD D6 pin to digital pin 3
 * LCD D7 pin to digital pin 2
 * LCD R/W pin to ground
 * LCD VSS pin to ground
 * LCD VCC pin to 5V
 * 10K resistor:
 * ends to +5V and ground
 * wiper to LCD VO pin (pin 3)

 Library originally added 18 Apr 2008
 by David A. Mellis
 library modified 5 Jul 2009
 by Limor Fried (http://www.ladyada.net)
 example added 9 Jul 2009
 by Tom Igoe
 modified 22 Nov 2010
 by Tom Igoe
 modified 7 Nov 2016
 by Arturo Guadalupi

 This example code is in the public domain.

 http://www.arduino.cc/en/Tutorial/LiquidCrystalHelloWorld

*/

// include the library code:
#include <LiquidCrystal.h>
#include <Wire.h>

// initialize the library by associating any needed LCD interface pin
// with the arduino pin number it is connected to
const int rs = 8, en = 9, d4 = 4, d5 = 5, d6 = 6, d7 = 7;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

void setup() {
  // set up the LCD's number of columns and rows:
  lcd.begin(16, 2);
  // Print a message to the LCD.
  lcd.print("Leba-opoznienie:");
pinMode(A0,INPUT);  
}
int l=0;
void loop() {
  lcd.print("                                                                         ");
  l=analogRead(A0);
  //lcd.print("Klawisz:");
  // set the cursor to column 0, line 1
  // (note: line 1 is the second row, since counting begins with 0):
  //analogWrite(back_lit, 20);  
  //delay(200);
  //analogWrite(back_lit, 205);
  //delay(200);
  lcd.setCursor(0, 1);
  // print the number of seconds since reset:
  if(l==0){
    lcd.print("Right");
  }
  else if(l>=290 && l<=330){
    lcd.print("Down");
  }
  else if(l>=120 && l<=140){
    lcd.print("Up");
  }
  else if(l>=460 && l<=490){
    lcd.print("Left");
  }  
  else if(l>=710 && l<=730){
    lcd.print("Select");
  }
  else lcd.print("Nie wcisnieto");   
}

