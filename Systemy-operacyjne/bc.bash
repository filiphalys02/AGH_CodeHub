# Proste obliczenia na liczbach

#!/bin/bash           # Dodawanie
echo 4+4 | bc

#!/bin/bash           # Odejmowanie
echo 5-2 | bc

#!/bin/bash           # Mnożenie
echo 2*6 | bc

#!/bin/bash           # Dzielenie
echo "scale=5;2/8" | bc -l

#!/bin/bash           # Pierwiastkowanie
echo "scale=3;sqrt(144)" | bc -l



# Przelicznik pomiędzy stopniami Fahrenheita a Celcjusza

#!/bin/bash           # Celcjusz -> Fahrenheit
echo "scale=2;$1*(9/5)+32" | bc

#!/bin/bash           # Fahrenheit -> Celcjusz
echo "scale=2;$1*(5/9)-32" | bc

#!/bin/bash           # Celcjusz -> Fahrenheit, z uwzględnieniem braku argumentu
if [ _"$@" = _"" ]  #Jeśli podany argument = brakowi argumentu
then
        echo nie podano argumentu >&2 #Wypisuje, że nie podano argumentu i pzekierowuje do strumienia wyjścia
else
        echo "scale=2;$1*(5/9)-32" | bc #Wykonuje obliczenie i je wypisuje 
fi
