#inst klucz do Airly
#wyciągane dane bezpośrednio z Airly mając darmowe konto i klucz
#założenie: dane bezpośrednio z Airly odległość 10km od ratusza
#install.packages("httr") # do obsługi połączeń internetowych 
library(httr)

#install.packages("jsonlite")#dane są w formacie JSON, pakiet do pracy w tym formacie
library(jsonlite) 

#pobranie danych o czujnikach w konkretnej lokalizacji
##nasza lokalizacja to obszar 15 km od ratusza w Krakowie (lat=50.0617022, lng=19.9373569) 

r <- GET("https://airapi.airly.eu/v2/installations/nearest?lat=50.0617022&lng=19.9373569&maxDistanceKM=15&maxResults=-1", 
  add_headers(apikey = "t81KwXzV1EJ8XjNIYvyRHnZuXESyYIdJ", Accept = "application/json")
)
#transformacja formatów (od r (jest to obiekt typu response) przez JSON do listy)
jsonRespText<-content(r,as="text")
test15<-fromJSON(jsonRespText)

#zobaczmy ile jeszcze mamy zapytań (limit to 100 dziennie)
# x-ratelimit-remaining-day to pole w liście z ifno ile razy można jeszcze odpytać
headers(r)$'x-ratelimit-remaining-day' # funkcja pozwalająca oglądnąć nagłówki r (response)

#zobaczmy teraz czym jest "test15"?
is(test15)

#zobaczmy jakie mamy dane
str(test15)
View(test15) #lepiej widać w tabeli

#w jakich miejscowościach mamy czujniki
unique(test15$address$city)

# wybierzmy tylko lokalizacje ("installation"), które mają w adresie "Kraków"
test15_k<-test15[ test15$address$city=="Kraków", ]
View(test15_k)
#zobaczmy ile jest czujników
dim(test15_k) # na "7", bo jest 7 podgrup
str(test15_k)
####### mapa lokalizacji czujników na mapie konturowej #######

#tworzymy odpowiednią ramkę z danymi:
##ramka danych lokalizacyjnych czujników dla wariantu 15km tylko dla lokalizacji "Kraków" 
longitude<-test15_k$location$longitude
latitude<-test15_k$location$latitude
data15_k<-data.frame(longitude,latitude)
#dodajmy pole "elevation" (przyda się potem)
data15_k$elevation<-test15_k$elevation 
data15_k
#ramka danych lokalizacyjnych czujników dla wariantu 15km, ale wszystkie miejscowości
longitude<-test15$location$longitude
latitude<-test15$location$latitude
data15<-data.frame(longitude,latitude)
data15$elevation<-test15$elevation
data15

#zabieramy się do rysowania mapy, najpierw sprawdzenie danych (mogły być pola NA)
data15_k

#jeżeli tak, to trzeba je usunąć 
data15_k<-na.omit(data15_k)

#length(data15_k[,1])

#Czas na obiekty przestrzenne. Załadujmy pakiet sf służący do tego typu analiz

#install.packages("sf")
library(sf)

#Potrzebna będzie mapa konturowa Krakowa (wykorzystamy plik typu shape z mapą Krakowa wraz z dzielnicami). 
##rozpakujmy paczkę dzielnice_Krakowa.zip do katalogu roboczego (wszystkie pliki są potrzebne)...
##... a następnie wczytajmy dzielnice_Krakowa.shp:
dzielnice<-st_read("dzielnice_Krakowa/dzielnice_Krakowa.shp") #układ odniesienia (CRS) to ETRS89 (Poland CS92)

# ponieważ lokalizacje z Airly mamy w układzie WGS 84, konwertujemy "dzielnice" do tego układu
dzielniceWGS84<-st_transform(dzielnice,crs = 4326) # "4326" to kod dla WGS 84
View(dzielniceWGS84)

