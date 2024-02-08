#####Przyklad rekonstrukcji zmiennej klimatycznej na podstawie szerokosci przyrostow rocznych drzew#####
###z wykorzystaniem metody, o której mowilismy na poprzednich zajeciach (tj. kalibracja i weryfikacja)###
##Przyklad 1##
#install.packages("dplR")
library(dplR)
#zobaczmy nasze dane "dendro" (posluza do rekonstrukcji temperatury)
mong009_chron<-read.crn("mong009wr.crn")
head(mong009_chron)
plot(mong009_chron)
#jest to chronologia szerokosci przyrostow rocznych modrzewia sybreyjskiego obejmujaca lata 1326-1998, pochodzaca z Mongolii
#jest to tzw. chronologia kompozytowa - powstala na bazie drewna drzew zyjacych oraz martwych przez zastosowanie metody "cross-dating".

#przygotujmy potrzebne dane "meteo" (klimatyczne, dla lokalizacji tej chronologii).
#install.packages ("ncdf4")
library(ncdf4)
ncin<-nc_open("cru_ts4.07.1901.2022.tmp.dat.nc")
lon <- ncvar_get(ncin,"lon")
lat <- ncvar_get(ncin,"lat")
#mong009 location: lon: 91.57, lat: 49.92
lon_i<-which(lon==91.75)
lat_i<-which(lat==49.75)
lon_i
lat_i
tmp_mong009<- ncvar_get(ncin,"tmp",start=c(lon_i,lat_i,1),count=c(1,1,1464))
#wyciagnijmy dane dla czerwca
tmp6_mong009<-round(tmp_mong009[seq(6, 1464,12)], digits=2)
years<-seq(1901,2022,1)
plot(years, scale (tmp6_mong009), t="b")

###korelacja dendro i meteo####
#zobaczmy jak korleuje sie chronologia KKCO z tmp. czerwca
#najpierw jednak utworzymy ramke danych dla okresu wspolnego danych, tj. 1901-1998.
#wykorzystamy tytuly wierszy (lata kalendarzowe), wyciagnijmy je jako wektor numeryczny
years_chron<-as.numeric(row.names(mong009_chron))
#definiujemy poczatek i koniec okresu wspolnego
start_chron<-which(years_chron==1901)
end_chron<-length(mong009_chron[,1])
#wybieramy dane dendro
comm_chron<-mong009_chron[start_chron:end_chron,1]
comm_chron
#a teraz dane metao, tj. tmp. czerwca
comm_tmp6<-tmp6_mong009[1:(max(years_chron)-1900)]
comm_tmp6
# wreszcie tworzymy ramke z danymi...
data<-data.frame(comm_chron, comm_tmp6)
data
#...i korelujemy
cor.test(data$comm_chron, data$comm_tmp6)
#korelacja jest istotna statyc wykres rozrzutu, wraz z obrazujaca ten związek prosta regresji.
#najpierw znajdziemy rownanie tej prostej, czyli zbudujemy model liniowy zwiazku pomiedzy
#temperatura czerwca (zmienna objaśniana) a szerokoscia przyrostow rocznych, czyli chronologia (zmienna objasniajaca)
mod_f<-lm(comm_tmp6~comm_chron,data)
summary(mod_f)
# zobrazujmy na rysunku ten zwiazek rysujac obliczony model (prosta regresji)
plot(data)
abline(mod_f,data)

###teraz proba rekonstrukcji, z wykorzystaniem techniki: kalibracja /weryfikacja###
#najpierw podzielmy nasze dane (data, zakres: 1901-1998) na dwa rowne okresy (tj. 1901-1949 oraz 1950-1998). 
#dla bardziej współczesnego (1950-1998) wykonamy model (etap kalibracji)
#potem zobaczymy jak model sprawdza sie, gdy zastosujemy go do danych z okresu starszego (etap weryfikacji).

##kalibracja -> tworzymy model dla danych okresu bardziej wspolczesnego (1950-1998)
data1<-data[50:98,] #wybieramy dane z okresu mlodszego (1950-1998)
mod_1<-lm(comm_tmp6~comm_chron,data1)
summary(mod_1)
#zobaczmy jeszcze na wartość korelacji danych z tego okresu
cor.test(data1$comm_tmp6, data1$comm_chron)

##weryfikacja
data2<-data[1:49,] #wybieramy dane z okresu starszego (1901-1949)
data2
#zobaczmy jak model mod_1 sprawdza sie w odniesieniu do danych z okresu starszego (data2)
#tzn. skorelujemy rzeczywiste temperatury czerwca w tym okresie (tj. 1901-1949)...
#...z tymi wymodelowanymi na podstawie danych dendro z tego samego okresu... 
#z zastosowaniem wczesniej utworzonego modelu (mod_1)
cor.test(data2$comm_tmp6, predict(mod_1,data2)) 
#korelacja jest istotna, czyli mozemy zastosowac model

##narysujmy jeszcze dane rzeczywiste i wymodelowane modelem (mod_1)
#najpierw dla okresu bardziej wspolczesnego
plot(years[50:98],data1$comm_tmp6,t="l")
lines(years[50:98], predict(mod_1,data1),t="l",col="Red")
#i dla okresu starszego
plot(years[1:49], data2$comm_tmp6,t="l")
lines(years[1:49], predict(mod_1,data2),t="l",col="Red")
#polaczmy wykresy aby lepiej porownac rekonstrukcje
plot(years[1:98], data$comm_tmp6,t="l")
lines(years[1:98],predict(mod_1,data),t="l",col="Red")

#skoro weryfikacja przebiegla pomyslnie, mozemy utworzyc model dla calosci okresu (tj. 1901-1998)...
#...aby następnie wykorzystac go do rekonstrukcji temperatury czerwca w okresie, dla ktorego bezposrednich danych temperaturowych brak.
#my juz mamy utworzony taki model ((utworzyliśmy go już wcześniej, to mod_f)
summary(mod_f)
#najpierw narysujemy temperatury odtworzone modelem z rzeczywistymi temperaturami dla okresu wspólnego
plot(years[1:98], data$comm_tmp6,t="l")
lines(years[1:98],predict(mod_f,data),t="l",col="Blue")
##wreszcie wykorzystajmy ten model do rekonstrukcji temperatury czerwca z okresu, gdzie brak tych danych
data3<-data.frame (comm_chron=mong009_chron[,1])
data3
mong009_tmp6_reconst<-predict(mod_f,data3)
mong009_tmp6_reconst
plot(years_chron, mong009_tmp6_reconst, t="l")
