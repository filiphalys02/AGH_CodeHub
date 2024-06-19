def g_function(points, intervals):
    """
    Parameters
    -------
    points: GeoSeries
        Tablica zawierająca punkty zapisane jako obiekty shapely.geometry.point.Point.
    intervals: int
        Liczba dodatnia określająca na ile części ma zostać podzielony dystans do najdalszej odległosci do najbliższego sąsiada.
    Returns
    -------
    g: DataFrame
        Tablica zawierająca dwie kolumny:
        - "D" - zawierającą unikalne wartości odległości do najbliższego sąsiada uszeregowane od najmniejszej do największej wartości, dla których wyliczone zostały wartości funkcji G,
        - "G" - zawierającą wyliczone wartości funkcji G.
    """
   
    tabelka = pd.DataFrame()
    tabelka['Wsp X'] = points['geometry'].x
    tabelka['Wsp Y'] = points['geometry'].y
    
    x = pp.distance_statistics.g(tabelka, 100)
    
    g = pd.DataFrame()
    g['D'] = x[0]
    g['G'] = x[1]
    
    return g
  
punkty3_g = g_function(punkty3, 1)
punkty4_g = g_function(punkty4, 1)
punkty5_g = g_function(punkty5, 1)

pow_polski = polska.area
ilosc_punktow3 = len(punkty3)
ilosc_punktow4 = len(punkty4)
ilosc_punktow5 = len(punkty5)
int3 = ilosc_punktow3/pow_polski
int4 = ilosc_punktow4/pow_polski
int5 = ilosc_punktow5/pow_polski

punkty3_g_poisson = g_function_poisson(punkty3_g['D'], int3)
punkty4_g_poisson = g_function_poisson(punkty4_g['D'], int4)
punkty5_g_poisson = g_function_poisson(punkty5_g['D'], int5)

f, a = plt.subplots(2, 3, figsize = (15,8))

sns.lineplot(data = punkty3_g, x = 'D', y = 'G', ax = a[1,0], legend = True, label = 'funkcja G')
a[1, 0].set_title('Punkty 3')

sns.lineplot(data = punkty4_g, x = 'D', y = 'G', ax = a[1,1], legend = True, label = 'funkcja G')
a[1, 1].set_title('Punkty 4')

sns.lineplot(data = punkty5_g, x = 'D', y = 'G', ax = a[1,2], legend = True, label = 'funkcja G')
a[1, 2].set_title('Punkty 5')

sns.lineplot(data = punkty3_g_poisson, x = 'D', y = 'G', ax = a[1,0], legend = True, label = 'Funkcja G Poisson')
sns.lineplot(data = punkty4_g_poisson, x = 'D', y = 'G', ax = a[1,1], legend = True, label = 'Funkcja G Poisson')
sns.lineplot(data = punkty5_g_poisson, x = 'D', y = 'G', ax = a[1,2], legend = True, label = 'Funkcja G Poisson')

polska.plot(ax = a[0,0], color = 'pink')
punkty3.plot(ax = a[0,0], markersize = 2)
a[0,0].set_title('Rozkład punktów 3 na mapie Polski')

polska.plot(ax = a[0,1], color = 'pink')
punkty4.plot(ax = a[0,1], markersize = 2)
a[0,1].set_title('Rozkład punktów 4 na mapie Polski')

polska.plot(ax = a[0,2], color = 'pink')
punkty5.plot(ax = a[0,2], markersize = 2)
a[0,2].set_title('Rozkład punktów 5 na mapie Polski')
