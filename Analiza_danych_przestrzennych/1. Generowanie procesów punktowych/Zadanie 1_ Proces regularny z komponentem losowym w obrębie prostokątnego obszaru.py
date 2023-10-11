def regular_on_rectangle(grid, random_component, x_lim, y_lim):
    """
    Parameters
    -------
    grid: list
        Lista określająca liczbę punktów w pionie i poziomie.
        Przykład: [10, 10]
    random_component: float
        Liczba z przedziału [0, 1] określająca wielkość komponentu losowego.
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
    
    odlx = (x_lim[1]-x_lim[0])/grid[0]
    odly = (y_lim[1]-y_lim[0])/grid[1]
    x = np.linspace(x_lim[0]+0.5*odlx, x_lim[1]-0.5*odlx, grid[0])
    y = np.linspace(y_lim[0]+0.5*odly, y_lim[1]-0.5*odly, grid[1])
    
    x2, y2 = np.meshgrid(x,y)
    x3 = x2.flatten()
    y3 = y2.flatten()
    
    randx = np.random.uniform(-0.5*odlx, 0.5*odlx, size = grid[0]*grid[1])
    randy = np.random.uniform(-0.5*odly, 0.5*odly, size = grid[0]*grid[1])
    
    randx = randx * random_component
    randy = randy * random_component
    
    points = pd.DataFrame()
    points['X'] = (x3+randx)
    points['Y'] = (y3+randy)
    return points
    
fun = regular_on_rectangle(grid = [20,10], random_component = 0.5, x_lim = [0,20], y_lim = [0,10])
fun

fig, axes = plt.subplots(1,1, figsize = (20,10))
sns.scatterplot(fun, x = fun['X'], y = fun['Y'], ax = axes) 
plt.xlim(0,20)
plt.ylim(0,10)
