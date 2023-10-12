#include <LiquidCrystal.h>
#include <Wire.h>

const int rs = 8, en = 9, d4 = 4, d5 = 5, d6 = 6, d7 = 7;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

void setup() {
  lcd.begin(16, 2);
  // put your setup code here, to run once:
  pinMode(A2, OUTPUT);
  pinMode(A1, INPUT);
}
long time;
long odl;
void loop() {
  // put your main code here, to run repeatedly:
  lcd.setCursor(0, 0);
  lcd.print("                ");
  lcd.setCursor(0, 1);
  lcd.print("                ");
  lcd.setCursor(0, 0);
  digitalWrite(A2, LOW);
  delayMicroseconds(3);
  digitalWrite(A2, HIGH);
  delayMicroseconds(10);
  digitalWrite(A2, LOW);
  time=pulseIn(A1, HIGH);
  odl=time/58;
  lcd.print(odl);
  lcd.print(" cm");
  delay(500);
}
