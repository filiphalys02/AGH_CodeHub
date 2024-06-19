##Przyklad 2##
install.packages("dplR")
library(dplR)
#wykorzystamy chronologie przyrostow rocznych swierka bialego (Picea glauca (Moench) Voss), z Półwyspu Labrador w Kanadzie 
#wczytujemy plik zawierający chronologię cana049ws, tworząc zmienną o tej nazwie
cana049_chron<-read.crn("cana049ws.crn")
head(cana049_chron)
plot(cana049_chron)
#teraz musimy znalezc odpowiednie dane tmp. dla lokalizacji tej chronologii
library(ncdf4)
ncin<-nc_open("cru_ts4.07.1901.2022.tmp.dat.nc")
lon <- ncvar_get(ncin,"lon")
lat <- ncvar_get(ncin,"lat")
#szukamy danych tmp. dla lokalizacji chronologii cana049 (czyli lon: -61.57, lat: 54.2)
lon_i<-which(lon==-61.75)
lat_i<-which(lat==54.25)
lon_i
lat_i
#sprawdzmy jeszcze (dla przypomnienia) długosc (czasowa) serii
time <- ncvar_get(ncin,"time")
dim(time)
#pobieramy dane tmp. dla odpowiedniego oczka gridu
tmp_cana049<- ncvar_get(ncin,"tmp",start=c(lon_i,lat_i,1),count=c(1,1,1464))
plot(tmp_cana049,t="l")
#wyciagamy potrzebne dane temperaturowe (dla miesiecy letnich)
tmp6_cana049<-tmp_cana049[seq(6, 1464,12)]
tmp7_cana049<-tmp_cana049[seq(7, 1464,12)]
tmp8_cana049<-tmp_cana049[seq(8, 1464,12)]
#przygotowujemy tez dodatkowo zmienna "tmp_lato" (sr. tmp. lata)
tmp_lato_cana049<-(tmp6_cana049+tmp7_cana049+tmp8_cana049)/3
#narysujmy wykres temperatury w wybranych miesiącach oraz lecie, na jednym rysunku
#uwaga: narysujemy wykresy przedstawiajace odchylenia wartości od średniej
years<-seq(1901,2022,1)
plot(years, scale (tmp6_cana049), t="l")
lines (years, scale (tmp7_cana049),col="Red")
lines (years, scale (tmp8_cana049),col="Blue")
lines (years, scale (tmp_lato_cana049),col="Green")

####korelacja chronologii cana049 i z tmp. lata#####
#nowa ramka danych (z chronologią oraz serią temperaturową, we wspólnym okresie danych 1901-1988)
##zobaczmy dane dendro
View(cana049_chron)
##tytuły wierszy przydadza sie w nowej ramce danych
##dlatego przekształcamy je w wektor numeryczny
years_chron<-as.numeric(row.names(cana049_chron))
##przycinamy chronologie do okresu wspolnego danych dendro i meteo (czyli 1901-1988)
start_chron<-which(years_chron==1901)
end_chron<-length(cana049_chron[,1])
comm_chron<-cana049_chron[start_chron:end_chron,1] #pierwsza kolumna
comm_chron
##Teraz wybieramy odpowiedni zakres z pliku z temperaturami lata
comm_tmp_lato<-tmp_lato_cana049[1:(max(years_chron)-1900)] #druga kolumna
comm_tmp_lato
##tworzymy wreszcie ramkę potrzebnych danych
data<-data.frame(comm_chron,comm_tmp_lato)
data
#zobaczmy jak korelują się powyższe dane dendro i meteo
cor.test(data$comm_chron, data$comm_tmp_lato)
#zobrazujmy to na wykresie (utworzymy i narysujemy model liniowy)
mod_f<-lm(comm_tmp_lato~comm_chron,data)
summary(mod_f)
#wyrysujmy dane wraz z modelem
plot(data)
abline(mod_f,data)

#####proba rekonsturkcji, kalibracja/weryfikacja#####
#podzielmy nasze dane (data) na dwa rowne okresy (1901-1944 oraz 1945-1988). 
#dla okresu bardziej wspolczesnego (1945-1988) wykonamy model (kalibracja)
#potem zobaczymy jak model się sprawdza, gdy zastosujemy go do danych z okresu wczesniejszego (weryfikacja).

#dzielimy dane i wykonujemy model dla ostatnich 44 lat danych (1945-1988)
data1<-data[45:88,] #bo okres danych obejmuje 88 lat
mod_1<-lm(comm_tmp_lato~comm_chron,data1)
summary(mod_1)
#Model  jest nieistotny statystycznie. 
#Sprawdźmy jeszcze korelację w tym przedziale (1945-1988)
cor.test(data1$comm_tmp_lato, data1$comm_chron)
#wynik ten sugeruje, ze zwiazek nie jest staly w calym zakresie danych (1901-1988)
#nie budujemy wiec modelu
#sprawdzmy jednak jeszcze jak wygladalby model utworzony dla danych ze starszego okresu
data2<-data[1:44,]
data2
mod_2<-lm(comm_tmp_lato~comm_chron,data2)
summary(mod_2)
plot(data2)
abline(mod_2,data2)
cor.test(data2$comm_tmp_lato, data2$comm_chron) 
#jak widać, korelacja jest znacznie wyzsza w okresie starszym niz tym bardziej wspolczesnym.   
#narysujmy rzeczywiste temperatury lata wraz z tymi wygenerowanymi przez model:
plot(years[1:44], data2$comm_tmp_lato,t="l")#dane tmp. rzeczywiste
lines(years[1:44], predict(mod_2,data2),t="l",col="Red")#tmp. odtworzona z chronologii szerokosci przyrostow rocznych, na podstawie modelu

#spojrzmy jeszcze raz na wykres temperatury dla lata (po co? zobacz na koncu materialow do zajec)
plot(years, tmp_lato_cana049,t="b")

###korelacja w oknach czasowych###
install.packages("treeclim")
library(treeclim)
#chronologia cana049 jest w dobrym formacie
#natomiast dane meteo wymagają przeksztalcenia do odpowiedniego formatu
library(chron)
library(zoo)
install.packages("lubridate")
library(lubridate)
#tak jak poprzednio - tworzymy zmienna z datami w odpowiednim formacie
time <- ncvar_get(ncin,"time")
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

year<-year(time_m_y)
month<-rep(seq(1,12),length(unique(year)))
#jeśli temperatura jest w zmiennej tmp, np. tmp_cana049 to robimy ramke
clim_tmp_cana049<-data.frame(year,month,tmp_cana049)
clim_tmp_cana049

#a teraz korelacja z danymi dendro w ruchomym oknie, wezmy pod uwagę miesiace od stycznia do wrzesnia roku tworzenia przyrostu
#uwaga!musimy ustalić zakres analizy, poniewaz dane nie koncza sie w tym samym roku (timespan)
cana049_moving<-dcc(cana049_chron, clim_tmp_cana049, selection = 1:9, method = "correlation", dynamic = "moving", win_size = 34, timespan=c(1901,1988))
plot(cana049_moving)


###korelacja "stacjonarna" (wspolcz. korel. liczony dla danych w calym okresie wspolnym danych)###
#zobaczmy jeszcze korelacje liczona dla calego okresu analizy
#okres analizy: od maja roku poprzedzajacego przyrost do września roku w ktorym się on tworzy (selection=-5:9)
cana049_static<-dcc(cana049_chron, clim_tmp_cana049, selection = 1:9, method = "correlation")
plot(cana049_static)
