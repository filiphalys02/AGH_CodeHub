# Miasta blisko rzeki Wisła

bufor = r.buffer(distance = 20000)
m['Czy blisko Wisły'] = m.within(bufor[1])
ilosc = sum(m['Czy blisko Wisły'])
print('Jest {} miast znajdujących się do 20 kilometrów od rzeki Wisły.'.format(ilosc))

wis = {'Nazwa': ['Wisła'], 'geometry': [bufor[1]]}
wis2 = gpd.GeoDataFrame(wis, crs = 'EPSG:2180')

fig, axes = plt.subplots(1, 1, figsize = (8,8))
w.plot(color = 'green', ax = axes)
wis2.plot(ax = axes)
r.plot(ax = axes, color = 'blue')
m.plot(ax = axes, column = 'Czy blisko Wisły', markersize = 2, cmap = 'gray', legend = True)

# Województwa, przez które przepływa Odra

odra = r[r['Nazwa'] == 'Odra']
w['Czy przepływa Odra'] = w.intersects(odra.iat[0,1])
ilosc = np.sum(w['Czy przepływa Odra'])
print('Odra przepływa przez {} województw.'.format(ilosc))

fig, axes = plt.subplots(1, 1, figsize = (8,8))
w.plot(ax = axes, column = 'Czy przepływa Odra', cmap = 'spring', legend  = True)
m.plot(ax = axes, markersize = 2, color = 'black')
r.plot(ax = axes)
