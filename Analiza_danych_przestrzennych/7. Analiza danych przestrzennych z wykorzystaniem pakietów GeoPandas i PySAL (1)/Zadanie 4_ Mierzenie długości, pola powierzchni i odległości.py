#Długość Wisły
wiselka = r[r['Nazwa'] == 'Wisła']
x = wiselka.length*0.001
print('Długość Wisły wynosi: {:.3f} kilometrów'.format(x[1]))

#Pola powierzchni województw
area = w.area*0.000001
wojewodztwa = w.assign(Pole = area)
powierzchnia_polski = wojewodztwa['Pole'].sum()
print('Powierzchnia Polski wynosi {:.6f} kilometrów kwadratowych'.format(powierzchnia_polski))

fig, axes = plt.subplots(1, 1, figsize = (8,8))
wojewodztwa.plot(column = 'Pole', legend = True, ax = axes)

#Odległość Poznania od Krakowa i innych polskich miast od Krakowa
m.index = range(964)
odleglosc = m.distance(m['geometry'].iloc[332])
m = m.assign( Odległość_od_Krakowa = odleglosc)

odleglosc_krk_od_poz_w_km = m.iloc[609]
odleglosc_krk_od_poz_w_km = odleglosc_krk_od_poz_w_km['Odległość_od_Krakowa']
print('Odległość Poznania od Krakowa w linii prostej wynosi: {:.3f} kilometrów'.format(odleglosc_krk_od_poz_w_km*0.001))

fig, axes = plt.subplots(1, 1, figsize = (8,8))
w.plot(facecolor = 'none', edgecolor = 'black', ax = axes)
m.plot(ax = axes, column = 'Odległość_od_Krakowa', legend = True, markersize = 2)
