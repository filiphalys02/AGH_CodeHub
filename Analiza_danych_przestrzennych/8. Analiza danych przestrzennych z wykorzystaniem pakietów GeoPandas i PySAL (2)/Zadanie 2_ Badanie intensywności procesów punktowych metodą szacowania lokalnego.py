def point_count_on_subregions(points, subregions):
    """
    Parameters
    -------
    points: GeoSeries
        Tablica zawierająca punkty zapisane jako obiekty shapely.geometry.point.Point.
    subregions: GeoDataFrame
        Tablica zawierająca geometrie podobszarów zapisane jako obiekty shapely.geometry.polygon.Polygon.
    Returns
    -------
    counts: Series
        Seria Pandas zawierająca liczbą punktów przypisanych do każdego z podobszarów.
    """
    
    iteracja = len(subregions)
    lista = []
    for i in range(iteracja):
        true_or_false = points.within(subregions.iat[i,1])
        suma_prawd = sum(true_or_false)
        lista.append(suma_prawd)
    return lista
  
def intensity_on_subregions(points, subregions):
    """
    Parameters
    -------
    points: GeoSeries
        Tablica zawierająca punkty zapisane jako obiekty shapely.geometry.point.Point.
    subregions: GeoDataFrame
        Tablica zawierająca geometrie podobszarów zapisane jako obiekty shapely.geometry.polygon.Polygon.
    Returns
    -------
    intensity: Series
        Seria Pandas zawierająca intensywność przypisaną do każdego z podobszarów.
    """
    
    intensity = point_count_on_subregions(points, subregions) / subregions.area
    return intensity
  
powiaty = gpd.read_file('Powiaty.zip')

powiaty['Intensywność punktów 1'] = intensity_on_subregions(punkty1['geometry'], powiaty)
powiaty['Intensywność punktów 2'] = intensity_on_subregions(punkty2['geometry'], powiaty)

f, a = plt.subplots(1, 2, figsize = (25,10))
powiaty.plot(ax = a[0], column = 'Intensywność punktów 1', legend  = True)
a[0].set_title('Intensywność punktów 1 na mapie powiatów')
punkty1.plot(ax = a[0], color = 'pink', markersize = 4, legend  = True)

powiaty.plot(ax = a[1], column = 'Intensywność punktów 2', legend  = True)
a[1].set_title('Intensywność punktów 2 na mapie powiatów')
punkty2.plot(ax = a[1], color = 'pink', markersize = 4, legend  = True)

