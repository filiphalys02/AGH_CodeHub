library(ncdf4)
library(chron)
library(lattice)
library(RColorBrewer)
library(zoo)

# Wczytanie danych
ncin <- nc_open("cru_ts4.07.1901.2022.tmp.dat.nc")

# Przygotowanie zmiennych lon i lat, time
lon <- ncvar_get(ncin,"lon")
lon
lat <- ncvar_get(ncin,"lat")
lat
time <- ncvar_get(ncin,"time")
time

# Srednie temperatury lipca w Rzeszowie (51°02’01”N 21°00’17”E). 

# Szukanie odpowiedniego oczka gridu
which(lat==50.25)
which(lon==22.25)

# Odczytywanie wartosci temperatury dla tej lokalizacji w kazdym miesiacu
rzeszow_tmp <- ncvar_get(ncin,"tmp",start=c(405,281,1),count=c(1,1,1464))
round(rzeszow_tmp, 1)

# Tworzenie zmiennej z datami
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
head(time_m_y)

# Wykres temperatur dla stycznia w okresie 1901-2022
slice_m <- seq(1,length(time_m_y),12)
plot(time_m_y[slice_m],rzeszow_tmp[slice_m],t="b")
abline(a=mean(rzeszow_tmp[slice_m]),b=0,col="Red",lwd=2)
abline(lm(rzeszow_tmp[slice_m]~time_m_y[slice_m]), col="Green", lwd=2)

# Wykres temperatur dla lutego w okresie 1901-2022
slice_m <- seq(2,length(time_m_y),12)
plot(time_m_y[slice_m],rzeszow_tmp[slice_m],t="b")
abline(a=mean(rzeszow_tmp[slice_m]),b=0,col="Red",lwd=2)
abline(lm(rzeszow_tmp[slice_m]~time_m_y[slice_m]), col="Green", lwd=2)

# Wykres temperatur dla marca w okresie 1901-2022
slice_m <- seq(3,length(time_m_y),12)
plot(time_m_y[slice_m],rzeszow_tmp[slice_m],t="b")
abline(a=mean(rzeszow_tmp[slice_m]),b=0,col="Red",lwd=2)
abline(lm(rzeszow_tmp[slice_m]~time_m_y[slice_m]), col="Green", lwd=2)

# Wykres temperatur dla kwietnia w okresie 1901-2022
slice_m <- seq(4,length(time_m_y),12)
plot(time_m_y[slice_m],rzeszow_tmp[slice_m],t="b")
abline(a=mean(rzeszow_tmp[slice_m]),b=0,col="Red",lwd=2)
abline(lm(rzeszow_tmp[slice_m]~time_m_y[slice_m]), col="Green", lwd=2)

# Wykres temperatur dla maja w okresie 1901-2022
slice_m <- seq(5,length(time_m_y),12)
plot(time_m_y[slice_m],rzeszow_tmp[slice_m],t="b")
abline(a=mean(rzeszow_tmp[slice_m]),b=0,col="Red",lwd=2)
abline(lm(rzeszow_tmp[slice_m]~time_m_y[slice_m]), col="Green", lwd=2)

# Wykres temperatur dla czerwca w okresie 1901-2022
slice_m <- seq(6,length(time_m_y),12)
plot(time_m_y[slice_m],rzeszow_tmp[slice_m],t="b")
abline(a=mean(rzeszow_tmp[slice_m]),b=0,col="Red",lwd=2)
abline(lm(rzeszow_tmp[slice_m]~time_m_y[slice_m]), col="Green", lwd=2)

# Wykres temperatur dla lipca w okresie 1901-2022
slice_m <- seq(7,length(time_m_y),12)
plot(time_m_y[slice_m],rzeszow_tmp[slice_m],t="b")
abline(a=mean(rzeszow_tmp[slice_m]),b=0,col="Red",lwd=2)
abline(lm(rzeszow_tmp[slice_m]~time_m_y[slice_m]), col="Green", lwd=2)

