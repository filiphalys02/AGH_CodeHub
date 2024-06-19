# print('Odwzrorowanie kartograficzne województw: {}'.format(w.crs))
# print('Odwzrorowanie kartograficzne rzek: {}'.format(r.crs))
# print('odwzrorowanie kartograficzne miejscowości: {}'.format(m.crs))

w.to_crs(epsg=2180, inplace=True)
r.to_crs(epsg=2180, inplace=True)
