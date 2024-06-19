# Województwa
woj = gpd.read_file("Wojewodztwa.zip")
woj2 = woj[['JPT_NAZWA_','geometry']]
woj3 = woj2.rename(columns = {'JPT_NAZWA_':'Nazwa'})
w = gpd.GeoDataFrame(woj3)
w

# Miasta
mie = gpd.read_file("Miejscowosci.zip")
mie2 = mie.loc[mie['rodzaj'] == 'miasto']
mie3 = mie2[['nazwaGlown','geometry']]
mie4 = mie3.rename(columns = {'nazwaGlown':'Nazwa'})
m = gpd.GeoDataFrame(mie4)
m

# Rzeki
rze = gpd.read_file("Rzeki.zip")
rze2 = rze[['NAZ_RZEKI','geometry']]
rze3 = rze2.rename(columns = {'NAZ_RZEKI':'Nazwa'})
rze4 = gpd.GeoDataFrame(rze3)
r = rze4.loc[[0,1], :]
r
