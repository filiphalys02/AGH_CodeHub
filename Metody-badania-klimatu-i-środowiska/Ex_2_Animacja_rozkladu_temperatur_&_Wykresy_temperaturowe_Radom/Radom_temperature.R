#####ciag dalszy - mapy#####
#pamietaj o ustawieniu katalogu roboczego!!!
#ladujemy biblioteki
library(ncdf4)
library(chron)
library(lattice)
library(RColorBrewer)
library(zoo)
library(animation)
#robimy uchwyt do pliku (daje mozliwosc odczytania pliku, wszystko wiemy, ale nie musimy ladowac)
ncin<-nc_open("cru_ts4.07.1901.2022.tmp.dat.nc")
#przygotowujemy odpowiednie zmienne 
lon <- ncvar_get(ncin,"lon")
lon
nlon <- dim(lon)
lat <- ncvar_get(ncin,"lat")
nlat <- dim(lat)
time <- ncvar_get(ncin,"time")
nt <-dim(time)
#tak jak poprzednio - tworzymy zmienna z datami w odpowiednim formacie
tunits <- ncatt_get(ncin,"time","units") 
tustr <- strsplit(tunits$value, " ")
tdstr <- strsplit(unlist(tustr)[3], "-")
tmonth <- as.integer(unlist(tdstr)[2])
tday <- as.integer(unlist(tdstr)[3])
tyear <- as.integer(unlist(tdstr)[1])
time_ch<-chron(time,origin=c(tmonth, tday, tyear))
time_m_y<-as.yearmon(time_ch)
Sys.setlocale("LC_TIME", "C")
time_m_y<-as.yearmon(time_ch)
time_m_y
#######Mapy rozkładu temperatur na świecie dla danego miesiąca (ciąg dalszy)#######
#troszke przypomnienia
#zrobmy dwie mapy - dla czerwca i grudnia 1901 roku
##najpierw dla czerwca
m <- 6
###uwaga: dzialamy bez wykorzystania zmiennej tmp_array (jak na poprzednich zajeciach), 
####dane beda czytane bezposrednio z dysku
tmp_slice <- ncvar_get(ncin,"tmp",start=c(1,1,m),count=c(nlon,nlat,1))
#zobaczmy zakres
range(na.omit(as.numeric(tmp_slice)))
#i rysujemy mape
image(lon,lat,tmp_slice, col=rev(brewer.pal(10,"RdBu")), xlim=c(-180,180),ylim=c(-90,90),zlim=c(-17,39))
text(-150,-70,time_m_y[m])
##teraz mapa dla grudnia
m<-12
tmp_slice <- ncvar_get(ncin,"tmp",start=c(1,1,m),count=c(nlon,nlat,1))
image(lon,lat,tmp_slice, col=rev(brewer.pal(10,"RdBu")), xlim=c(-180,180),ylim=c(-90,90),zlim=c(-17,39))
text(-150,-70,time_m_y[m])
#cos jest nie tak, zobaczmy czy zmiescilismy sie w zadanym zakresie w przypadku drugiej mapy
range(na.omit(as.numeric(tmp_slice)))
#czyli musimy poprawic zakres
image(lon,lat,tmp_slice, col=rev(brewer.pal(10,"RdBu")), xlim=c(-180,180),ylim=c(-90,90),zlim=c(-45,34))
text(-150,-70,time_m_y[m])

#####ladniejsza mapa - za pomnocą funkcji levelplot() (pakiet "lattice")#####
##najpierw należy ustalić dwa parametry tej funkcji: data (siatke) oraz at (przedniały skali barw)
##siatka
grid <- expand.grid(lon=lon, lat=lat)
head(grid)
## wektor z przedzialami skal barw
cutpts <- c(-50,-40,-30,-20,-10,0,10,20,30,40,50) 

## i rysujemy mape
##wykorzystujemy zmienna tmp_slice (ostatni tmp_slice byl dla grudnia 1901)
##parametr "aspect" ustawiony jest na 0.5 (wys.=1/2 szerokosci obrazka)
levelplot(tmp_slice ~ lon * lat, data=grid, at=cutpts, cuts=11, pretty=T, col.regions=(rev(brewer.pal(10,"RdBu"))),aspect=0.5, main=as.character(time_m_y[m]))

#####animacja - zmiany sredniej temperatury stycznia w okresie 1901-2022#####
#wykorzytamy funkcje "seveGIF" z pakietu "animation"
#najpierw tworzymy sekwencje kolejnych styczni
slice_m<-seq(1,length(time_m_y),12) #kolejne argumenty: od/do/co ile
slice_m
###Uwaga: jakby animacja (patrz ponizej) sie nie utworzyla (przez klopoty z pamiecia)
###to w nastepnym podejsciu mozna zmniejszyc slice_m, np. do 10 lat: slice_m<-seq(1,10*12,12)

#Zobaczmy jaki jest zakres temperatur, aby dobrac lepiej skale
##inicjujemy zmienne min i max do temperatur (ustalimy je w petli)
min<-0
max<-0
for (m in slice_m){
  tmp_slice <- ncvar_get(ncin,"tmp",start=c(1,1,m),count=c(nlon,nlat,1))
  range<-range(na.omit(as.numeric(tmp_slice)))
  if (min>range[1]) min<-range[1]
  if (max<range[2]) max<-range[2] 
}
#zobaczmy min i max:
min
max
#na wszelki wypadek zrobmy dev.off()
dev.off()
#funkcja saveGIF wykorzystuje petle, z ktorej wyniki zapisywane sa do gif'a
saveGIF({
  for (m in slice_m){
    ### tmp_slice <- tmp_array[,,m]
    tmp_slice <- ncvar_get(ncin,"tmp",start=c(1,1,m),count=c(nlon,nlat,1))
    par(pin=c(5,2.5))
    image(lon,lat,tmp_slice, col=rev(brewer.pal(10,"RdBu")),xlim=c(-180,180),ylim=c(-90,90),zlim=c(min,max))
    text(-150,-70,time_m_y[m])
  }
},interval=0.2)

