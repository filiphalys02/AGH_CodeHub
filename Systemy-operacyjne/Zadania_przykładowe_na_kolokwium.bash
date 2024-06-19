# ZAD 1 - Wyodrębnij wszystkie unikalne nazwy postaci (Faction), a następnie policz ile różnych postaci jest w pliku.

          #!/bin/bash
          cut -d "," -f 2 $1 | uniq | wc -l




# ZAD 2 - Oblicz ile razy podana postać (Faction) zwyciężyła.
#         Nazwa pliku i nazwa postaci to parametry skryptu

          #!/bin/bash
          cut -d "," -f 2,4 $1 | grep $2 | grep '1' | wc -l




# ZAD 3 - Oblicz sumę punktów życia (HD) rozdanych przez postać (Faction).
#         Nazwa pliku i nazwa postaci to parametry skryptu.
          
          #!/bin/bash
          suma=0
          dlugosc=$( cut -d ',' -f 1 $1 | grep -c $2 )
          for ((i=1;i<=$dlugosc;i++))
          do  
                    x=$(cut -d ',' -f 2,4 $1 | grep $2 | head -n $i | tail -n 1 | cut -d ',' -f 2 )
                    suma=$(( $suma + $x ))
          done
                    echo $2 - $suma >> wynik
                    cat wynik
                    > wynik
      
      
      
# ZAD 4 - Wykonaj polecenia:
#         a) Utwórz strukturę plików: Stwórz katalog BAZA, a wewnątrz niego katalogi A,B,C,D,D.*.,E,F. Wewnątrz katalogu D.*. Utwórz katalog POD.
          mkdir -p BAZA/{A..F}/../D.*./POD

#         b) Utwóz pusty plik P w katalogu C
          touch BAZA/C/P

#         c) Skopiuj plik P jako P_kopia w katalogu C
          cp BAZA/C/P BAZA/C/P_kopia
         
#         d) Zmień nazwę pliku P_kopia na Plik2
          mv BAZA/C/P_kopia BAZA/C/Plik2
          
#         e) Utwórz w katalogu A link symboliczny o nazwie linkA do pliku P
          ln -s BAZA/C/P BAZA/A/linkA
          
#         f) Utwórz w katalogu B link sztywny o nazwie linkB do pliku Plik2
          ln BAZA/C/Plik2 BAZA/B/linkB
         
#         g) Wylistuj zadania uruchomione w bieżącej sesji terminalowej
          jobs
          
#         h) Podaj jakie polecenie przenosi uruchomiony proces z tła lub wznawia proces zatrzymany
          fg
          
#         i) Podaj jakie polecenie wstrzyma działanie procesu o numerze XXX
          kill XXX
          
          
          
# ZAD 5 - Przygotuj skrypt o nazwie generator.sh, którego zadaniem jest wygenerowanie 8 plików o nazwie nr_pliku.dat
#         Do każdego pliku wpisz wiersz tekstu o treści: Plik nr <numer> utworzony przez <użytkownik> dnia RRRR-MM-DD GG:MM:SS.n
          
          #!/bin/bash
          for((i=1;i<=8;i++)) do
                    touch $i.dat
                    echo Plik numer $i utworzony zostal przez $USER dnia $(date +%F) $(date +%T.%N) >$i.dat
          done


# ZAD 6 - Przygotuj skrypt, który wypisze ile podkatalogów i plików znajduje się w katalogu przekazanym jako argument.
          
          #!/bin/bash
          echo katalog: $1 Plików: $( ls $1 | wc -w )


