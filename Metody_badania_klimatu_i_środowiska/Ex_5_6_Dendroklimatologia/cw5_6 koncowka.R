#proba rekonstrukcji dla cana049 nie powiodla sie, wyniki wskazywały na niestabilnosć czasową korelacji
#sprawdzimy, czy rzeczywiście korelacja jest nistabilna w czasie (wykonamy korelacje w oknie czasowym)

#najpierw musimy pobrać i przygotować dane (chronologie cana049 oraz dane tmp. do tej lokalizacji)
library(dplR)
#wczytujemy plik zawierający chronologię cana049ws, tworząc zmienną o tej nazwie
cana049_chron<-read.crn("cana049ws.crn")
head(cana049_chron)

#pobieramy dane meteo (tmp)
library(ncdf4)
ncin<-nc_open("cru_ts4.07.1901.2022.tmp.dat.nc")
lon <- ncvar_get(ncin,"lon")
lat <- ncvar_get(ncin,"lat")
#szukamy danych tmp. dla lokalizacji chronologii cana049 (czyli lon: -61.57, lat: 54.2)
lon_i<-which(lon==-61.75)
lat_i<-which(lat==54.25)
#pobieramy dane tmp. dla odpowiedniego oczka gridu
tmp_cana049<- ncvar_get(ncin,"tmp",start=c(lon_i,lat_i,1),count=c(1,1,1464))

#chronologia cana049 jest w formacie odpowiednim do pakietu, w którym wykonamy korleacje w oknie
#natomiast dane meteo wymagają przeksztalcenia do odpowiedniego formatu
library(chron)
library(zoo)
#install.packages("lubridate")
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
#temperatura jest w zmiennej "tmp_cana049", przygotowujemy odpowiednia ramke
clim_tmp_cana049<-data.frame(year,month,tmp_cana049)
View(clim_tmp_cana049)

###korelacja w oknach czasowych###
install.packages("treeclim")
library(treeclim)

#korelacja z danymi dendro w ruchomym oknie, wezmy pod uwagę miesiace od stycznia do wrzesnia roku tworzenia przyrostu
#uwaga! musimy ustalić zakres analizy, poniewaz dane nie koncza sie w tym samym roku (argument: timespan)
cana049_moving<-dcc(cana049_chron, clim_tmp_cana049, selection = 1:9, method = "correlation", dynamic = "moving", win_size = 34, timespan=c(1901,1988))
plot(cana049_moving)

#na koniec zobrazujmy sobie jeszcze wyniki korelacji dla tych zmiennych, ale liczone dla całego okresu (1901-1988)
#to tzw. korelacja "stacjonarna" (wspolcz. korel. liczony dla danych w calym okresie wspolnym danych)
#okres analizy: tak jak dla korleacji w oknie, tj. od stycznia do września roku w ktorym się on tworzy (selection=1:9)
cana049_static<-dcc(cana049_chron, clim_tmp_cana049, selection = 1:9, method = "correlation")
plot(cana049_static)
