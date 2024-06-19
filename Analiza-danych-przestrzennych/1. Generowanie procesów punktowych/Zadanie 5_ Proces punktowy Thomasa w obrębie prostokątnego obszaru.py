def thomas_on_rectangle(parent_intensity, mean_cluster_size, cluster_sigma, x_lim, y_lim):
    """
    Parameters
    -------
    parent_intensity: float
        Liczba dodatnia określająca intensywność macierzystego procesu punktowego.
    mean_cluster_size: float
        Liczba dodatnia określająca oczekiwaną liczebność generowanych klastrów.
    cluster_sigma: float
        Liczba dodatnia określająca odchylenie standardowe rozkładu wykorzystywanego w procesie generowania klastrów.
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
    
    x_lim_2 = [0,0]
    y_lim_2 = [0,0]
    x_lim_2[0] = x_lim[0]-4*cluster_sigma
    x_lim_2[1] = x_lim[1]+4*cluster_sigma
    y_lim_2[0] = y_lim[0]-4*cluster_sigma
    y_lim_2[1] = y_lim[1]+4*cluster_sigma
    punkty_poisson = homogeneous_poisson_on_rectangle(parent_intensity, x_lim_2, y_lim_2)
    
    koncowe_x = np.array([])
    koncowe_y = np.array([])
    
    for i in range(len(punkty_poisson)):
        randomowa_liczba_poissona = np.random.poisson(mean_cluster_size)
        losowy_x = np.random.normal(punkty_poisson['X'][i], cluster_sigma, randomowa_liczba_poissona)
        losowy_y = np.random.normal(punkty_poisson['Y'][i], cluster_sigma, randomowa_liczba_poissona)
        koncowe_x = np.append(koncowe_x, losowy_x)
        koncowe_y = np.append(koncowe_y, losowy_y)
    XY = {'X' : koncowe_x, 'Y': koncowe_y}
    punkty = pd.DataFrame(data = XY)
    for i in range(len(punkty)):
        if punkty['X'][i] < x_lim[0] or punkty['X'][i] > x_lim[1] or punkty['Y'][i] < y_lim[0] or punkty['Y'][i] > y_lim[1]:
            punkty.drop(i)
    return punkty
  
rozklad_t = thomas_on_rectangle(0.2, 30, 0.5, [0, 20], [0, 10])
rozklad_t

rozklad_t.plot.scatter(x="X", y="Y", s=4, c="darkblue", figsize=(20, 10))
plt.title("Proces punktowy Thomasa", fontsize=20)
plt.xlabel("Współrzędne X", fontsize=16)
plt.xlim(0, 20)
plt.ylim(0, 10)
plt.ylabel("Współrzędne Y", fontsize=16)
plt.show()