#Uwaga: jezeli robimy animacje drugi raz, to lepiej najpierw "wylaczyc" rysunki funkcja dev.off()

#######wersja dla okresu krotszego 1901-1930#######
slice_m<-seq(1,30*12,12)
saveGIF({
  for (m in slice_m){
    tmp_slice <- ncvar_get(ncin,"tmp",start=c(1,1,m),count=c(nlon,nlat,1))
    par(pin=c(5,2.5))
    image(lon,lat,tmp_slice, col=rev(brewer.pal(10,"RdBu")),xlim=c(-180,180),ylim=c(-90,90),zlim=c(min,max))
    text(-150,-70,time_m_y[m])
  }
},interval=0.2)

#######czesc druga - analiza zmian temperatury dla danej lokalizacji#####
#Wybierzmy z danych i narysujmy szereg czasowy dla konkretnego punktu w przestrzeni (np. oczko 401, 281)
site_tmp<-ncvar_get(ncin,"tmp",start=c(401,281,1),count=c(1,1,1464))
plot(time_m_y, site_tmp,t="l")
#zobaczmy fragment danych blizej, aby lepiej zobaczyc cyklicznosc
plot(time_m_y,site_tmp,t="l", xlim=c(1901,1920))
#wykres liniowy dla jednego miesiaca, tu: czerwca
slice_m<-seq(6,length(time_m_y),12) #wybieram pozycje czerwcow
plot(time_m_y[slice_m],site_tmp[slice_m],t="b") #troche inny niz poprzednio styl wykresu (t="b")
#prosta reprezentujaca srednia temperature dla calego okresu analizy
abline(a=mean(site_tmp[slice_m]),b=0,col="Red",lwd=2)
#sprawdzmy jaka byly srednie temperatury czerwca w Radomiu (51°24’13”N 21°09’24”E). 
##najpierw znajdzmy odpowiednie oczko gridu (funkcja which)
which(lat==51.25)
which(lon==21.25)
##zobaczmy wartosci temperatury dla tej lokalizacji
radom_tmp<-ncvar_get(ncin,"tmp",start=c(403,283,1),count=c(1,1,1464))
radom_tmp
round(radom_tmp, 1)
#narysujmy wykres temperatury dla czerwca, wraz prostą obrazującą średnią z całego okresu 
slice_m<-seq(6,length(time_m_y),12)
plot(time_m_y[slice_m],radom_tmp[slice_m],t="b")
abline(a=mean(radom_tmp[slice_m]),b=0,col="Red",lwd=2)
# dodajmy linię regresji obrazującą trend liniowy na przestrzeni lat
abline(lm(radom_tmp[slice_m]~time_m_y[slice_m]), col="Green", lwd=2)

# porównamy teraz trendy temperaturowe dla czerwca w Radomiu w dwóch 30-letnich okresach: 1961-1990 i 1991-2020.

# mamy już wybrane wszystkie czerwce z danych (zmienna slice_m) 
# więc z nich z wybieramy dane dla dwóch wspomnianych okresów:
g1<-slice_m[61:90]
g2<-slice_m[91:120]
#porownajmy przebieg temperatur w tych dwoch okresach
range(na.omit(as.numeric(radom_tmp[slice_m])))
plot(time_m_y[g1],radom_tmp[g1],t="b",ylim=c(13,21),axes=FALSE)
#dodanie drugej serii danych
lines(time_m_y[g1],radom_tmp[g2],t="b",col="Red")
#jeszcze osie...
axis(1,labels=FALSE)
axis(2)
#widac "rozjazd" danych, przeanalizujmy to zjawisko z wykorzystaniem modelowania liniowego
##narysujmy dwie serie danych na jednym wykresie z zachowaniem ich położeń czasowych
plot(time_m_y[g1],radom_tmp[g1],t="b",xlim=c(1961,2020))
lines(time_m_y[g2],radom_tmp[g2],t="b",col="Red")
#wyznaczmy modele liniowe (zaznaczmy trendy) za pomoca znanej juz funkcji lm (dopasowanie modelu liniowego)
##tworzymy najpierw dwie ramki danych dla dwoch analizowanych okresow
df1<-data.frame(x=time_m_y[g1],y=radom_tmp[g1])
df1
df2<-data.frame(x=time_m_y[g2],y=radom_tmp[g2])
df2
#liczymy modele liniowe
m1<-lm(y~x,data=df1)
m2<-lm(y~x,data=df2)
# wrysujmy modele na wykres (funkcja predict, bo funkcja abline dawalaby za dluga linie)
lines(time_m_y[g1],predict(m1))
lines(time_m_y[g2],predict(m2),col="Red")
#zobaczmy jeszcze wyniki modelowan
summary(m1)
##model nie jest istotny statystycznie (przy założeniu p<0.05)
##ale gdyby byl istotny, to jakby wyglądały nasze na jego podstawie przewidywania temp. w drugim okresie? - sprawdzmy:
lines(time_m_y[g2],predict(m1,newdata=df2),col="Blue") #parametrem newdata okreslamy lata dla ktorych chcemy wykonac predykcje
#a teraz drugi model (dla drugiego okresu)
summary(m2)
##model jest istotny - występuje wyraźny trend pozytywny w danych – temperatury rosną w okresie 1991–2020 
