punkty1 = gpd.read_file('points_1.zip')
punkty2 = gpd.read_file('points_2.zip')
punkty3 = gpd.read_file('points_3.zip')
punkty4 = gpd.read_file('points_4.zip')
punkty5 = gpd.read_file('points_5.zip')
powiaty = gpd.read_file('Powiaty.zip')

polska = powiaty.dissolve()

polska['Nazwa'] = polska['Nazwa'].replace(['powiat ropczycko-sędziszowski'], 'Polska')
polska
