library(dplR)
library(ncdf4)

  # wczytanie danych dendrochronologicznych dla stacji nr2 i nr8
mong008_chron<-read.crn("mong008r.crn")
head(mong008_chron)
mong002_chron<-read.crn("mong002r.crn")
head(mong002_chron)

  # wczytanie danych dendrochronologicznych 
ncin<-nc_open("cru_ts4.07.1901.2022.tmp.dat.nc")

  # przygotowanie danych
lon <- ncvar_get(ncin,"lon")
lat <- ncvar_get(ncin,"lat")

  # mong002 lat-47.77 lon-107.01
lon_2<-which(lon==107.25)
lat_2<-which(lat==47.75)
lon_2
lat_2

  # mong008 lat-49.37 lon-94.88
lon_8<-which(lon==94.75)
lat_8<-which(lat==49.25)
lon_8
lat_8

tmp_mong002 <- ncvar_get(ncin,"tmp",start=c(lon_2,lat_2,1),count=c(1,1,1464))
tmp_mong008 <- ncvar_get(ncin,"tmp",start=c(lon_4,lat_4,1),count=c(1,1,1464))

  # wektor lat
years<-seq(1901,2022,1)

  # dane dla stycznia
tmp1_mong002 <- round(tmp_mong002[seq(1, 1464,12)], digits=2)
tmp1_mong008 <- round(tmp_mong008[seq(1, 1464,12)], digits=2)

  # dane dla lutego
tmp2_mong002 <- round(tmp_mong002[seq(2, 1464,12)], digits=2)
tmp2_mong008 <- round(tmp_mong008[seq(2, 1464,12)], digits=2)

  # dane dla marca
tmp3_mong002 <- round(tmp_mong002[seq(3, 1464,12)], digits=2)
tmp3_mong008 <- round(tmp_mong008[seq(3, 1464,12)], digits=2)

  # dane dla kwietnia
tmp4_mong002 <- round(tmp_mong002[seq(4, 1464,12)], digits=2)
tmp4_mong008 <- round(tmp_mong008[seq(4, 1464,12)], digits=2)

  # dane dla maja
tmp5_mong002 <- round(tmp_mong002[seq(5, 1464,12)], digits=2)
tmp5_mong008 <- round(tmp_mong008[seq(5, 1464,12)], digits=2)

  # dane dla czerwca
tmp6_mong002 <- round(tmp_mong002[seq(6, 1464,12)], digits=2)
tmp6_mong008 <- round(tmp_mong008[seq(6, 1464,12)], digits=2)

  # dane dla lipca
tmp7_mong002 <- round(tmp_mong002[seq(7, 1464,12)], digits=2)
tmp7_mong008 <- round(tmp_mong008[seq(7, 1464,12)], digits=2)

  # dane dla sierpnia
tmp8_mong002 <- round(tmp_mong002[seq(8, 1464,12)], digits=2)
tmp8_mong008 <- round(tmp_mong008[seq(8, 1464,12)], digits=2)

  # dane dla września
tmp9_mong002 <- round(tmp_mong002[seq(9, 1464,12)], digits=2)
tmp9_mong008 <- round(tmp_mong008[seq(9, 1464,12)], digits=2)

  
  # korelacja, okres wpólny dla wszystkich danych: (2):1901-1994 (8):1901-1998
  # wyciaganie tytulow wierszy (lata kalendarzowe) i przypisanie do wektora
years_chron_2 <- as.numeric(row.names(mong002_chron))
years_chron_8 <- as.numeric(row.names(mong008_chron))


  # definicja poczatkow i koncow wspolnych okresow
start_chron_2 <- which(years_chron_2==1901) # 397
end_chron_2   <- length(mong002_chron[,1])  # 490
start_chron_8 <- which(years_chron_8==1901) # 261
end_chron_8   <- length(mong008_chron[,1])  # 358

  # ucinamy niepotrzebne dane dendro (wybieramy tylko te ze wspolnego okresu)
comm_chron_2 <- mong002_chron[start_chron_2:end_chron_2,1]
comm_chron_8 <- mong008_chron[start_chron_8:end_chron_8,1]

  # ucinamy niepotrzebne dane temperaturowe (wybieramy tylko te ze wspolnego okresu)
