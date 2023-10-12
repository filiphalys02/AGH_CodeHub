unsigned long start;
unsigned long stop;
unsigned long t1;
float time;
int pin;
int pomiary=0;
float sek=0;
float sr_tr = 0;
long szum=0;
long sr=0;
int ctr = 0;
void setup() {
Serial.begin(9600);
pinMode(A0, INPUT);
//t1=micros();
}

void loop() {
  //start=micros();
  for(int i=0; i<10000; i++){
    pin=analogRead(A0);
    sr=sr+pin;
    szum=sr/i;
    sr_tr = sr_tr + pin;
    if(i>10 && pin>3*szum){
      Serial.println("Siiiiiuuuu!");
      sr=sr-pin;
      i=i-1;
      ctr = ctr+1;
      if(ctr>100){
          sr=sr+sr_tr;
          szum=sr/(i+ctr);

        ctr =0;
        sr_tr = 0;
      }


    }
    //while(micros()<t1){
      //t1=micros();
    //}
  }
  //stop=micros();
 // time=stop-start;
  //Serial.print("Czas wykonania petli: ");
  //Serial.println(time);
  //Serial.print("Predkosc: ");
  //pomiary=10000000000/time;
  Serial.println(szum);
  szum=0;
  sr=0;
  //delay(1000);
}
