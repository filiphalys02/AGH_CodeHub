library(httr)
library(jsonlite)
library(sp)
library(spatstat)
library(sf)
library(maptools)
library(tmaptools)
library(automap)

# Zmienne przechowujące kody dostępu
apikey_bartek = "4fcQdqKz8eyElIq0hGkmhVeVyBxfY0I0"
apikey_filip  = "t81KwXzV1EJ8XjNIYvyRHnZuXESyYIdJ"

# Wykorzystanie polecenia GET do pobrania danych z Airly
r <- GET("https://airapi.airly.eu/v2/installations/nearest?lat=50.0617022&lng=19.9373569&maxDistanceKM=15&maxResults=-1", 
         add_headers(apikey = apikey_bartek, Accept = "application/json")
)

# Lista 
jsonRespText <- content(r,as="text")
test15 <- fromJSON(jsonRespText)

# Utworzenie ramki danych z danymi niezbędnymi do dalszej analizy; lokalizacja, wysokość, id czujników
longitude <- test15$location$longitude
latitude  <- test15$location$latitude
data15    <- data.frame(longitude,latitude)
data15$elevation <- test15$elev
data15$id <- test15$id
data_spat <- data.frame(lon=data15$longitude,lat=data15$latitude,elev=data15$elev,id=data15$id)
coordinates(data_spat) <- ~lon+lat # Koordynaty
proj4string(data_spat) <- CRS("+proj=longlat +datum=WGS84") # Układ CRS

# Konwersja do UTM
data_UTM <- spTransform(data_spat, CRS("+proj=utm +zone=34 +datum=WGS84"))

# Ustalenie granic Krakowa za pomocą warstwy SHP
dzielnice <- st_read("dzielnice_Krakowa.shp") # Układ odniesienia to ETRS89
# Konweersja do WGS84
dzielniceWGS84 <- st_transform(dzielnice,crs = 4326)
# Granice miasta 
krakowWGS84 <- st_union(dzielniceWGS84)
# Konwersja do UTM
krakowUTM <- st_transform(krakowWGS84,CRS("+proj=utm +zone=34 +datum=WGS84"))

# Zmienna przechowująca koordynaty
XY <- coordinates(data_UTM)
# Utworzenie obiektu ppp w punktach, przycięcie danych do obszaru Krakowa
data15_ppp_id <- ppp(x=XY[,1],y=XY[,2],marks=data.frame(elev=data_UTM$elev,id=data_UTM$id),window=as.owin(krakowUTM))

# Pobieranie danych z AIRLY

n_id <- length(data15_ppp_id$marks$id) # Liczba czujników
id   <- data15_ppp_id$marks$id           # ID czujników

list_inst2 <- vector(mode = "list", length = n_id) # Lista, która będzie uzupełniana odczytami z czujników 

# Pobieranie danych z czujniów AIRLY
for (i in seq(1,n_id)) {
  # Utworzenie ciągu znaków określajacych adres, pod którym znajdują się pomiary z czujnika
  str <- paste("https://airapi.airly.eu/v2/measurements/installation?installationId=",id[i],sep="")
  # Pobieranie danych
  r <- GET(url=str,add_headers(apikey = apikey_bartek, Accept = "application/json"))
  # Konwersja na JSON, później na tekst 
  jsonRespText <- content(r,as="text")
  inst <- fromJSON(jsonRespText)
  
  list_inst2[[i]]<-inst 
}

# Zapis odczytów do pliku dla bezpieczeństwa
save(list_inst2,file="list_inst2.Rdata")

# Odczyt aktualnych wartości stężenia PM2.5 i temperatury
# Utworzenie pustych wektorów dla danych "Current"
current_pm <- rep(NA,n_id)
current_t  <- rep(NA,n_id)
# Odczyt danych i przypisanie ich do odpowiednich wektorów
for (i in seq(1,n_id)) {
  logic_pm <- list_inst2[[i]]$current$values$name=="PM25" 
  logic_t  <- list_inst2[[i]]$current$values$name=="TEMPERATURE"
  if (sum(logic_pm)==1)
    current_pm[i]<-list_inst2[[i]]$current$values[logic_pm,2] 
  if (sum(logic_t)==1) 
    current_t[i]<-list_inst2[[i]]$current$values[logic_t,2] 
}

