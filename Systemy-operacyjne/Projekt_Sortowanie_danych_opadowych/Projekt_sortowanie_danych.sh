#!/bin/bash

czas_start=$(date +%S.%6N)

# ERROR 1
if [ $# == 0 ]
then
	echo "ERROR 1 - brak argumentow, Poprawny sposob uruchomienia: $0 <KAT_BAZOWY> <nazwa_pliku_danych1> <nazwa_pliku_danych2> ... <nazwa_pliku_danychN>" 1>&2
	exit 1
fi

# ERROR 2
if [ $# == 1 ]
then
	echo "ERROR 2 - tylko jeden argument, Poprawny spsob uruchomienia: $0 <KAT_BAZOWY> <nazwa_pliku_danych1> <nazwa_pliku_danych2> ... <nazwa_pliku_danychN>" 1>&2
	exit 2
fi

# ERROR 3
for argument in "${@:2}"
do
	if ! [ -e "$argument" ]
	then
		echo "ERROR 3 - brak dostepu do pliku danych lub plik nie istnieje: $argument" 1>&2
		exit 3
	fi
done

# ERROR 4 
if ! [ -e "$1" ]
then
	mkdir "./$1" # ls -l do sprawdzenia uprawnien
fi

if ! [ -e "$1" ]
then
	echo" ERROR 4 - brak mozliwosci utworzenia katalogu bazowego"
	exit 4
fi


for plik in "$@"
do
	if [[ -f $plik ]]
	then
		while read wiersz
		do
# 1 START
			rok=$( echo $wiersz | cut -d "," -f 3 | tr -d '"' )
			miesiac=$( echo $wiersz | cut -d "," -f 4 | tr -d '"' )
			if ! [ -e "$1/$rok/$miesiac" ]
			then 
				mkdir -m 750 -p "$1/$rok/$miesiac"
			fi
# 1 STOP

# 2,3 START
			dzien=$( echo $wiersz | cut -d "," -f 5 | tr -d '"' )
			smbd=$( echo $wiersz | cut -d "," -f 7 | tr -d '"' )
			if [[ $smbd -ne 8 ]]
			then
				touch "$1/$rok/$miesiac/$dzien.csv"
				echo "$wiersz" >> "$1/$rok/$miesiac/$dzien.csv"
				chmod 640 "$1/$rok/$miesiac/$dzien.csv"
			else
				touch "$1/$rok.$miesiac.errors"
				echo "$wiersz" >> "$1/$rok.$miesiac.errors"
			fi
# 2,3 STOP
		done < "$plik"
	fi
done


# 4 START
min=999999
max=0
for plik_z_dniem in "$1"/*/*/*.csv
do
       	suma=0
	while read wiersz
	do
		opad=$( echo $wiersz | cut -d "," -f 6 )
		suma=$( echo "($suma+$opad)" | bc )
	done < "$plik_z_dniem"
	
	if (( $( echo "$suma >= $max" | bc ) ))
	then
		max=$suma
		max_link=$plik_z_dniem
	fi
	if (( $( echo "$suma <= $min" | bc ) ))
        then
                min=$suma
		min_link=$plik_z_dniem
        fi
done

mkdir -m 750 -p "$1"/LINKS/

MAX=$( realpath --relative-to="$1"/LINKS "$max_link" )
MIN=$( realpath --relative-to="$1"/LINKS "$min_link" )

ln -s -f "$MAX" "$1"/LINKS/MAX_OPAD
ln -s -f "$MIN" "$1"/LINKS/MIN_OPAD
# 4 STOP

# 0 START
czas_stop=$(date +%S.%6N)
if [ $( echo "$czas_stop>$czas_start" | bc) ]
then
	roznica_2=$( echo "($czas_stop-$czas_start)*1000" | bc )
	roznica=$( printf "%.3f" $roznica_2 )
else
	roznica_2=$( echo "((60-$czas_start)+$czas_stop*1000)" | bc )
	roznica=$( printf "%.3f" $roznica_2 )
fi


echo $BASHPID,$PPID,$roznica,$0 $@ >> "$1/out.log"
# 0 STOP