# Wykres temperatur dla sierpnia w okresie 1901-2022
slice_m <- seq(8,length(time_m_y),12)
plot(time_m_y[slice_m],rzeszow_tmp[slice_m],t="b")
abline(a=mean(rzeszow_tmp[slice_m]),b=0,col="Red",lwd=2)
abline(lm(rzeszow_tmp[slice_m]~time_m_y[slice_m]), col="Green", lwd=2)

# Wykres temperatur dla września w okresie 1901-2022
slice_m <- seq(9,length(time_m_y),12)
plot(time_m_y[slice_m],rzeszow_tmp[slice_m],t="b")
abline(a=mean(rzeszow_tmp[slice_m]),b=0,col="Red",lwd=2)
abline(lm(rzeszow_tmp[slice_m]~time_m_y[slice_m]), col="Green", lwd=2)

# Wykres temperatur dla października w okresie 1901-2022
slice_m <- seq(10,length(time_m_y),12)
plot(time_m_y[slice_m],rzeszow_tmp[slice_m],t="b")
abline(a=mean(rzeszow_tmp[slice_m]),b=0,col="Red",lwd=2)
abline(lm(rzeszow_tmp[slice_m]~time_m_y[slice_m]), col="Green", lwd=2)

# Wykres temperatur dla listopada w okresie 1901-2022
slice_m <- seq(11,length(time_m_y),12)
plot(time_m_y[slice_m],rzeszow_tmp[slice_m],t="b")
abline(a=mean(rzeszow_tmp[slice_m]),b=0,col="Red",lwd=2)
abline(lm(rzeszow_tmp[slice_m]~time_m_y[slice_m]), col="Green", lwd=2)

# Wykres temperatur dla grudnia w okresie 1901-2022
slice_m <- seq(12,length(time_m_y),12)
plot(time_m_y[slice_m],rzeszow_tmp[slice_m],t="b")
abline(a=mean(rzeszow_tmp[slice_m]),b=0,col="Red",lwd=2)
abline(lm(rzeszow_tmp[slice_m]~time_m_y[slice_m]), col="Green", lwd=2)

# Porownanie trendow temperaturowych w Rzeszowie w 2 30-letnich okresach: 1961-1990 i 1991-2020http://127.0.0.1:41983/graphics/e9c7d1aa-1cfc-4fa4-9efb-d0d4a9184c1b.png

# STYCZEN
slice_m <- seq(1,length(time_m_y),12)
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Wyznaczenie zakresu
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Stworzenie wykresu
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",ylim=c(-9,2),axes=FALSE)
# Dodanie drugiej serii danych
lines(time_m_y[g1],rzeszow_tmp[g2],t="b",col="Red")
axis(1,labels=FALSE)
axis(2)

# LUTY
slice_m <- seq(2,length(time_m_y),12)
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Wyznaczenie zakresu
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Stworzenie wykresu
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",ylim=c(-9,2),axes=FALSE)
# Dodanie drugiej serii danych
lines(time_m_y[g1],rzeszow_tmp[g2],t="b",col="Red")
axis(1,labels=FALSE)
axis(2)

# MARZEC
slice_m <- seq(3,length(time_m_y),12)
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Wyznaczenie zakresu
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Stworzenie wykresu
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",ylim=c(-4,8),axes=FALSE)
# Dodanie drugiej serii danych
lines(time_m_y[g1],rzeszow_tmp[g2],t="b",col="Red")
axis(1,labels=FALSE)
axis(2)

# KWIECIEN
slice_m <- seq(4,length(time_m_y),12)
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Wyznaczenie zakresu
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Stworzenie wykresu
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",ylim=c(4,15),axes=FALSE)
# Dodanie drugiej serii danych
lines(time_m_y[g1],rzeszow_tmp[g2],t="b",col="Red")
axis(1,labels=FALSE)
axis(2)

# MAJ
slice_m <- seq(5,length(time_m_y),12)
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Wyznaczenie zakresu
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Stworzenie wykresu
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",ylim=c(9,18),axes=FALSE)
# Dodanie drugiej serii danych
lines(time_m_y[g1],rzeszow_tmp[g2],t="b",col="Red")
axis(1,labels=FALSE)
axis(2)

