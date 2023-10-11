def homogeneous_poisson_on_rectangle(intensity, x_lim, y_lim):
    """
    Parameters
    -------
    intensity: float
        Liczba dodatnia określająca intensywność procesu punktowego.
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
    
    area = (x_lim[1]-x_lim[0])*(y_lim[1]-y_lim[0])
    n = area*intensity
    number = np.random.poisson(n)
    x = np.random.uniform(low = x_lim[0], high = x_lim[1], size = number)
    y = np.random.uniform(low = y_lim[0], high = y_lim[1], size = number)
    
    points = pd.DataFrame()
    points['X'] = x
    points['Y'] = y
    return points
  
fun2 = homogeneous_poisson_on_rectangle(intensity = 10, x_lim = [0,20], y_lim = [0,10])
fun2

fig, axes = plt.subplots(1,1,figsize=[20,10])
sns.scatterplot(fun2, ax = axes, x = 'X', y = 'Y')
plt.xlim(0,20) 
plt.ylim(0,10)
