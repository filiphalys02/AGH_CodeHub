# Kod służy do wyszukania w pliku danego tekstu i wypisania liczby wierszy, w których ten tekst się znajduje
# Wywołanie w terminalu: ./kod plik znak

#!/bin/bash
tail -n +2 $1 | grep $2 | wc -l


# Kod służy do wypisania przed każdym wierszem pliku tekstowego numer wiersza
# Wywołanie w terminalu: ./kod plik

#!/bin/bash
i=0
while read wiersz
do 
    ((i++))
    echo $1 $wiersz
done < $1


# Kod wykonuje to samo zadanie co poprzedni, przy czym zmienna "i" po wyjściu z pętli nadal ma wartość początkową
# Wywołanie w terminalu: ./kod plik

#!/bin/bash
i=1
echo i_poczatkowe: $i
cat $1 | while read wiersz
do 
    echo "Numer wiersza: $i - " $wiersz
    i=$(($i+1))
done
echo i_koncowe: $i
