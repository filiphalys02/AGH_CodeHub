# Zasadniczo, możemy wyróżni trzy rodzaje narzędzi wykorzystywanych do tworzenia wykresów:
# 1. Programy typu GIMP, Adobe Ilustrator, Corel Draw czy Inkscape, które pozwalają na konstrukcje dowolnej grafiki; 
# 2. Programy typu Excel czy Tableau pozwalające na szybkie konstrukcje szablonowych i prostych wykresów;
# 3. Biblioteki języków programowania (np. ggplot2), cechujące się dużą elastycznością pozwalając tworzyć złożone wykresy.
# 
# Możliwość tworzenia wizualizacji (reprezentacji graficznych) danych jest kluczowym krokiem w przekazywaniu informacji i wyników innym osobom. Chociaż R zapewnia wbudowane funkcje kreślące wykresy, biblioteka ggplot2 implementuje gramatykę grafiki, czyli spójny system opisu i tworzenia wykresów. Nauka tej biblioteki pozwala na wykonanie prawie każdego rodzaju wykresu, w szczególności do zastosowań statystycznych.

# Gramatyka grafiki

# Tak jak gramatyka w języku pomaga nam konstruować zdania ze słów, tak gramatyka grafiki pomaga nam konstruować figury graficzne z różnych jej elementów wizualnych. Pozwala opisywać różne części wykresu, które są na nim przedstawione. Pierwotnie opracowana przez Lelanda Wilkinsona, „gramatyka grafiki” została zaadaptowana przez Hadleya Wickhama do konstrukcji wykresów i składa się z kilku elementów:
#   
# **danych** 
# **obiektów geometrycznych** (okręgi, linie itp.), które pojawiają się na wykresie
# zestaw odwzorowań zmiennych na wykresie tzw. **estetyka** czyli sposób mapowania i wygląd obiektów geometrycznych
# **transformacji statystycznych** stosowanych do obliczenia wartości danych użytych na wykresie
# **położenia obiektów** w celu zlokalizowania każdego obiektu geometrycznego na wykresie
# **skali** (np. zakres wartości) dla każdego zastosowanego mapowania
# **układ współrzędnych** używany do organizowania obiektów geometrycznych
# **paneli** (facets) sposobu podziału wykresu na wykresy cząstkowe

# Powyższe elementy  składają się  się na warstwy, gdzie każda warstwa zawiera pojedynczy obiekt geometryczny, transformację statystyczną i dopasowanie pozycji. Każdy wykres zatem stanowi zestaw warstw, gdzie wygląd każdej warstwy jest oparty na jakimś aspekcie zbioru danych.

# Podstawowe komendy

# `ggplot()` - tworzy nowy wykres
# `aes()` - tworzy estetykę
# `+` dodaje warstwy do wykresu
# `ggsave()` - zapisuje wykres

# 1.0 Tworzenie wykresu ----

# Do stworzenia wykresu konieczne zdefiniowanie jest geometrii oraz estetyki
# 
# **Geometrii** (geometrie) - typ lub szablon wykresu, np.: `geom_point()` - wykres punktowy , `geom_line()` - wykres liniowy
# **Estetyki** (Aesthetics) - Sposobu prezentowania wartości zmiennej na wykresie, np. współrzędna x, y, wypełnienie. Opcje estetyki uzależnione są od typu wykresu i są argumentem funkcji `geom_???()`. 

install.packages("installr") 
library(installr) # ładujemy bibliotekę
updateR()

install.packages("ggplot2") # instaluje bibliotekę ggplot2
library(ggplot2) # ładujemy bibliotekę

# 2.0 Tworzenie pierwszego wykresu ----
ggplot() + geom_point(data = iris,        # dane  
                      mapping = aes(      # estetyka
                        x = Petal.Length, # współrzędna x
                        y = Petal.Width   # współrzędna y
                      )) 

# Odwołanie do danych można umieścić zarówno w `ggplot()` lub `geom_point()`
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) + geom_point()

# Wielokrotnie wykorzystywany kod można przypisać do obiektu
a <- ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) 
a + geom_point()

# Dodawanie kolejnych zasad mapowania 
ggplot() + geom_point(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width,
                                                 color = Species, # dodajemy kolor wypełnienia punktów
))

# 3.0 Przegląd estetyk ----

# ściąga
# https://bookdown.org/wangminjie/R4DS/images/ggplot_aesthetics_cheatsheet.png

# 4.0 Przegląd geometrii ----

