# Kod służy do wyszukiwania danych z określonej kolumny pliku, pomijając nazwę kolumny (pierwszy wiersz), sortuje je alfabetycznie i usuwa powtarzające się elementy

#!/bin/bash
cut -d"," -f 4 "$1" | tail -n +2 | sort | uniq    # cut -d "," -f 4 - Znajduje w pliku znaki ",", wycina je i pokazuje zawartość 4 pola (po 3 znaku)
                                                  # tail -n +2 - Wyświetla wiersze poczynając od drugiego
                                                  # sort - Sortuje dane alfabetycznie
                                                  # uniq - Pomija powtarzające się wiersze 



#!/bin/bash
wiersze=$(( $(wc -l < "$1" ) - 1 ))                     # Tworzymy zmienną wiersze, która wzraca ilość linii z pliku $(wc -l < "$1" )
cut -d"," -f 4 "$1" | tail -n $wiersze | sort | uniq    # Odejmujemy 1, aby kod zwrócił liczbę lini bez lini tytułowej (pierwszego wiersza)
                                                        # cut -d "," -f 4 - Znajduje w pliku znaki ",", wycina je i pokazuje zawartość 4 pola (po 3 znaku)
                                                        # tail -n $wiersze - Wyświetla zawartość ostatnich wierszy, ich ilość jest równa wartości zmiennej wiersze
                                                        # sort - Sortuje dane alfabetycznie
                                                        # uniq - Pomija powtarzające się wiersze
