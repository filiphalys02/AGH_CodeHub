##########zmiennosc temperartury na swiecie - wykorzystanie danych gridowych##########

#######czesc pierwsza - dane#####
#pakiet do obslugi plikow netCDF (format roznych danych geofizycznych)
install.packages ("ncdf4")
library(ncdf4)
#uchwyt do pliku (daje mozliwosc odczytania pliku, wszystko wiemy, ale nie musimy ladowac)
ncin<-nc_open("cru_ts4.07.1901.2022.tmp.dat.nc")

###informacje o zbiorze danych###
print(ncin)
#sprawdzmy, czy nie ma bledow w danych dotyczacych dlugosci geogr.
##tworzymy w tym celu wektor lon
lon <- ncvar_get(ncin,"lon")
head(lon) # mamy podane srodki oczek siatki (co 0.5 od -180)
#utworzy tez zmienna z liczba oczek dugosci geograficznych (z wymiarami obiektu)
nlon <- dim(lon)
nlon
#to samo zrobmy dla szerokosci geogr....
lat <- ncvar_get(ncin,"lat")
head(lat)
nlat <- dim(lat)
nlat
#...i dla czasu
time <- ncvar_get(ncin,"time")
head (time) #punkty w czasie liczone sa od 01.01.1900; dana miesieczna jest przypisana do 16 dnia miesiaca,
            #dlatego pierwsza wartość to 380 (364+16), kolejna 410 (dodana liczbe dni do 16-go kolejnego miesiaca)
nt <-dim(time) 
nt
#sprawdzenie dat (czy rzeczywiscie to tak jest z tymi datami - sprawdzmy)
##skorzystajmy z funkcji ncatt_get do pobierania atrybutow/cech (argument: units) zmiennej time
tunits <- ncatt_get(ncin,"time","units") 
tunits

#możemy wyciagnac dodatkowe informacje - globalne atrybuty pliku
ncatt_get(ncin,0,"title") # "0" oznacza, ze to globalny atrybut, nie dotyczacy zadnej zmiennej
ncatt_get(ncin,0,"institution")
ncatt_get(ncin,0,"source")
ncatt_get(ncin,0,"references")
ncatt_get(ncin,0,"history")
ncatt_get(ncin,0,"Conventions")

###wczytywanie danych (sa to srednie miesieczne temperatury)###

#utworzmy wektor zawierajacy dane temperaturowe
tmp_array <- ncvar_get(ncin,"tmp") #jezeli jest problem z pamiecia - patrz poniżej "sposob bez ladowania danych do pamieci"
#zobaczmy co to za dane (nazwa danych)
dlname <- ncatt_get(ncin,"tmp","long_name")
dlname
#w jakich jednostkach
dunits <- ncatt_get(ncin,"tmp","units")
dunits
#jakie jest oznaczenie brakujacych danych (NA)
fillvalue <- ncatt_get(ncin,"tmp","_FillValue")
fillvalue
#zobaczmy jeszcze jaki jest rozmiar danych
dim(tmp_array) # to taka "kostka", obiekt 3D

###wybranie danych dla konkretnego oczka siatki (gridu)###
#np. dla Krakowa (19°56'18″E 50°03'41″N) oczko siatki to: 50.25 19.75. 
##zobaczmy, ktore to bedzie oczko siatki
which(lon==19.75)
which(lat==50.25)
#...i wybieramy dane
Krakow_tmp<-tmp_array[400,281,]

#####################################################################
#sposób bez ładowania danych do pamieci (bez tworzenia zmiennej tmp_arry)
#w1<-which(lon==19.75) #400
#w2<-which(lat==50.25) #281
#Krakow_tmp<-ncvar_get(ncin,"tmp",start=c(w1,w2,1),count=c(1,1,1464))
#####################################################################

######mapa rozkladu temperatur na swiecie######
###ladowanie pakietow do dalszej czesci###
install.packages("chron")
library(chron)
install.packages("lattice")
library(lattice)
install.packages("RColorBrewer")
library(RColorBrewer)
install.packages("zoo")
library(zoo)
install.packages("animation")
library(animation)

