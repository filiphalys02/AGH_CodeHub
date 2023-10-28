# Kod służy do zliczania ilości plików wewnątrz danego katalogu, które rozpoczynają się od znaku "-"

#!/bin/bash
echo -n "katalog: $1 plikow: "            # Wypisuje na ekran tekst wewnątrz "" 
ls -l "$1" | cut -c 1 | grep "-" | wc -l  # ls -l - Wypisuje linijka po linijce pliki wewnątrz katalogu $1
                                          # cut -c 1 - Wycina z każdej nazwy pliku 1 znak i pokazuje tylko wycięte znaki
                                          # grep - Wyszukuje linie, które mają w sobie określony tekst
                                          # wc -l - Zlicza i wypisuje liczbę linii
