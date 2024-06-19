def homogeneous_poisson_on_polygon(intensity, polygon):
    """
    Parameters
    -------
    intensity: float
        Liczba dodatnia określająca intensywność procesu punktowego.
    polygon: Polygon
        Obszar, na którym mają zostać wygenerowane punkty.
    
    Returns
    -------
    points: GeoDataFrame
        Tablica zawierająca kolumnę "geometry" ze współrzędnymi punktów w odwzorowaniu kartograficznym identycznym jak odwzorowanie zmiennej polygon.
    """
    
    punkty = polygon.bounds
    x_lim = [punkty[0], punkty[2]]
    y_lim = [punkty[1], punkty[3]]
    punkty2 = homogeneous_poisson_on_rectangle(intensity, x_lim, y_lim)
    geometria = gpd.GeoSeries.from_xy(punkty2['X'], punkty2['Y'])
    #geometria2 = gpd.GeoSeries.within(geometria, other)
    geometria2 = geometria.within(polygon)
    
    ssss = geometria[geometria2 == True]
    return ssss
  
inetsywnosc = 10**(-8)
mazowieckie = w[w['Nazwa'] == 'mazowieckie']
geometria_maz = mazowieckie['geometry']
x = geometria_maz[12]
type(geometria_maz[12])
points = homogeneous_poisson_on_polygon(inetsywnosc, x)
points

fig, axes = plt.subplots(1, 1, figsize = (8,8))
mazowieckie.boundary.plot(ax = axes, color = 'black')
points.plot(ax = axes)