# CZERWIEC
slice_m <- seq(6,length(time_m_y),12)
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Wyznaczenie zakresu
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Stworzenie wykresu
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",ylim=c(13,21),axes=FALSE)
# Dodanie drugiej serii danych
lines(time_m_y[g1],rzeszow_tmp[g2],t="b",col="Red")
axis(1,labels=FALSE)
axis(2)

# LIPIEC
slice_m <- seq(7,length(time_m_y),12)
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Wyznaczenie zakresu
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Stworzenie wykresu
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",ylim=c(16,22),axes=FALSE)
# Dodanie drugiej serii danych
lines(time_m_y[g1],rzeszow_tmp[g2],t="b",col="Red")
axis(1,labels=FALSE)
axis(2)

# SIERPIEN
slice_m <- seq(8,length(time_m_y),12)
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Wyznaczenie zakresu
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Stworzenie wykresu
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",ylim=c(15,22),axes=FALSE)
# Dodanie drugiej serii danych
lines(time_m_y[g1],rzeszow_tmp[g2],t="b",col="Red")
axis(1,labels=FALSE)
axis(2)

# WRZESIEN
slice_m <- seq(9,length(time_m_y),12)
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Wyznaczenie zakresu
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Stworzenie wykresu
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",ylim=c(10,17),axes=FALSE)
# Dodanie drugiej serii danych
lines(time_m_y[g1],rzeszow_tmp[g2],t="b",col="Red")
axis(1,labels=FALSE)
axis(2)

# PAZDZIERNIK
slice_m <- seq(10,length(time_m_y),12)
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Wyznaczenie zakresu
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Stworzenie wykresu
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",ylim=c(5,13),axes=FALSE)
# Dodanie drugiej serii danych
lines(time_m_y[g1],rzeszow_tmp[g2],t="b",col="Red")
axis(1,labels=FALSE)
axis(2)

# LISTOPAD
slice_m <- seq(11,length(time_m_y),12)
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Wyznaczenie zakresu
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Stworzenie wykresu
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",ylim=c(-2,9),axes=FALSE)
# Dodanie drugiej serii danych
lines(time_m_y[g1],rzeszow_tmp[g2],t="b",col="Red")
axis(1,labels=FALSE)
axis(2)

# GRUDZIEN
slice_m <- seq(12,length(time_m_y),12)
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Wyznaczenie zakresu
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Stworzenie wykresu
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",ylim=c(-9,2),axes=FALSE)
# Dodanie drugiej serii danych
lines(time_m_y[g1],rzeszow_tmp[g2],t="b",col="Red")
axis(1,labels=FALSE)
axis(2)






# STYCZEN
# Analiza zjawiska z liniamii trendow
slice_m <- seq(1,length(time_m_y),12)
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))

# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Umieszczenie na nowym wykresie danych z poprzedniego, zachowujac odpowiednie polozenie czasowe
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",xlim=c(1961,2020),ylim=c(-14,2))
lines(time_m_y[g2],rzeszow_tmp[g2],t="b",col="Red")

# Tworzenie dwioch ramek danych dla dwoch analizowanych okresow
df1<-data.frame(x=time_m_y[g1],y=rzeszow_tmp[g1])
df1
df2<-data.frame(x=time_m_y[g2],y=rzeszow_tmp[g2])
df2

# Wyliczenie modeli liniowych funkcja lm
m1<-lm(y~x,data=df1)
m2<-lm(y~x,data=df2)

# Dodanie modeli liniowych do wykresu
lines(time_m_y[g1],predict(m1))
lines(time_m_y[g2],predict(m2),col="Red")

# Wyniki modelowan 1 okresu
summary(m1)

# Dodaje przedluzenie linii z 1 okresu (predykcje) 
lines(time_m_y[g2],predict(m1,newdata=df2),col="Blue")

# Wyniki modelowan 1 okresu
summary(m2)