# Przekształcenie obiektu ppp do obiektu spdf w celu narysowania mapy
data15_spdf <- as.SpatialPointsDataFrame.ppp(data15_ppp_id)
# Dodanie w formie kolumn wektorów, które zostały uzupełnione wartościami w pętli
data15_spdf$current_pm <- current_pm
data15_spdf$current_t  <- current_t
plot(data15_spdf)

# Oznaczenie danych NA
miss_pm <- is.na(data15_spdf$current_pm)
miss_t  <- is.na(data15_spdf$current_t)


# Kriging 
# Zarys Krakowa w odpowiednim formacie
bound <- st_as_sf(krakowUTM)
plot(bound)

# Wpółrzędne punktów granic Krakowa zapisane macierzowo
coord<-as.data.frame(st_coordinates(krakowUTM))

# Utworzenie siatki - prostokąt okalający Kraków

# Współrzędne naroży
left_down <- c( min(coord$X), min(coord$Y))
right_up  <- c( max(coord$X), max(coord$Y))

# Rozmiar oczka siatki (100x100 metrów)
size <- c(100,100)

# Wyznaczenie ilości oczek siatki przypadających odpowiednio na długość i szerokość prostokąta
points <- (right_up-left_down)/size
num_points <- ceiling(points) # Zaokrąglenie 

# Siatka
grid <- GridTopology(left_down, size,num_points)

# Kowersja siatki do odpowiedniego formatu w układzie WGS84
gridpoints <- SpatialPoints(grid, proj4string = CRS("+proj=utm +zone=34 +datum=WGS84"))

plot(gridpoints)  

# Przycięcie siatki granicami Krakowa
g  <- st_as_sf(gridpoints)
cg <- crop_shape(g,bound,polygon = TRUE)
spgrid <- SpatialPixels(as_Spatial(cg))
plot(spgrid)

# Kriging bez określenia metody
PM25_auto <- autoKrige(current_pm ~ 1, input_data = data15_spdf[!miss_pm,],new_data=spgrid)

# Kriging z czterema różnymi metodami
PM25_auto <- autoKrige(current_pm ~ 1, input_data = data15_spdf[!miss_pm,],new_data=spgrid, model="Sph")
PM25_auto <- autoKrige(current_pm ~ 1, input_data = data15_spdf[!miss_pm,],new_data=spgrid, model="Exp")
PM25_auto <- autoKrige(current_pm ~ 1, input_data = data15_spdf[!miss_pm,],new_data=spgrid, model="Gau")
PM25_auto <- autoKrige(current_pm ~ 1, input_data = data15_spdf[!miss_pm,],new_data=spgrid, model="Ste")

# Mapa
plot(PM25_auto$krige_output[1],main="PM 2.5")
# Nałożenie punktów na mapę
points(data15_ppp_id[!miss_pm,],pch="*",col="White")

# Błędy i semivariongram
plot(PM25_auto)

# Kriging bez określenia metody
t_auto <- autoKrige(current_t ~ 1, input_data = data15_spdf[!miss_t,],new_data=spgrid)

# Kriging z czterema różnymi metodami
t_auto <- autoKrige(current_t ~ 1, input_data = data15_spdf[!miss_t,],new_data=spgrid, model="Sph")
t_auto <- autoKrige(current_t ~ 1, input_data = data15_spdf[!miss_t,],new_data=spgrid, model="Exp")
t_auto <- autoKrige(current_t ~ 1, input_data = data15_spdf[!miss_t,],new_data=spgrid, model="Gau")
t_auto <- autoKrige(current_t ~ 1, input_data = data15_spdf[!miss_t,],new_data=spgrid, model="Ste")

# Mapa
plot(t_auto$krige_output[1],main="Temp")
# Nałożenie punktów na mapę
points(data15_ppp_id[!miss_t,],pch="*",col="White")

# Błędy i semivariongram
plot(t_auto)

