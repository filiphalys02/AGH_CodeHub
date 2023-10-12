unsigned long start;
unsigned long stop;
float time;
int pin;
float sek=0;
long szum=0;
long sr=0;
void setup() {
Serial.begin(9600);
pinMode(A0, INPUT);
}

void loop() {
  start=micros();
  for(long int i=0; i<8900; i++){
    pin=analogRead(A0);
  }
  stop=micros();
  time=stop-start;
  time=time/1000000;
  Serial.println(time);
  delay(1000);
}
