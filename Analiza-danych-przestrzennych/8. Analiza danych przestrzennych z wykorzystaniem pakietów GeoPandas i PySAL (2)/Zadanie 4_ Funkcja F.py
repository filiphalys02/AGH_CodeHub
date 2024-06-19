def f_function(points, intervals, polygon):
    """
    Parameters
    -------
    points: GeoSeries
        Tablica zawierająca punkty zapisane jako obiekty shapely.geometry.point.Point.
    intervals: int
        Liczba dodatnia określająca na ile części ma zostać podzielony dystans do najdalszej odległosci do najbliższego sąsiada.
    polygon: Polygon
        Obszar, na którym mają zostać wygenerowane punkty procesu testowego.
        
    Returns
    -------
    f: DataFrame
        Tablica zawierająca dwie kolumny:
        - "D" - zawierającą unikalne wartości odległości do najbliższego sąsiada uszeregowane od najmniejszej do największej wartości, dla których wyliczone zostały wartości funkcji F,
        - "F" - zawierającą wyliczone wartości funkcji F.
    """
    
    tabelka = pd.DataFrame()
    tabelka['X'] = points['geometry'].x
    tabelka['Y'] = points['geometry'].y
    
    x = pp.distance_statistics.f(tabelka, support = intervals, hull = polygon)
    f = pd.DataFrame()
    f['D'] = x[0]
    f['F'] = x[1]
    return f
  
punkty3_f = f_function(punkty3, 100, polska['geometry'][0])
punkty4_f = f_function(punkty4, 100, polska['geometry'][0])
punkty5_f = f_function(punkty5, 100, polska['geometry'][0])

punkty3_f_poisson = f_function_poisson(punkty3_f['D'], int3)
punkty4_f_poisson = f_function_poisson(punkty4_f['D'], int4)
punkty5_f_poisson = f_function_poisson(punkty5_f['D'], int5)

f, a = plt.subplots(2,3, figsize = [15,8])

sns.lineplot(data = punkty3_f, ax = a[1,0], x = 'D', y = 'F', legend = True, label = 'Funkcja F')
a[1,0].set_title('Punkty 3')

sns.lineplot(data = punkty4_f, ax = a[1,1], x = 'D', y = 'F', legend = True, label = 'Funkcja F')
a[1,1].set_title('Punkty 4')

sns.lineplot(data = punkty5_f, ax = a[1,2], x = 'D', y = 'F', legend = True, label = 'Funkcja F')
a[1,2].set_title('Punkty 5')

sns.lineplot(data = punkty3_f_poisson, ax = a[1,0], x = 'D', y = 'F', legend = True, label = 'Funkcja F Poisson')
sns.lineplot(data = punkty4_f_poisson, ax = a[1,1], x = 'D', y = 'F', legend = True, label = 'Funkcja F Poisson')
sns.lineplot(data = punkty5_f_poisson, ax = a[1,2], x = 'D', y = 'F', legend = True, label = 'Funkcja F Poisson')

polska.plot(ax = a[0,0], color = 'pink')
punkty3.plot(ax = a[0,0], markersize = 2)
a[0,0].set_title('Rozkład punktów 3 na mapie Polski')

polska.plot(ax = a[0,1], color = 'pink')
punkty4.plot(ax = a[0,1], markersize = 2)
a[0,1].set_title('Rozkład punktów 4 na mapie Polski')

polska.plot(ax = a[0,2], color = 'pink')
punkty5.plot(ax = a[0,2], markersize = 2)
a[0,2].set_title('Rozkład punktów 5 na mapie Polski')