#rysujemy wszystkie cechy zmiennej
plot(dzielniceWGS84)
plot(dzielniceWGS84, max.plot=12) #wszystkie 12 atrybutów

#potrzebne są nam tylko granice Krakowa - narysujemy więc sobie wyciągnietą z shape'a geometrię
plot(st_geometry(dzielniceWGS84))

# nie potrzebujemy podziału na dzielnice, usuńmy więc niepotrzebne granice 
krakowWGS84<-st_union(dzielniceWGS84) #znajduje granice wspólne i je usuwa
plot(krakowWGS84)
#nanieśmy nasze punkty pomiarowe
points (data15_k,pch=19)
points (data15,pch=1)

####### statystki przestrzenne #######
#wykorzystamy je do oceny naszego obszaru analizy wzgledem jego opróbkowania (lokalizacji czujników)

#install.packages("spatstat")#pakiet do statystyk przestrzennych
library(spatstat)
#install.packages("sp")#pakiet do funkcji pomocniczych
library(sp)

#spatstat nie działa na danych sferycznych (a WGS taki jest), więc musimi przekonwertować kontur i lokalizacje czujników

#najpierw przekształcimy mapę konturową krakowWGS84 na UTM (posłuży ona potem do przycięcia danych)
krakowUTM<-st_transform(krakowWGS84,CRS("+proj=utm +zone=34 +datum=WGS84")) #przejście ze sfery (lat lon) na płaską mapę w ukladzie UTM (małopolska jest w 34)
krakowUTM

#teraz utworzymy obiekt do analiz przestrzennych (obiekt ppp - planar point pattern) 
#1) tworzymy nową ramkę danych o czujnikach, żeby nie przepisać już istniejacej data15 (chociaż będzie ona bardzo podobna - nazwy kolumn bedą skrócone)
data_spat<-data.frame(lon=data15$longitude,lat=data15$latitude,elev=data15$elevation)
data_spat
#2) aby utworzyć obiekt ppp musimy określić co jest koordynatami, a co projekcją w naszej ramce (funkcje z pakietu "sp")
coordinates(data_spat) <- ~lon+lat #koordynaty
proj4string(data_spat) <- CRS("+proj=longlat +datum=WGS84")#układ
data_spat # to jest obiekt w układzie sferycznym, który można już automatycznie konwertować 
#3) konwersja do układu UTM
data_UTM <- spTransform(data_spat, CRS("+proj=utm +zone=34 +datum=WGS84"))
#4)zmienna pomocnicza z koordynatami (bo spTransform wprowadza swoje nazwy kolumn z koordynatami)
XY<-coordinates(data_UTM)
#5) utworzenie obiektu ppp 2D (bierzemy wyszyskie punkty i przycinamy oknem krakowUTM)
data15_ppp<-ppp(x=XY[,1],y=XY[,2],window=as.owin(krakowUTM))
plot(data15_ppp)
### utworzenie ppp z "marks" czyli z danymi w punktach (tu tymi danymi będą wysokości punktów)
data15_ppp_e<-ppp(x=XY[,1],y=XY[,2],marks=data_UTM$elev,window=as.owin(krakowUTM))
plot (data15_ppp_e)

#zobaczymy czy czujniki są w miarę losowo rozrzucone po obszarze Krakowa
##popatrzmy więc na statystyki
###test kwadrantowy (bada liczbę punktów, które powinny być w poszczególnych sektorach w stosunku do ich liczby rzeczwiście występujacej)
qt <- quadrat.test(data15_ppp)
plot(qt)#ile jest czujników/ile powinno być aby rozłożenie było losowo-równomierne/Chi
qt

### histogram odległości do najbliższego punktu
nn<-nndist(data15_ppp)
hist(nn)

### rozkład prawdopodobieństwa wystąpienia punktu w danym miejscu
ed<-density(data15_ppp)
plot(ed)
points(data15_ppp,pch="*",col="White")
###ciag dalszy na kolejnych zajęciach###





















