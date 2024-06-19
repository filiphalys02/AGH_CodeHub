# Program służy do zapisywania nazwy katalogu i liczby plików, które się w nim znjadują

#!/bin/bash
echo -n "katalog: $1, plikow: "     # echo -n - wypisuje na ekran tekst wewnątrz "" (cały tekst wyświetli się w 1 linii)
ls -l "$1" | wc -l                  # ls -l - wypisuje na ekran pliki wewnątrz katalogu $1 linijka po linijce,      # wc -l - liczy ilość linii i wyświetla ich ilość  
