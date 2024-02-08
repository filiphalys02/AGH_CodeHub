#####sporządzenie mapy cechy (na razie będzie nią wysokość)#####

#powtarzamy część kroków wykonanych poprzednio, ponieważ potrzebne będą zmienne krakowUTM oraz data15_ppp_e 

#install.packages("httr") # do obsługi połączeń internetowych 
library(httr)
#TmbwO0DqGbLvxkgVqImR7GZKFY9h3c4x

#install.packages("jsonlite")#dane są w formacie JSON, pakiet do pracy w tym formacie
library(jsonlite) 
#pobranie danych o czujnikach w odległości 15km od ratusza 
r <- GET("https://airapi.airly.eu/v2/installations/nearest?lat=50.0617022&lng=19.9373569&maxDistanceKM=15&maxResults=-1", 
  add_headers(apikey = "TmbwO0DqGbLvxkgVqImR7GZKFY9h3c4x", Accept = "application/json")
)
#przejście do listy
jsonRespText<-content(r,as="text")
test15<-fromJSON(jsonRespText)

#tworzymy ramkę data15 - z danymi o lokalizacji i wysokości czjników

longitude<-test15$location$longitude
latitude<-test15$location$latitude
data15<-data.frame(longitude,latitude)
data15$elevation<-test15$elevation
head(data15)

#Potrzebny będzie też kontur Krakowa (z rozpakowanej paczki dzielnice_Krakowa.zip)

#install.packages("sf")
library(sf)

dzielnice<-st_read("dzielnice_Krakowa/dzielnice_Krakowa.shp") #układ odniesienia(CRS) to ETRS89 (Poland CS92)

# konwertujemy "dzielnice" do WGS84
dzielniceWGS84<-st_transform(dzielnice,crs = 4326) # "4326" to kod dla WGS84

# zostawiamy tylko kontur miasta 
krakowWGS84<-st_union(dzielniceWGS84)
plot(krakowWGS84)
#dodajmy jeszcze lokalizacje czujników
points(data15, pch=1)

#w dalszej części będziemy potrzebować obiektu ppp
#ładujemy kolejne dwa pakiety
#install.packages("spatstat")
library(spatstat)
#install.packages("sp")
library(sp)

#przekształcimy naszą mapę konturową krakowWGS84 na UTM
krakowUTM<-st_transform(krakowWGS84,CRS("+proj=utm +zone=34 +datum=WGS84")) #przejście ze sfery (lat lon) na płaską mapę w ukladzie UTM (małopolska jest w 34)

#tworzymy obiekt ppp dla danych z czujników 15km od rynku
## nowa ramka z już istniejacej data15
data_spat<-data.frame(lon=data15$longitude,lat=data15$latitude,elev=data15$elevation)
data_spat
##określamy co jest koordynatami i projekcją w naszej ramce
coordinates(data_spat) <- ~lon+lat #koordynaty
proj4string(data_spat) <- CRS("+proj=longlat +datum=WGS84")#układ
data_spat

##konwersja do układu UTM
data_UTM <- spTransform(data_spat, CRS("+proj=utm +zone=34 +datum=WGS84"))
#zmienna pomocnicza z koordynatami (bo spTransform wprowadza swoje nazwy kolumn z koordynatami)
XY<-coordinates(data_UTM)
## wreszcie możemy utworzyć obiekt ppp 2D (przycinamy dane oknem krakowUTM)
data15_ppp<-ppp(x=XY[,1],y=XY[,2],window=as.owin(krakowUTM))
plot(data15_ppp)
## obiekt ppp z wysokościami
## utworzenie ppp z "marks" czyli z danymi w punktach (tu tymi danymi będą wysokości punktów)
data15_ppp_e<-ppp(x=XY[,1],y=XY[,2],marks=data_UTM$elev,window=as.owin(krakowUTM))
plot (data15_ppp_e)
###############################################################################################
####przypomnienie statystyk dotyczących rozmieszczenia punktów:
###test kwadrantowy
qt <- quadrat.test(data15_ppp)
plot(qt)
qt
### histogram odległości do najbliższego punktu
nn<-nndist(data15_ppp)
hist(nn)
### rozkład prawdopodobieństwa wystąpienia punktu w danym miejscu
ed<-density(data15_ppp)
plot(ed)
points(data15_ppp,pch="*",col="White")
###############################################################################################

#######prosta mapa dla analizowanej cechy (tu: wysokości)#######
#install.packages("https://cran.r-project.org/src/contrib/Archive/maptools/maptools_1.1-8.tar.gz", repo=NULL, type="source")
library(maptools)
#install.packages("automap")
library(automap)
#install.packages("raster")
library(raster)

#konwersja z ppp (obiekt do stat. przestrz.) do spdf (Spatial Points Data Frame - obiekt do geostatystyki)
data15_spdf<-as.SpatialPointsDataFrame.ppp(data15_ppp_e)

#mapa wysokości w punktach pomiarowych (w lokalizacjach czujników)
spplot(data15_spdf)

#uwaga! Koordynaty nazwyją się po konwersji mx i my :)
coordinates(data15_spdf)

#narysujmy mapę naszej cechy (czyli wysokości) funkcją autoKrige z pakieru automap
##zastosujemy ordinary kriging w wariancie domyślnym dla otoczki wypukłej 
elev_auto <- autoKrige(marks ~ 1, input_data = data15_spdf)
plot(elev_auto)

