# Program znajduje medianę z liczb w pliku tekstowym, w którym każda liczba znajduje się w innym wierszu

#!/bin/bash
if [ "$1" == "" ] 
then 
      echo brak danych
else 
      if [ $(( $(( $(wc - l < $1) / 2)) % 2)) == 1 ]
      then
            echo Mediana z $1
            echo Ilosc danych parzysta 
            zmienna=$(( $(wc - l < $1) / 2))
            x=$( sort -n $1 | head -n $zmienna | tail -n 1)
            y=$( sort -n $1 | head -n $(($zmienna+1)) | tail -n 1)
            sum=$((x+y))
            result=$(echo "$sum/2" | bc -l)
            echo $result
      else
            echo Mediana z $1
            echo Ilosc danych nieparzysta 
            zmienna=$(( $(wc - l < $1) / 2))
            echo $( sort -n $1 | head -n $(($zmienna+1)) | tail -n 1)
      fi
fi

# Program znajduje średnią arytmatyczną z liczb w pliku tekstowym, w którym każda liczba znajduje się w innym wierszu

#!/bin/bash
dl=$( wc -l < $1 )
suma=0
for ((i=1;i<=$dl;i++))
do
      x=$( head -n $i $1 | tail -n 1 )
      suma=$(( $suma + $x ))
done
      wynik=$(echo "scale=3;$suma/$dl" | bc -l)
      echo $wynik
