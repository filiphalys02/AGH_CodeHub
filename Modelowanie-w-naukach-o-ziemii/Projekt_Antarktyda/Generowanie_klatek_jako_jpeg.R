library(animation)
library(ggplot2)
library(matrixStats)
library(jpeg)

dane <- read.csv("daily_ice_edge.csv")

rozmiar_danych <- dim(dane)
liczba_wierszy <- rozmiar_danych[1]
liczba_kolumn <- rozmiar_danych[2]
liczba_kolumn <- liczba_kolumn-1

dane_bezdat <- as.matrix(dane[1:liczba_wierszy,2:liczba_kolumn])
granica_lodu_min <- colMins(dane_bezdat)

katy <- c(0:359)

granica_lodu_min_dataframe <- data.frame(lon = katy, lat = granica_lodu_min)


id_daty <- 1

jpeg("000%03d.jpg")
for (i in 1:liczba_wierszy){
  
  granica_lodu <- data.frame(lon = katy, lat = dane_bezdat[i,])
  
  long <- cos( 2 * pi * granica_lodu$lon / 360 )
  latt <- sin( 2 * pi * granica_lodu$lat / 180 )
  
  lm <- lm(granica_lodu$lat~long+latt)
  predict <- predict(lm, newdata = data.frame(granica_lodu$lon))
  granica_lodu$predict <- predict
  granica_lodu_mat <- data.frame(lon = katy, lat = predict)
  
  x <- ggplot(granica_lodu, aes(x=lon,y=lat, col="Rzeczywisty zasieg")) +
    geom_path() + 
    geom_line(data = granica_lodu_mat, aes(x=lon,y=lat,col="Model matematyczny zasieg")) +
    geom_line(data = granica_lodu_min_dataframe, aes(x=lon,y=lat, col="Minimalny zasieg")) +
    coord_polar() +
    labs(x='', y='', title='Minimalny zasieg lodu') +
    scale_x_continuous(breaks = seq(0, 360, 45), labels = c("0°", "45°", "90°", "135°", "180°", "225°", "270°", "315°", "360°")) +
    ylim(-90,-45) +
    ggtitle(dane[id_daty,1]) +
    labs(color='Wykresy:') 
  print(x)
  id_daty = id_daty+1
  
}
dev.off()