comm_tmp1_2 <- tmp1_mong002[1:(max(years_chron_2)-1900)]
comm_tmp2_2 <- tmp2_mong002[1:(max(years_chron_2)-1900)]
comm_tmp3_2 <- tmp3_mong002[1:(max(years_chron_2)-1900)]
comm_tmp4_2 <- tmp4_mong002[1:(max(years_chron_2)-1900)]
comm_tmp5_2 <- tmp5_mong002[1:(max(years_chron_2)-1900)]
comm_tmp6_2 <- tmp6_mong002[1:(max(years_chron_2)-1900)]
comm_tmp7_2 <- tmp7_mong002[1:(max(years_chron_2)-1900)]
comm_tmp8_2 <- tmp8_mong002[1:(max(years_chron_2)-1900)]
comm_tmp9_2 <- tmp9_mong002[1:(max(years_chron_2)-1900)]

comm_tmp1_8 <- tmp1_mong008[1:(max(years_chron_8)-1900)]
comm_tmp2_8 <- tmp2_mong008[1:(max(years_chron_8)-1900)]
comm_tmp3_8 <- tmp3_mong008[1:(max(years_chron_8)-1900)]
comm_tmp4_8 <- tmp4_mong008[1:(max(years_chron_8)-1900)]
comm_tmp5_8 <- tmp5_mong008[1:(max(years_chron_8)-1900)]
comm_tmp6_8 <- tmp6_mong008[1:(max(years_chron_8)-1900)]
comm_tmp7_8 <- tmp7_mong008[1:(max(years_chron_8)-1900)]
comm_tmp8_8 <- tmp8_mong008[1:(max(years_chron_8)-1900)]
comm_tmp9_8 <- tmp9_mong008[1:(max(years_chron_8)-1900)]

  # Tworzenie ramek danych     # data{miesiac}  
  # 1argument: przyrost, 2argument: tmp stycznia, 3argument: tmp lutego...
data_2 <- data.frame(comm_chron_2, comm_tmp1_2, comm_tmp2_2, comm_tmp3_2, comm_tmp4_2, comm_tmp5_2, comm_tmp6_2, comm_tmp7_2, comm_tmp8_2, comm_tmp9_2)
data_8 <- data.frame(comm_chron_8, comm_tmp1_8, comm_tmp2_8, comm_tmp3_8, comm_tmp4_8, comm_tmp5_8, comm_tmp6_8, comm_tmp7_8, comm_tmp8_8, comm_tmp9_8)

cor.test(data_2$comm_chron_2, data_2$comm_tmp1_2)
cor.test(data_2$comm_chron_2, data_2$comm_tmp2_2)
cor.test(data_2$comm_chron_2, data_2$comm_tmp3_2)
cor.test(data_2$comm_chron_2, data_2$comm_tmp4_2)
cor.test(data_2$comm_chron_2, data_2$comm_tmp5_2)
cor.test(data_2$comm_chron_2, data_2$comm_tmp6_2)
cor.test(data_2$comm_chron_2, data_2$comm_tmp7_2)
cor.test(data_2$comm_chron_2, data_2$comm_tmp8_2)
cor.test(data_2$comm_chron_2, data_2$comm_tmp9_2)

cor.test(data_8$comm_chron_8, data_8$comm_tmp1_8)
cor.test(data_8$comm_chron_8, data_8$comm_tmp2_8)
cor.test(data_8$comm_chron_8, data_8$comm_tmp3_8)
cor.test(data_8$comm_chron_8, data_8$comm_tmp4_8)
cor.test(data_8$comm_chron_8, data_8$comm_tmp5_8)
cor.test(data_8$comm_chron_8, data_8$comm_tmp6_8)
cor.test(data_8$comm_chron_8, data_8$comm_tmp7_8)
cor.test(data_8$comm_chron_8, data_8$comm_tmp8_8)
cor.test(data_8$comm_chron_8, data_8$comm_tmp9_8)


      # S T A C J A    N U M E R   2
  # w przypadku 2 stacji nie zauważono znaczącej korelacji w żadnym z miesięcy,
  # analizę kontynuowano dla uśrednionych danych marca i kwietnia 
