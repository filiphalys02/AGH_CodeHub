install.packages("utils")
library(utils)
install.packages("dplR")
library(dplR)
###przykladowy zestaw danych dendrochronologicznych###
#ladujemy dane
data(ca533) # Bristlecone pine (Pinus longaeva D.K. Bailey; sosna długowieczna) z Gór Campito w Kalifornii.
dim(ca533) #wymiar danych: mamy 34 serie szerokości przyrostów rocznych, zakres czasowy to 1358 lat!
View(ca533)
colnames(ca533)#sygnatury serii szerokości przyrostów rocznych kolejnych osobników (drzew) z tego stanowiska
head(rownames(ca533))# kilka pierwszych lat chronologii
tail(rownames(ca533))# kilka ostatnich lat chronologii
#zobaczmy czym jest nasz obiekt
class(ca533)
# zobaczmy niektore charakterystyki
rwl.report(ca533)
# wykres zbiorczy wszytkich serii przyrostow rocznych drzew ze stanowiska
plot(ca533, plot.type="spag") 

###przyklad konstrukcji chronologii###
#wykorzystamy inne dane
##35 serii szerokości przyrostow rocznych Daglezji zielonej (Pseudotsuga menziesii) z Mesa Verde w Kolorado.
#zobaczmy dane
data(co021)
View(co021)
dim(co021) #zakres danych to 788 lat!!!
#zobaczmy podstawowe statystyki dla serii
summary(co021)
#zapiszmy sobie wartosci statystyk opisowych do ramki...
co021.sum <- summary(co021)
#...i wyświetlmy po kolei kilka statystyk dla całego setu danych (średnie)
mean(co021.sum$year)#srednia liczba lat w serii
mean(co021.sum$mean)#średnia szerokosc przyrostu
mean(co021.sum$stdev)#srednie odchylenie standardowe
mean(co021.sum$median)#mediana
mean(co021.sum$ar1) #autokorelacja
#sprawdzmy jaka jest wartosc srednia korelacji pomiedzy seriami (interseries correlation)
mean(interseries.cor(co021)[, 1])
#podsumowujac: zestaw danych sklada sie z dlugich serii 
##charakteryzuje go wysokie odchylenie standardowe...
##...wysoka autokorelacja pierwszego rzedu (tj. zaleznosc przyrostu w danym roku od roku poprzedniego)
#...oraz wysoka srednia korelacja pomiedzy seriami.
#wyrysujmy zestaw serii
plot(co021, plot.type="spag",)
# na pocz?tek utworzymy sobie chronologi? rzeczywist?, powstaj?c? po prostu poprzez u?rednienie serii przyrost?w rocznych 35 daglezji
##przed tym jednak ustabilizujemy wariancje serii (suma odchylek do sredniej bedzie mniejsza)
##o ile mniejsza? to zalezy od metody (tu wykorzystamy Power Transformation)
co021.pt <- powt(co021)
##budujemy "chronologie rzeczywista" (z serii po transformacji)
co021.raw <- chron(co021.pt, prefix="RAW")
head(co021.raw)
##narysujmy utworzona chronologie wraz z naniesonym pokryciem przez serie oraz zaznaczonymi trendami dlugookresowymi (spline 64-letni)
plot(co021.raw, add.spline=TRUE, nyrs=64)
#teraz proces tworzenia "chronologii standaryzowanej" 
###najpierw musimy "zdetrendowac" serie przyrostow rocznych, z ktorych utworzymy chronologie 
###zrobimy podwojny detrending, "klasycznymi" metodami.
## Pierwszy etap - detrending eksponenta (jezeli niemozliwe będzie jej dopasowanie to dopasowana zostanie prosta regresji) (method=NegExp)
co021.first.det <- detrend(co021.pt, method = "ModNegExp")
## Drugi detrending - detrending spline'm o d?ugo?ci 2/3 d?ugo?ci serii z 50% odcieciem)
co021.second.det <- detrend(co021.first.det, method="Spline")
## teraz budujemy chronologie z detrendowanych serii. Przy okazji argument prewhiten = TRUE pozwala na utworzenie "chronologii rezydualnej" (przez usuniecie autokorelacji - prewhitening)
## warto dodac, ze domyslnie liczona jest odporna srednia dwuwagowa Tukeya (srednia, na ktora nie maja wplywu wartosci odstajace).
co021.std.res <- chron(co021.second.det, prefix="std", prewhiten = TRUE)
head(co021.std.res)
##narysujmy obie wersje (std i res) chronologii
plot(co021.std.res, add.spline=TRUE, nyrs=64) 

###Detrending jednej serii###
#poprzednio wykonalismy detrending automatycznie (taki sam dla wszystkich serii)
#czasami jednak potrzebne jest indywidualne podejscie do poszczegolnych serii w doborze odpowiedniej metody detrendingu.
#wrocmy do danych ca533
data(ca533)
#wybierzmy do analizy serie o nazwie "CAM011"
series <- ca533[, "CAM011"]# wybór serii do analizy
#dodajmy nazwy wierszy (lata kalendarzowe) do serii
names(series) <- rownames(ca533) 
# defaultowo 7 metod
series.rwi <- detrend.series(y = series, y.name = "CAM011", verbose=TRUE)
# wybierzmy tylko 3 metody
series.rwi <- detrend.series(y = series, y.name = "CAM011",
                             method=c("Spline", "ModNegExp","Friedman"),
                             difference=TRUE)
# a teraz zobaczmy dwie i porównajmy je
series.rwi <- detrend.series(y = series, y.name = "CAM011",
                             method=c("Spline", "ModNegExp"))
#w przypadku splajna (tzw. funkcja gieta) mozemy wybrac jego dlugosc (argument "nyrs")
##domyslnie jest to 67% dlugosci serii (czyli 2/3 jej dlugosci - to klasyczne podejscie)
series.rwi <- detrend.series(y = series, y.name = "CAM011",
                             method="Spline")
#skrocmy okno, np. do 50 lat i porownajmy:
series.rwi <- detrend.series(y = series, y.name = "CAM011",
                             method="Spline",nyrs=50)
#zobaczmy sobie jeszcze na roznice pomiedzy "ModNegExp" a "ModHugershoff"
#skorzystamy z danych co021
data(co021)
series <- co021[, 4]
names(series) <- rownames(co021)
series.rwi <- detrend.series(y = series, y.name = names(co021)[4],
                             method=c("ModNegExp", "ModHugershoff"),
                             verbose = TRUE, return.info = TRUE, 
                             make.plot = TRUE)
series.rwi <- detrend.series(y = series, y.name = names(co021)[4],
                             method=c("ModNegExp"),
                             verbose = TRUE, return.info = TRUE, 
                             make.plot = TRUE)