# LUTY
# Analiza zjawiska z liniamii trendow
slice_m <- seq(2,length(time_m_y),12)
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Umieszczenie na nowym wykresie danych z poprzedniego, zachowujac odpowiednie polozenie czasowe
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",xlim=c(1961,2020),ylim=c(-13,4))
lines(time_m_y[g2],rzeszow_tmp[g2],t="b",col="Red")
# Tworzenie dwioch ramek danych dla dwoch analizowanych okresow
df1<-data.frame(x=time_m_y[g1],y=rzeszow_tmp[g1])
df1
df2<-data.frame(x=time_m_y[g2],y=rzeszow_tmp[g2])
df2
# Wyliczenie modeli liniowych funkcja lm
m1<-lm(y~x,data=df1)
m2<-lm(y~x,data=df2)
# Dodanie modeli liniowych do wykresu
lines(time_m_y[g1],predict(m1))
lines(time_m_y[g2],predict(m2),col="Red")
# Wyniki modelowan 1 okresu
summary(m1)
# Dodaje przedluzenie linii z 1 okresu (predykcje) 
lines(time_m_y[g2],predict(m1,newdata=df2),col="Blue")
# Wyniki modelowan 1 okresu
summary(m2)

# MARZEC
# Analiza zjawiska z liniamii trendow
slice_m <- seq(3,length(time_m_y),12)
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Umieszczenie na nowym wykresie danych z poprzedniego, zachowujac odpowiednie polozenie czasowe
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",xlim=c(1961,2020),ylim=c(-4,8))
lines(time_m_y[g2],rzeszow_tmp[g2],t="b",col="Red")
# Tworzenie dwioch ramek danych dla dwoch analizowanych okresow
df1<-data.frame(x=time_m_y[g1],y=rzeszow_tmp[g1])
df1
df2<-data.frame(x=time_m_y[g2],y=rzeszow_tmp[g2])
df2
# Wyliczenie modeli liniowych funkcja lm
m1<-lm(y~x,data=df1)
m2<-lm(y~x,data=df2)
# Dodanie modeli liniowych do wykresu
lines(time_m_y[g1],predict(m1))
lines(time_m_y[g2],predict(m2),col="Red")
# Wyniki modelowan 1 okresu
summary(m1)
# Dodaje przedluzenie linii z 1 okresu (predykcje) 
lines(time_m_y[g2],predict(m1,newdata=df2),col="Blue")
# Wyniki modelowan 1 okresu
summary(m2)

# KWIECIEN
# Analiza zjawiska z liniamii trendow
slice_m <- seq(4,length(time_m_y),12)
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Umieszczenie na nowym wykresie danych z poprzedniego, zachowujac odpowiednie polozenie czasowe
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",xlim=c(1961,2020),ylim=c(4,15))
lines(time_m_y[g2],rzeszow_tmp[g2],t="b",col="Red")
# Tworzenie dwioch ramek danych dla dwoch analizowanych okresow
df1<-data.frame(x=time_m_y[g1],y=rzeszow_tmp[g1])
df1
df2<-data.frame(x=time_m_y[g2],y=rzeszow_tmp[g2])
df2
# Wyliczenie modeli liniowych funkcja lm
m1<-lm(y~x,data=df1)
m2<-lm(y~x,data=df2)
# Dodanie modeli liniowych do wykresu
lines(time_m_y[g1],predict(m1))
lines(time_m_y[g2],predict(m2),col="Red")
# Wyniki modelowan 1 okresu
summary(m1)
# Dodaje przedluzenie linii z 1 okresu (predykcje) 
lines(time_m_y[g2],predict(m1,newdata=df2),col="Blue")
# Wyniki modelowan 1 okresu
summary(m2)

# MAJ
# Analiza zjawiska z liniamii trendow
slice_m <- seq(5,length(time_m_y),12)
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Umieszczenie na nowym wykresie danych z poprzedniego, zachowujac odpowiednie polozenie czasowe
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",xlim=c(1961,2020),ylim=c(9,18))
lines(time_m_y[g2],rzeszow_tmp[g2],t="b",col="Red")
# Tworzenie dwioch ramek danych dla dwoch analizowanych okresow
df1<-data.frame(x=time_m_y[g1],y=rzeszow_tmp[g1])
df1
df2<-data.frame(x=time_m_y[g2],y=rzeszow_tmp[g2])
df2
# Wyliczenie modeli liniowych funkcja lm
m1<-lm(y~x,data=df1)
m2<-lm(y~x,data=df2)
# Dodanie modeli liniowych do wykresu
lines(time_m_y[g1],predict(m1))
lines(time_m_y[g2],predict(m2),col="Red")
# Wyniki modelowan 1 okresu
summary(m1)
# Dodaje przedluzenie linii z 1 okresu (predykcje) 
lines(time_m_y[g2],predict(m1,newdata=df2),col="Blue")
# Wyniki modelowan 1 okresu
summary(m2)

