int L[]={2, 3, 4, 5};
int R[]={6, 7, 8, 9};
int klawisz=0;
void setup() {
  for(int i=0; i<4; i++){
    pinMode(L[i], OUTPUT);
    pinMode(R[i], INPUT_PULLUP);
  }
  for(int i=0; i<4; i++){
    digitalWrite(L[i], HIGH);
  }  
  Serial.begin(9600); 
}
void loop() {
  for(int i=0; i<4; i++){   
    digitalWrite(L[i], LOW);
    for(int j=0; j<4; j++){
      if(digitalRead(R[j])==LOW){
        if(L[i]==2 && R[j]==6)
        {
          klawisz=1;
        }
        if(L[i]==2 && R[j]==7)
        {
          klawisz=2;
        }
        if(L[i]==2 && R[j]==8)
        {
          klawisz=3;
        }
        if(L[i]==2 && R[j]==9)
        {
          klawisz=4;
        }
         if(L[i]==3 && R[j]==6)
        {
          klawisz=5;
        }
        if(L[i]==3 && R[j]==7)
        {
          klawisz=6;
        }
        if(L[i]==3 && R[j]==8)
        {
          klawisz=7;
        }
        if(L[i]==3 && R[j]==9)
        {
          klawisz=8;
        }
         if(L[i]==4 && R[j]==6)
        {
          klawisz=9;
        }
        if(L[i]==4 && R[j]==7)
        {
          klawisz=10;
        }
        if(L[i]==4 && R[j]==8)
        {
          klawisz=11;
        }
        if(L[i]==4 && R[j]==9)
        {
          klawisz=12;
        }
         if(L[i]==5 && R[j]==6)
        {
          klawisz=13;
        }
        if(L[i]==5 && R[j]==7)
        {
          klawisz=14;
        }
        if(L[i]==5 && R[j]==8)
        {
          klawisz=15;
        }
        if(L[i]==5 && R[j]==9)
        {
          klawisz=16;
        }
        Serial.print("Numer wcisnietego klawisza: ");
        Serial.print(klawisz);
        Serial.print(" \n");
        while(digitalRead(R[j])==LOW){
        delay(30);
        if(digitalRead(R[j])==HIGH){
          break;
        }            
      } 
        digitalWrite(L[i], HIGH);
      }
    }   
    digitalWrite(L[i], HIGH);   
  }
  delay(30);
}
