###Detrending jednej serii###
#Poprzednio wykonalismy detrending automatycznie, taki sam dla wszystkich serii danych. Czasami jednak potrzebne jest indywidualne podej?cie do poszczeg?lnych serii w doborze odpowiedniej metody detrendingu.
#Wrocmy do danych ca533
library(dplR)
data(ca533)
series <- ca533[, "CAM011"]# wybór serii do analizy
View(series)
names(series) <- rownames(ca533) # pobranie i dodanie nazw wierszy (lata kalendarzowe) do serii
View(series)
# defaultowo 7 metod
series.rwi <- detrend.series(y = series, y.name = "CAM011", verbose=TRUE)
# wybierzmy tylko 3 metody
series.rwi <- detrend.series(y = series, y.name = "CAM011",
                             method=c("Spline", "ModNegExp","Friedman"),
                             difference=TRUE)
# a teraz zobaczmy dwie i porównajmy je
series.rwi <- detrend.series(y = series, y.name = "CAM011",
                             method=c("Spline", "ModNegExp"))
#w przypadku spline (tzw. funkcja gi?ta) mo?emy wybra? jego d?ugo?? (argument "nyrs"), domy?lnie jest to 67% d?ugo?ci serii (czyli 2/3 jej d?ugosci - to klasyczne podej?cie)
series.rwi <- detrend.series(y = series, y.name = "CAM011",
                             method="Spline")
#skrocmy okno, np. do 50 lat i porownajmy:
series.rwi <- detrend.series(y = series, y.name = "CAM011",
                             method="Spline",nyrs=50)
#zobaczmy sobie jeszcze na r??nic? pomi?dzy "ModNegExp", "ModHugershoff"
#skorzystamy z danych co021
data(co021)
series <- co021[, 4]
names(series) <- rownames(co021)
View(series)
series.rwi <- detrend.series(y = series, y.name = names(co021)[4],
                             method=c("ModNegExp", "ModHugershoff"),
                             verbose = TRUE, return.info = TRUE, 
                             make.plot = TRUE)
series.rwi <- detrend.series(y = series, y.name = names(co021)[4],
                             method=c("ModNegExp"),
                             verbose = TRUE, return.info = TRUE, 
                             make.plot = TRUE)

#########################regresja liniowa dla dendro i meteo###################################
library(dplR)

#####przygotowanie danych#####
#dane dendro: wczytujemy plik z chronologią
swed017_res<-read.crn("swed017_res.txt")
head(swed017_res)
plot(swed017_res)

#dane meteo: wczytujemy plik tmp_swed017.csv. UWAGA - ustawić "row names" na "use first column"
#zobaczmy czym są dane
is(tmp_swed017)
#do dalszych analiz najlepiej będzie przekształcić dane na wektor. W R nie można tego zrobić bezpośrednio z ramki danych
#dlatego przekształcamy dane do macierzy i potem do wektora:
tmp_swed017<-as.vector(as.matrix(tmp_swed017))
plot(tmp_swed017,t="l")
# Wyrysujmy dane dla jednego miesiąca, np. maja:
plot(tmp_swed017[seq(5,1440,12)],t="l")
#utworzymy ramkę danych zawierającą wszystkie potrzebne dane, tj. chronologię oraz śr. tmp. dla miesięcy maj-wrzesień
#potrzebne dane meteo (śr. tmp. miesięcy maj-wrzesień)
tmp5<-round(tmp_swed017[seq(5, 1440,12)], digits=1)
tmp6<-round(tmp_swed017[seq(6, 1440,12)], digits=1)
tmp7<-round(tmp_swed017[seq(7, 1440,12)], digits=1)
tmp8<-round(tmp_swed017[seq(8, 1440,12)], digits=1)
tmp9<-round(tmp_swed017[seq(9, 1440,12)], digits=1)
#tworzymy ramkę danych z danymi temperaturowymi
tmp_swed017<-data.frame(year=c(1901:2020), tmp5, tmp6, tmp7, tmp8, tmp9)
View(tmp_swed017)
#wróćmy do chronologii
View(swed017_res)
#przygotujmy sobie tą ramkę do połączenia z ramką tmp_data_swed017.
#skorzystamy z funkcji pakietu dplyr, dlatego instalujemy pakiet i ładujemy bibliotekę
install.packages("dplyr")
library(dplyr)
##poprawmy nazwę chronologii na pełną, jednocześnie usuńmy niepotrzebną kolumnę "samp.depth"
swed017_chron<-select(swed017_res, swed017=SWED01, -samp.depth)
##kolumną łącznkową będzie zmienna "year"
##poniewaz w tym momencie jest to nazwa wierszy, dodajmy ja jako kolejną zmienną:
swed017_chron$year<-as.integer(row.names(swed017_chron))
View(swed017_chron)
#zmieńmy jeszcze kolejność kolumn 
swed017_chron<-select(swed017_chron, year, swed017)
View(swed017_chron)
#łączymy ramki poleceniem right_join
swed017_data<-right_join(swed017_chron, tmp_swed017, by="year")
View(swed017_data)
#dane zostały przycięte "od góry"- startują od roku, w którym zaczynają się dane temperaturowe
#jednak nie zostały przycięte "od dołu"
#dla potrzeb dalszej analizy (korelacja) musimy przyciąć też dane "od dołu" -> do okresu wspólnego danych
swed017_data_common<-filter(swed017_data, year<=1978)
View(swed017_data_common)

#####korelacja danych dendro i meteo#####
#zobaczmy jak koreluje się chronologia swed017 z temperaturą poszczególnych miesięcy
cor(swed017_data_common$swed017, swed017_data_common)
#sprawdźmy istotność najlepszych korelacji
cor.test(swed017_data_common$swed017, swed017_data_common$tmp6)
cor.test(swed017_data_common$swed017, swed017_data_common$tmp7)

#dodajmy zmieną lato (średnia z czerwca i lipca) i zobaczmy, jak sie ona koreluje z chronologią
swed017_data_common<-mutate(swed017_data_common, tmp_lato=(tmp6+tmp7)/2)
View(swed017_data_common)
cor.test(swed017_data_common$tmp_lato, swed017_data_common$swed017)
#korelacja jest wyższa niż dla czerwca i lipca, jest też istotna
#narysujmy jeszcze wykres rozrzutu
plot(swed017_data_common$swed017, swed017_data_common$tmp_lato)
abline(lm(swed017_data_common$tmp_lato~swed017_data_common$swed017))

#znajdźmy równanie tej prostej regresji
#ponieważ będziemy chcieli wykorzystać chronologie do odtworzenia temperatury lata a nie odwrotnie...
#... więc chronologia będzie zmienną objaśniającą, a tmp. lata - zmienną objaśnianą.
rating_model_swed017<-lm(swed017_data_common$tmp_lato~swed017_data_common$swed017)
summary(rating_model_swed017)
#sprawdźmy błędy predykcji:
##czy są rozrzucone wokół 0
plot(rating_model_swed017$residuals)
#narysujmy histogram
hist(rating_model_swed017$residuals)
#test Shapiro-Wilka
shapiro.test(rating_model_swed017$residuals)
#qqnorm
qqnorm(rating_model_swed017$residuals)
qqline(rating_model_swed017$residuals)