# LIPIEC
# Analiza zjawiska z liniamii trendow
slice_m <- seq(7,length(time_m_y),12)
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Umieszczenie na nowym wykresie danych z poprzedniego, zachowujac odpowiednie polozenie czasowe
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",xlim=c(1961,2020),ylim=c(16,22))
lines(time_m_y[g2],rzeszow_tmp[g2],t="b",col="Red")
# Tworzenie dwioch ramek danych dla dwoch analizowanych okresow
df1<-data.frame(x=time_m_y[g1],y=rzeszow_tmp[g1])
df1
df2<-data.frame(x=time_m_y[g2],y=rzeszow_tmp[g2])
df2
# Wyliczenie modeli liniowych funkcja lm
m1<-lm(y~x,data=df1)
m2<-lm(y~x,data=df2)
# Dodanie modeli liniowych do wykresu
lines(time_m_y[g1],predict(m1))
lines(time_m_y[g2],predict(m2),col="Red")
# Wyniki modelowan 1 okresu
summary(m1)
# Dodaje przedluzenie linii z 1 okresu (predykcje) 
lines(time_m_y[g2],predict(m1,newdata=df2),col="Blue")
# Wyniki modelowan 1 okresu
summary(m2)

# SIERPIEN
# Analiza zjawiska z liniamii trendow
slice_m <- seq(8,length(time_m_y),12)
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Umieszczenie na nowym wykresie danych z poprzedniego, zachowujac odpowiednie polozenie czasowe
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",xlim=c(1961,2020),ylim=c(15,22))
lines(time_m_y[g2],rzeszow_tmp[g2],t="b",col="Red")
# Tworzenie dwioch ramek danych dla dwoch analizowanych okresow
df1<-data.frame(x=time_m_y[g1],y=rzeszow_tmp[g1])
df1
df2<-data.frame(x=time_m_y[g2],y=rzeszow_tmp[g2])
df2
# Wyliczenie modeli liniowych funkcja lm
m1<-lm(y~x,data=df1)
m2<-lm(y~x,data=df2)
# Dodanie modeli liniowych do wykresu
lines(time_m_y[g1],predict(m1))
lines(time_m_y[g2],predict(m2),col="Red")
# Wyniki modelowan 1 okresu
summary(m1)
# Dodaje przedluzenie linii z 1 okresu (predykcje) 
lines(time_m_y[g2],predict(m1,newdata=df2),col="Blue")
# Wyniki modelowan 1 okresu
summary(m2)

# WRZESIEN
# Analiza zjawiska z liniamii trendow
slice_m <- seq(9,length(time_m_y),12)
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Umieszczenie na nowym wykresie danych z poprzedniego, zachowujac odpowiednie polozenie czasowe
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",xlim=c(1961,2020),ylim=c(10,17))
lines(time_m_y[g2],rzeszow_tmp[g2],t="b",col="Red")
# Tworzenie dwioch ramek danych dla dwoch analizowanych okresow
df1<-data.frame(x=time_m_y[g1],y=rzeszow_tmp[g1])
df1
df2<-data.frame(x=time_m_y[g2],y=rzeszow_tmp[g2])
df2
# Wyliczenie modeli liniowych funkcja lm
m1<-lm(y~x,data=df1)
m2<-lm(y~x,data=df2)
# Dodanie modeli liniowych do wykresu
lines(time_m_y[g1],predict(m1))
lines(time_m_y[g2],predict(m2),col="Red")
# Wyniki modelowan 1 okresu
summary(m1)
# Dodaje przedluzenie linii z 1 okresu (predykcje) 
lines(time_m_y[g2],predict(m1,newdata=df2),col="Blue")
# Wyniki modelowan 1 okresu
summary(m2)

