def unhomogeneous_poisson_on_rectangle(intensity_function, x_lim, y_lim):
    """
    Parameters
    -------
    intensity_function: function
        Funkcja przyjmująca dwa argumenty (macierz 1D współrzędnych X i macierz 1D współrzędnych Y) i zwracająca macierz 1D
        z wartościami funkcji opisującej intensywność procesu dla tych współrzędnych.
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

    def g(x):
        return -funkcja(x[0], x[1])
    intensity=-sp.optimize.minimize(g, x0=[(x_lim[0]+x_lim[1])/2, (y_lim[0]+y_lim[1])/2], bounds=[x_lim, y_lim]).fun
    poisson = homogeneous_poisson_on_rectangle(intensity, x_lim, y_lim)
    dlugosc = len(poisson)
    
    for i in range(dlugosc):
        prawdopodobienstwo = 1 - (funkcja(poisson['X'][i], poisson['Y'][i])/intensity)
        if prawdopodobienstwo > np.random.uniform(0,1):
            poisson = poisson.drop(i)
    return poisson
 
def funkcja(x,y):
    return x

poisson = unhomogeneous_poisson_on_rectangle(funkcja, [0,20], [0,10])
poisson

fig, axes = plt.subplots(1,1,figsize= [20,10])
sns.scatterplot(poisson, x = poisson['X'], y = poisson['Y'])
