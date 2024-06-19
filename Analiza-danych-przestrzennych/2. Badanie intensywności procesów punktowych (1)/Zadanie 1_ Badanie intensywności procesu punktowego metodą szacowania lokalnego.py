def point_count_on_subregions(points, bins, x_lim, y_lim):
    """
    Parameters
    -------
    points: DataFrame
        Tablica zawierająca dwie kolumny ze współrzędnymi punktów opisane jako "X" i "Y".
    bins: list
        Lista określająca liczbę podobszarów w poziomie i pionie.
        Przykład: [10, 10]
    x_lim: list
        Lista określająca zakres wartości współrzędnej X.
        Przykład: [0, 10]
    y_lim: list
        Lista określająca zakres wartości współrzędnej Y.
        Przykład: [0, 10]   

    Returns
    -------
    bin_data: list
        Lista zawierająca trzy macierze:
        - 1D ze współrzędnymi krawędzi podobszarów na osi X,
        - 1D ze współrzędnymi krawędzi podobszarów na osi Y,
        - 2D z liczbą punków przypisanych do każdego z podobszarów.
        Na przykład: [array([0, 1, 2]), array([0, 1, 2]), array([[7, 2], [4, 5]])]
    """
    
    zliczenia = np.histogram2d(points['X'], points['Y'], bins, [[x_lim[0],x_lim[1]], [y_lim[0], y_lim[1]]])
    zliczenia2 = [zliczenia[0].T, zliczenia[1], zliczenia[2]]
    return zliczenia2

def intensity_on_subregions(points, bins, x_lim, y_lim):
    """
    Parameters
    -------
    points: DataFrame
        Tablica zawierająca dwie kolumny ze współrzędnymi punktów opisane jako "X" i "Y".
    bins: list
        Lista określająca liczbę podobszarów w poziomie i pionie.
        Przykład: [10, 10]
    x_lim: list
        Lista określająca zakres wartości współrzędnej X.
        Przykład: [0, 10]
    y_lim: list
        Lista określająca zakres wartości współrzędnej Y.
        Przykład: [0, 10]   

    Returns
    -------
    intensity_data: list
        Lista zawierająca trzy macierze:
        - 1D ze współrzędnymi krawędzi podobszarów na osi X,
        - 1D ze współrzędnymi krawędzi podobszarów na osi Y,
        - 2D z wartością intensywności przypisaną do każdego z podobszarów.
        Na przykład: [array([0, 1, 2]), array([0, 1, 2]), array([[9, 12], [13, 8]])]
    """

    wynik = point_count_on_subregions(points, bins, x_lim, y_lim)
    obx = wynik[1]
    oby = wynik[2]
    area = (obx[1]-obx[0])*(oby[1]-oby[0])
    wynik[0] = wynik[0]/area
    wynik_i = [wynik[0], wynik[1], np.transpose(wynik[2])]
    return wynik_i
  
HP = pd.read_csv('dane_tymczasowe_HP.csv')
M = pd.read_csv('dane_tymczasowe_M.csv')
T = pd.read_csv('dane_tymczasowe_T.csv')
UP = pd.read_csv('dane_tymczasowe_UP.csv')
HP_int = intensity_on_subregions(HP, [40,20], [-10,10], [-5,5])
M_int = intensity_on_subregions(M, [40,20], [-10,10], [-5,5])
UP_int = intensity_on_subregions(UP, [40,20], [-10,10], [-5,5])
T_int = intensity_on_subregions(T, [40,20], [-10,10], [-5,5])

fig, axes = plt.subplots(2,2, figsize = (21,10))
axes[0,0].pcolormesh(HP_int[1], HP_int[2], HP_int[0], cmap = 'plasma')
sns.scatterplot(HP, x = HP['X'], y = HP['Y'], color = 'white', ax = axes[0,0], size = 0.01)
axes[0,0].set_title('HP')
axes[0,1].pcolormesh(UP_int[1], UP_int[2], UP_int[0], cmap = 'plasma')
axes[0,1].set_title('UP')
axes[1,0].pcolormesh(M_int[1], M_int[2], M_int[0], cmap = 'plasma')
axes[1,0].set_title('M')
axes[1,1].pcolormesh(T_int[1], T_int[2], T_int[0], cmap = 'plasma')
axes[1,1].set_title('T')