# PAZDZIERNIK
# Analiza zjawiska z liniamii trendow
slice_m <- seq(10,length(time_m_y),12)
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Umieszczenie na nowym wykresie danych z poprzedniego, zachowujac odpowiednie polozenie czasowe
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",xlim=c(1961,2020),ylim=c(5,13))
lines(time_m_y[g2],rzeszow_tmp[g2],t="b",col="Red")
# Tworzenie dwioch ramek danych dla dwoch analizowanych okresow
df1<-data.frame(x=time_m_y[g1],y=rzeszow_tmp[g1])
df1
df2<-data.frame(x=time_m_y[g2],y=rzeszow_tmp[g2])
df2
# Wyliczenie modeli liniowych funkcja lm
m1<-lm(y~x,data=df1)
m2<-lm(y~x,data=df2)
# Dodanie modeli liniowych do wykresu
lines(time_m_y[g1],predict(m1))
lines(time_m_y[g2],predict(m2),col="Red")
# Wyniki modelowan 1 okresu
summary(m1)
# Dodaje przedluzenie linii z 1 okresu (predykcje) 
lines(time_m_y[g2],predict(m1,newdata=df2),col="Blue")
# Wyniki modelowan 1 okresu
summary(m2)

# LISTOPAD
# Analiza zjawiska z liniamii trendow
slice_m <- seq(11,length(time_m_y),12)
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Umieszczenie na nowym wykresie danych z poprzedniego, zachowujac odpowiednie polozenie czasowe
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",xlim=c(1961,2020),ylim=c(-2,9))
lines(time_m_y[g2],rzeszow_tmp[g2],t="b",col="Red")
# Tworzenie dwioch ramek danych dla dwoch analizowanych okresow
df1<-data.frame(x=time_m_y[g1],y=rzeszow_tmp[g1])
df1
df2<-data.frame(x=time_m_y[g2],y=rzeszow_tmp[g2])
df2
# Wyliczenie modeli liniowych funkcja lm
m1<-lm(y~x,data=df1)
m2<-lm(y~x,data=df2)
# Dodanie modeli liniowych do wykresu
lines(time_m_y[g1],predict(m1))
lines(time_m_y[g2],predict(m2),col="Red")
# Wyniki modelowan 1 okresu
summary(m1)
# Dodaje przedluzenie linii z 1 okresu (predykcje) 
lines(time_m_y[g2],predict(m1,newdata=df2),col="Blue")
# Wyniki modelowan 1 okresu
summary(m2)

# GRUDZIEN
# Analiza zjawiska z liniamii trendow
slice_m <- seq(12,length(time_m_y),12)
range(na.omit(as.numeric(rzeszow_tmp[slice_m])))
# Wybor odpowiednich okresow
g1<-slice_m[61:90]
g2<-slice_m[91:120]
# Umieszczenie na nowym wykresie danych z poprzedniego, zachowujac odpowiednie polozenie czasowe
plot(time_m_y[g1],rzeszow_tmp[g1],t="b",xlim=c(1961,2020),ylim=c(-9,2))
lines(time_m_y[g2],rzeszow_tmp[g2],t="b",col="Red")
# Tworzenie dwioch ramek danych dla dwoch analizowanych okresow
df1<-data.frame(x=time_m_y[g1],y=rzeszow_tmp[g1])
df1
df2<-data.frame(x=time_m_y[g2],y=rzeszow_tmp[g2])
df2
# Wyliczenie modeli liniowych funkcja lm
m1<-lm(y~x,data=df1)
m2<-lm(y~x,data=df2)
# Dodanie modeli liniowych do wykresu
lines(time_m_y[g1],predict(m1))
lines(time_m_y[g2],predict(m2),col="Red")
# Wyniki modelowan 1 okresu
summary(m1)
# Dodaje przedluzenie linii z 1 okresu (predykcje) 
lines(time_m_y[g2],predict(m1,newdata=df2),col="Blue")
# Wyniki modelowan 1 okresu
summary(m2)