##mapa z dodanymi punktami pomiarowymi i konturem Krakowa
plot(elev_auto$krige_output[1])
points(data15_ppp_e,pch="*",col="White")
plot(Window(data15_ppp_e),add=TRUE)


#######wariant ładnieszy mapy - dla zdefiniowanego wcześniej gridu#######

#1)konwersja konturu Krakowa do obiektu działającego w sf
bound<-st_as_sf(krakowUTM)  
plot(bound)

#2)proces definiowania gridu
# określenie siatki punktów, w których będzie dokonywana aproksymacja
# (z jakim dystansem i ile punktów w dwóch kierunkach) 
##pobierzmy współrzędne punktów konturu Krakowa w formie macierzy (st_coordinates, z sf)
coord<-as.data.frame(st_coordinates(krakowUTM)) #można też wyciągnąć je z bound
head(coord) # X i Y to są koordynaty punktów tworzących poligon, L1 i L2 - oznaczenia poligonów róźnych poziomów
summary(coord) #jest więcej poligonów niż 1 (L1 od 1 do 3), jest więc błąd w .shp

# aby otrzymać mapę wysokościową pokrywajacą cały obszar Krakowa ustalamy nowy zakres dla mapy
#nasza mapa bedzie prostokątem (siatka dla niego) z wpisanym w niego zarysem Krakowa

##określamy współrzędne naroży
### lewy dolny róg
left_down<-c( min(coord$X), min(coord$Y))
left_down
### prawy górny róg
right_up<-c( max(coord$X), max(coord$Y))
right_up
##ustalamy rozmiar oczka siatki w metrach (100x100 metrów)
size<-c(100,100)
##przeliczamy: ile oczek siatki przypada na długość i szerokość naszego prostokąta 
points<- (right_up-left_down)/size #wyliczenie liczby punktów (oczek)
num_points<-ceiling(points) #zaokrąglenie w górę 
num_points

#tworzymy wreszcie siatkę (funkcja z pakietu sp)
grid <- GridTopology(left_down, size,num_points)
grid
# kowertujemy siatkę do odpowiedniego formatu, w odpowiednim układzie (UTM)
gridpoints <- SpatialPoints(grid, proj4string = CRS("+proj=utm +zone=34 +datum=WGS84")) #elipsoida odniesienia WGS84
plot(gridpoints) #trochę to może potrwać

#już prawie rysujemy mapę, ale jeszcze:
## konwersja siatki do SpatialPixels (bo na tym działa autoKrige)
spgrid <- SpatialPixels(gridpoints)
head(spgrid)
plot(spgrid)
plot(bound,add=TRUE)

#2)rysujemy mapę zdefiniowanego wyżej gridu
#podobnie jak poprzednio najpierw robimy kriging (ustawimy sobie np. model ("Mat"))
#ustawiamy argument new_data na naszą siatkę
elev_auto <- autoKrige(marks ~ 1, input_data = data15_spdf,new_data=spgrid,model = "Mat")
# i rysujemy mapę (pierwsza kolumna w krige_output)
plot(elev_auto$krige_output[1])
#dodajmy też punkty
points(data15_ppp_e,pch="*",col="White")
# i kontur Krakowa
plot(bound,add=TRUE,border="White")

#narysujmy jeszcze mapę odchylenia standardowego (trzecia kolumna w krige_output))
plot(elev_auto$krige_output[3])
points(data15_ppp_e,pch="*",col="White")
plot(bound,add=TRUE,border="White")

####### Mapa ładniejsza, wycinana do granic Krakowa#######
#library(sp)

#install.packages("tmaptools")
library(tmaptools)
#wykorzystamy inną funkcję crop_shape z pakietu tmaptools

g<-st_as_sf(gridpoints)#konwersja do formatu na którym działa crop_shape
cg<-crop_shape(g,bound,polygon = TRUE) #argument polygon potrzebny aby wyciąć poligonem (a nie w kwadrat)
spgrid <- SpatialPixels(as_Spatial(cg))#konwersja z powrotem do st i następnie do SpatialPixels
dev.off()
plot(spgrid)
data15_ppp_e$marks #sprawdzamy czy czegoś nie przepisaliśmy
#i rysujemy mapę
elev_auto <- autoKrige(marks ~ 1, input_data = data15_spdf,new_data=spgrid) #nowa siatka
plot(elev_auto$krige_output[1])
points(data15_ppp_e,pch="*",col="White")

#zobaczmy błąd dopasowania 
plot(elev_auto$krige_output[3])
points(data15_ppp_e,pch="*",col="White")

####### mapa z faktorami #######
#często chcemy wyrysować zmienne ciągłe jako faktory
#elev_auto$krige_output$var1.pred - to są wartości składowej z elev_auto$krige_output[1] 
#dla prostoty wprawdzamy zmienną pomocniczą, zamiast pętli stosujemy ifelse 
#produkując 3 stany (muszą być co najmniej 3)
a<-elev_auto$krige_output$var1.pred
b<-rep("NA",length(a)) #tworzymy pusty wektor o długości a
b<-ifelse(a<=200,1,b)
b<-ifelse(a>200 & a<=260,2,b)  
b<-ifelse(a>260,3,b)
elev_auto$krige_output$var1.factor<-as.factor(b)#tworzymy nowy element
#Rysujemy,odwołując się do 4 elementu, a nie tylko do wektora (var1.factor), aby pobrać też współrzędne
plot(elev_auto$krige_output[4])

###################################################

