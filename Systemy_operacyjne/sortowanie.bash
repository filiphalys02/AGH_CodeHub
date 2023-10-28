# Kod służy do wyszukiwania danych z określonej kolumny pliku, sortuje je alfabetycznie i usuwa powtarzające się elementy

#!/bin/bash
cut -d "," -f 4 "$1" | sort | uniq    # cut -d "," -f 4 - Znajduje w pliku znaki ",", wycina je i pokazuje zawartość 4 pola (po 3 znaku)
                                      # sort - Sortuje dane alfabetycznie
                                      # uniq - Pomija powtarzające się wiersze 
