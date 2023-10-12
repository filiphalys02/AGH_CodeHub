unsigned long start;
unsigned long stop;
float time;
int pin;
int pomiary=0;
float sek=0;
long szum=0;
long sr=0;
void setup() {
Serial.begin(9600);
pinMode(A0, INPUT);
}

void loop() {
  start=micros();
  for(int i=0; i<10000; i++){
    pin=analogRead(A0);
  }
  stop=micros();
  time=stop-start;
  Serial.print("Czas wykonania petli: ");
  Serial.println(time);
  Serial.print("Predkosc: ");
  pomiary=10000000000/time;
  Serial.println(pomiary);
  delay(1000);
}