#zanim zrobimy mape i animacje przygotujemy sobie potrzebne dane czasowe (daty)
#przypomnijmy sobie utworzona zmienna z datami
head(time)
#oraz zmienna z atrybutami zmiennej "time"
tunits 
#wykorzystamy zmienna tunits (dokładnie jej pole "value") do przeksztalcenia dat na bardziej przystepny format 
#(uwaga! format amerykanski, czyli mm.dd.yy)
#tworzymy nowy wektor z datami w tym formacie 
##wybieramy pole "value" i dzielimy jego elementy
tustr <- strsplit(tunits$value, " ")
tustr
##wyciagamy i oddzielamy od siebie skladniki daty i zapisujemy do nowej zmiennej (do listy)
tdstr <- strsplit(unlist(tustr)[3], "-")
tdstr
##zapisujemy wydzielone czesci daty do oddzielnych zmiennych
tyear <- as.integer(unlist(tdstr)[1])#jako liczby
tmonth <- as.integer(unlist(tdstr)[2]) 
tday <- as.integer(unlist(tdstr)[3])
##...i wreszcie wykorzystujemy je do przeksztalcenia formatu daty funkcja chron()
time_ch<-chron(time,origin=c(tmonth, tday, tyear)) #po co tak, jak mozna c(1900,1,1)? - bo skrypt powinien byc uniwersalny ;)
head(time_ch) #nasza pierwsza data to orygin+380
##usunmy jeszcze informacje o dniu (jest zbedna - to sa dane miesieczne)
time_m_y<-as.yearmon(time_ch)
time_m_y #polskie nazwy bo polski Windows
##zmienimy nazwy na angielskie
Sys.setlocale("LC_TIME", "C")
time_m_y<-as.yearmon(time_ch)
head(time_m_y)

#wszystko co trzeba do sporządzenia mapy juz mamy, wiec zaczynamy
####### mapa rozkladu tmp na swiecie dla danego miesiaca#######

#zrobimy mape rozkladu temperatur na swiecie dla stycznia 1901
#uwaga - korzystamy ze zmiennej tmp_array, jeżeli wcześniej miales problemy z jej utworzeniem zobacz na inny sposob podany ponizej
m <- 1 # bo styczen 1901 to pierwsza dana czasowa
#wybieramy dane - pojedynczy "slice" czasowy danych
tmp_slice <- tmp_array[,,m] #[lon,lat,time]

################################################################
#bez ładowania calosci danych do pamieci (czyli bez tworzenia zmiennej tmp_array):
#m<-1 # bo to bedzie ”slice” czasowy dla stycznia 1901 roku, czyli pierwszej danej
#tmp_slice<-ncvar_get(ncin,"tmp",start=c(1,1,m),count=c(720,360,m)) 
################################################################

#zobaczmy zakres tmp w styczniu 1901 roku (omijajac wartosci NA)
range(na.omit(tmp_slice))
#problem: na.omit nie umie sobie poradzic z tym formatem danych 
#(nie wie jak usuwac dane w trojwymiarowym formacie). 
#musimy rozwinac wszystko w jeden dlugi wektor (as.numeric)
range(na.omit(as.numeric(tmp_slice)))

#wreszcie robimy mape z uzyciem funkcji image (utworzona mapa jest zawsze w "kwadrat")
image(lon,lat,tmp_slice, col=rev(brewer.pal(10,"RdBu")), xlim=c(-180,180),ylim=c(-90,90),zlim=c(-53, 34))
#dodajmy daty na rysunku (wykorzystamy zmienna time_m_y)
text(-150,-70,time_m_y[m])

#zadanie: porownajmy ta mape z mapa dla stycznia 2022 roku
length(time) #dlugosc wektora "time"
m<-1453  # 1464-11
tmp_slice <- tmp_array[,,m] #lub tmp_slice<-ncvar_get(ncin,"tmp",start=c(1,1,m),count=c(720,360,m)) 
image(lon,lat,tmp_slice, col=rev(brewer.pal(10,"RdBu")), xlim=c(-180,180),ylim=c(-90,90),zlim=c(-56,34))
text(-150,-70,time_m_y[m])