# 4.1 Jedna zmienna 
# Zmienne numeryczne
a <- ggplot(mpg, aes(hwy))
a + geom_histogram() 
a + geom_density() 
a + geom_dotplot()
a + geom_area(stat = "bin") 
ggplot(mpg) + geom_qq(aes(sample=hwy))

# Zmienna dyskretna lub kategoryczna
ggplot(mpg, aes(class)) + geom_bar()

# 4.2 Dwie zmienne 
b <- ggplot(mpg, aes(cty, hwy))
b + geom_point()
b + geom_jitter()
b + geom_rug()
b + geom_label(aes(label = cty))
b + geom_quantile()
b + geom_smooth()
b + geom_label(aes(label = cty))
b + geom_text(aes(label = cty))

# dwie zmienne: ciągła i dyskretna
c <- ggplot(mpg, aes(class,hwy))
c + geom_boxplot()
c + geom_violin()
c + geom_dotplot(binaxis = "y")
c + geom_col()

# rozkład dwuwymiarowy zmiennej ciągłej
d <- ggplot(diamonds, aes(carat, price))
d + geom_bin2d()
d + geom_density2d()
d + geom_hex()

# 4.3 funkcje ciągłe 
e <- ggplot(economics, aes(date, unemploy))
e + geom_line()
e + geom_area()
e + geom_step(direction = "hv")

# 4.4 trzy zmienne 
seals$z <- sqrt(seals$delta_long^2 + seals$delta_lat^2)
f <- ggplot(seals, aes(long, lat)) 
f + geom_contour(aes(z = z))
f + geom_raster(aes(fill = z), interpolate = T)
f + geom_tile(aes(fill = z))

# 4.5 mapy
data <- data.frame(murder = USArrests$Murder, state = tolower(rownames(USArrests)))
map <- map_data("state")
?map_data()
l <- ggplot(data, aes(fill = murder))
l + geom_map(aes(map_id = state), map = map) + expand_limits(x = map$long, y = map$lat)

install.packages("maps")
library(maps)

mapa <- map_data(map = "world")
ggplot() + geom_map(data = mapa, mapping = aes(map_id = region), map = mapa) + expand_limits(x = mapa$long, y = mapa$lat)

b <- ggplot(mpg, aes(fl))
b + geom_bar()
b + geom_bar(aes(fill=fl)) -> n
n

# 5.0 Skala ----
n + scale_fill_manual(
  values = c("skyblue", "royalblue", "blue", "navy"), # nazwy kolorów
  limits = c("d", "e", "p", "r"), # zakres danych 
  breaks =c("d", "e", "p", "r"), # granice przedziałów
  name = "fuel", # tytul 
  labels = c("D", "E", "P", "R") # etykiety
)

# Ogólne komendy
# * = Estetyka: alpha, color, fill, linetype, shape, size
# scale_*_continuous() - wartości ciągle
# scale_*_discrete() - wartości dyskretne
# scale_*_identity() - jako wartość do wyświetlenia 
# scale_*_manual(values = c()) - ręczna manipulacja 

# 5.1 Skala x,y

# scale_x_date(labels = date_format("%m/%d"),
#             breaks = date_breaks("2 weeks")) - # x jako dane w formacie czasu 
# scale_x_log10() - skala logarytmiczna
# scale_x_reverse() - skala odwrócona 
# scale_x_sqrt() - pierwiastek kwadratowy

# 5.2 Kolor 
# dane dyskretne
n + scale_fill_brewer(palette = "Blues")
n + scale_fill_grey(start = 0.2, end = 0.8, 
                    # limits = c("d", "e", "p", "r"),
                    na.value = "red") 
library(RColorBrewer)
display.brewer.all()

# palety kolorów 
install.packages("ggsci")
library("ggsci")
??ggsci()
n +	scale_fill_npg() 
n + scale_fill_aaas() 
n + scale_fill_jco() 

# dane ciągłe 
a <- ggplot(mpg, aes(hwy))
o <- a + geom_histogram(aes(fill = ..x..))
o + scale_fill_gradient(low = "red",high = "yellow")
o + scale_fill_gradient2(low = "red", high = "blue", mid = "white", midpoint = 25)
o + scale_fill_gradientn(colours = terrain.colors(6))

# rainbow(), heat.colors(), topo.colors(), cm.colors()

install.packages("viridis")
library(viridis)
ggplot(data.frame(x = rnorm(10000), y = rnorm(10000)), aes(x = x, y = y)) +
  geom_bin2d() + coord_fixed() +  scale_fill_viridis()