tmp3_mong002 <- tmp_mong002[seq(3, 1464,12)]
tmp4_mong002 <- tmp_mong008[seq(4, 1464,12)]
tmp_wiosna_mong002 <- (tmp3_mong002+tmp4_mong002)/2

years_chron_wiosna_mong002 <- as.numeric(row.names(mong002_chron))
start_chron_wiosna_mong002 <- which(years_chron_wiosna_mong002==1901)
end_chron_wiosna_mong002   <- length(mong002_chron[,1])
  # dodanie pierwszej kolumny; dane dendro
comm_chron_wiosna_mong002 <- mong002_chron[start_chron_wiosna_mong002:end_chron_wiosna_mong002,1]
  # dodanie drugiej kolumny; dane meteo
comm_tmp_wiosna_mong002 <- tmp_wiosna_mong002[1:(max(years_chron_wiosna_mong002)-1900)]
  # ramka z powyższych kolumn
data_wiosna_mong002 <- data.frame(comm_chron_wiosna_mong002,comm_tmp_wiosna_mong002)

  # gotwa ramka danych z przyrostu (1) i ze średniej temperatury w marcu i kwietniu (2)
  # korelacja
cor.test(data_wiosna_mong002$comm_chron_wiosna_mong002, data_wiosna_mong002$comm_tmp_wiosna_mong002)
  # korelacja istotna statystycznie i wyróżnia się spośród miesięcznych
  
  # rekonstrukcja
  # dzielimy wektor na pół i bierzemy okres młodszy
data2 = data_wiosna_mong002[48:94,]
mod_2<-lm(comm_tmp_wiosna_mong002~comm_chron_wiosna_mong002,data2)
summary(mod_2)
  # p-value = 0.2208 > 0.05, zatem model nieistotny statystycznie
cor.test(data2$comm_tmp_wiosna_mong002, data2$comm_chron_wiosna_mong002)
  # korelacja = -0.1820163 


  # korelacja w oknie czasowym

library(treeclim)
library(chron)
library(zoo)
library(lubridate)
  # tworzenie zmiennej z datami
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

clim_tmp_mong002 <- data.frame(year,month,tmp_mong002) # tworzenie ramki
View(clim_tmp_mong002)

  # gdy ramka jest gotowa robimy korelacje z danymi dendro w ruchomym oknie
dev.off() # czyszczenie (nie obowiazkowy fragment, jesli wyskakuje blad bez, nalezy uzyc)
mong002_moving<-dcc(mong002_chron, clim_tmp_mong002, selection = 1:9, method = "correlation", dynamic = "moving", win_size = 34, timespan=c(1948,1994))
plot(mong002_moving)
mong002_static<-dcc(mong002_chron, clim_tmp_mong002, selection = 1:9, method = "correlation")
plot(mong002_moving)
  # koniec analiz dla stacji 2




        #   S T A C J A    N U M E R   8
  # w przypadku stacji 8 zauobserwowano, że dla miesiąca kwiecień korelacja odstaje od reszty.
  # Próba Rekonstrukcji
data_8_kwiecien <- data.frame(comm_chron_8, comm_tmp4_8)
  # Kalibracja
data8 <- data_8_kwiecien[50:98,] 
mod_8 <- lm(comm_tmp4_8~comm_chron_8,data8)
summary(mod_8) 
  # p_value =0.11 > 0.05, zatem model nieisotny statystycznie

clim_tmp_mong008 <- data.frame(year,month,tmp_mong008)
View(clim_tmp_mong008)

  # korelacja w oknach czasowych
mong008_moving<-dcc(mong008_chron, clim_tmp_mong008, selection = 1:9, method = "correlation", dynamic = "moving", win_size = 34, timespan=c(1950,1998))
plot(mong008_moving)
mong008_static<-dcc(mong008_chron, clim_tmp_mong008, selection = 1:9, method = "correlation")
plot(mong008_moving)
