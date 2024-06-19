# Progra wypisuje w konsoli Podany tekst co 3 sekundy

#!/bin/bash
while true
do
     echo $1
     sleep 3
done


# Stoper 

#!/bin/bash
i=0
while true
do
     ((i++))
     echo $i
     sleep 1
done