# 5.3 Kształt 

p <- ggplot(mpg, aes(cty, hwy)) + geom_point(aes(shape = fl))
p + scale_shape(solid = FALSE) 
p + scale_shape_manual(values = c(3:7)) 

# przegląd punktów
ggplot() + geom_point(mapping = aes(x = rep(1:5,times=5), y = rep(1:5,each=5),
                                    shape = as.factor(1:25)), size =5) +
  scale_shape_manual(values = c(1:25)) 
# 5.4 Wielkość punktów
ggplot(mpg, aes(cty, hwy)) + geom_point(mapping =aes(size = cyl)) # promień
ggplot(mpg, aes(cty, hwy)) + geom_point(mapping =aes(size = cyl)) + 
  scale_size_area() # powierzchnia kola

# 6.0 Układ współrzędnych -----

o + coord_cartesian(xlim = c(0, 5))
o + coord_fixed(ratio = 1/8) 
o + coord_flip()
o + coord_polar(theta = "x", direction=1)
o + coord_trans(y="sqrt")

# mapy 
mapa <- map_data(map = "usa")
z <- ggplot() + geom_map(data = mapa, mapping = aes(map_id = region), map = mapa) + 
  expand_limits(x = mapa$long, y = mapa$lat)
z
z + coord_map()
z + coord_map(projection = "ortho", orientation=c(41, -100, 10))
?mapproj::mapproject()

z + coord_map(projection = "cylindrica")
z + coord_map(projection = "ortho")

# 7.0 Pozycja -----

s <- ggplot(mpg, aes(fl, fill = drv))
s + geom_bar(position = "dodge")
s + geom_bar(position = "fill")
s + geom_bar(position = "stack")

# 8.0 Skórki ----

n + theme_bw()
n + theme_classic()
n + theme_gray()
n + theme_light()
n + theme_void()
n + theme_minimal()
n + theme_dark()

# Możemy edytować części wykresu, które nie są związane z danymi, 
# czyli theme elements (np. tytuł, osie, tło, linie siatki, legenda),
# odnoszące się do poszczególnych własności tych elementów 
# (np. czcionka, kolor, położenie).

n + theme(panel.grid.major = element_line(colour = "black", size =1),
          plot.background = element_rect(fill = "blue"))

# element_text()
# element_line()
# element_rect()
# element_blank()
# guide_legend()

# 9.0 Panele (facets) ----

t <- ggplot(mpg, aes(cty, hwy)) + geom_point()

# facet_grid stara się ułożyć wykresy w siatkę
t + facet_grid(. ~ fl) # układ kolumn 
t + facet_grid(year ~ .) # układ wierszy
t + facet_grid(year ~ fl) # 
# facet_wrap zawija je według kolumn lub wierszy
t + facet_wrap(~ fl)

install.packages("gridExtra")
library(gridExtra)
grid.arrange(t,t,t,t,ncol=2)

# 10.0 Etykiety osi -----
t + ggtitle("Nowy tytul") # język polski 
t + xlab("New X label")
t + ylab("New Y label")
t + labs(title =" New title", x = "New x", y = "New y")

# 11.0 Cheatsheet -----------
#https://github.com/rstudio/cheatsheets/blob/main/data-visualization.pdf

# ZADANIE 1 
# A. Stwórz wykresy przedstawiajace zaleznosc dlugosci zycia od PKB dla wszystkich krajów w 2007 i 1952 z uwzglednieniem przynaleznosci do kontynentu oraz wielkosc populacji wykorzystujac dane gapminder. Zadbaj o taki sam zakres na osiach. B. Wykorzytsaj do tego panele i dane ze wszystkich lat.
install.packages("gapminder")
library(gapminder)
data <- gapminder

ex1 = ggplot() + 
  geom_point(data = data[data$year==2007 | data$year==1952,], mapping = aes(x = lifeExp, y = gdpPercap, color = continent, size = pop)) + 
  facet_grid(. ~ year) + 
  scale_size_continuous(breaks = c(5000000, 20000000, 100000000,500000000), labels = c("5M", "20M", "100M", "500M")) + 
  scale_y_sqrt()
ex1

# ZADANIE 2 
# Stwórz wykresy rozkładu przewidywanej dlugosci zycia dla poszczególnych kontynentów wykorzystujac zarowno wykres typu boxplot i violin.
x = data[data$year==1952,]
