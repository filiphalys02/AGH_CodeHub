def materna_on_rectangle(parent_intensity, daughter_intensity, cluster_radius, x_lim, y_lim):
    """
    Parameters
    -------
    parent_intensity: float
        Liczba dodatnia określająca intensywność macierzystego procesu punktowego.
    daughter_intensity: float
        Liczba dodatnia określająca intensywność potomnego procesu punktowego.
    cluster_radius: float
        Liczba dodatnia określająca promień generowanych klastrów.
    x_lim: list
        Lista określająca zakres wartości współrzędnej X.
        Przykład: [0, 10]
    y_lim: list
        Lista określająca zakres wartości współrzędnej Y.
        Przykład: [0, 10]   
    
    Returns
    -------
    points: DataFrame
        Tablica zawierająca dwie kolumny ze współrzędnymi punktów opisane jako "X" i "Y".
    """
    
    x_lim_2 = [x_lim[0] - cluster_radius, x_lim[1] + cluster_radius]
    y_lim_2 = [y_lim[0] - cluster_radius, y_lim[1] + cluster_radius]
    punkty_parent = homogeneous_poisson_on_rectangle(parent_intensity, x_lim_2, y_lim_2)
    x = punkty_parent['X']
    y = punkty_parent['Y']
    koncowe_x = np.array([])
    koncowe_y = np.array([])
    
    for i in range(len(punkty_parent)):
        daughter_poisson = homogeneous_poisson_on_rectangle(daughter_intensity, [x[i]-cluster_radius, x[i]+cluster_radius], [y[i]-cluster_radius, y[i]+cluster_radius])
        punkty_X_daughter = daughter_poisson['X']
        punkty_Y_daughter = daughter_poisson['Y']
    
        for j in range(len(daughter_poisson)):
            if ((punkty_X_daughter[j]-x[i])**2 + (punkty_Y_daughter[j]-y[i])**2) > cluster_radius**2:
                punkty_Y_daughter = punkty_Y_daughter.drop(j)
                punkty_X_daughter = punkty_X_daughter.drop(j)
        koncowe_x = np.append(koncowe_x, punkty_X_daughter)
        koncowe_y = np.append(koncowe_y, punkty_Y_daughter)
    XY = {'X' : koncowe_x, 'Y' : koncowe_y}
    punkty = pd.DataFrame(data = XY)
    return punkty
  
rozklad_m = materna_on_rectangle(0.2, 20, 1, [0, 20], [0, 10])
rozklad_m

rozklad_m.plot.scatter(x="X", y="Y", s=4, c="darkblue", figsize=(20, 10))
plt.title("Proces punktowy Materna", fontsize=20)
plt.xlabel("Współrzędne X", fontsize=16)
plt.xlim(0, 20)
plt.ylim(0, 10)
plt.ylabel("Współrzędne Y", fontsize=16)
plt.show()
