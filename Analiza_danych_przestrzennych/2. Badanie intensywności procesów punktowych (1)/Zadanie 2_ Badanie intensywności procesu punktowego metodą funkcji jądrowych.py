def intensity_on_kde(points, kernel_radius, grid, x_lim, y_lim):
    """
    Parameters
    -------
    points: DataFrame
        Tablica zawierająca dwie kolumny ze współrzędnymi punktów opisane jako "X" i "Y".
    grid: list
        Lista określająca liczbę punktów w poziomie i pionie, dla których wyliczane będą wartości intensywności.
        Przykład: [10, 10]
    kernel_radius: float
        Liczba dodatnia określająca promień funkcji jądrowej.
    x_lim: list
        Lista określająca zakres wartości współrzędnej X.
        Przykład: [0, 10]
    y_lim: list
        Lista określająca zakres wartości współrzędnej Y.
        Przykład: [0, 10]   

    Returns
    -------
    intensity_data: DataFrame
        Tablica zawierająca trzy kolumny - dwie ze współrzędnymi opisane jako "X" i "Y"
        oraz kolumnę z wartościami intensywności wyliczonymi dla tych współrzędnych opisaną jako "I".
    """
    os_x = np.linspace(x_lim[0], x_lim[1], grid[0])
    os_y = np.linspace(y_lim[0], y_lim[1], grid[1])
    x, y = np.meshgrid(os_x, os_y, indexing='ij')
    centrum_x = x.flatten()
    centrum_y = y.flatten()
    
    wsp_x = points["X"].to_numpy()
    wsp_y = points["Y"].to_numpy()
    dlug_x = len(wsp_x)
    dlug_y = len(wsp_y)
    
    intensity = np.array([])
    for i in range(len(centrum_x)):
        d = np.sqrt((wsp_x - centrum_x[i])**2+(wsp_y - centrum_y[i])**2)
        mask_d = np.ma.masked_greater_equal(d, kernel_radius)
        d2 = (3 / (np.pi * kernel_radius**2)) * ((1 - (mask_d**2) / (kernel_radius**2)))**2
        intens_kernel = d2.sum()
        intensity = np.append(intensity, intens_kernel)
    XY = {"X":centrum_x, "Y":centrum_y, "I":intensity}
    intensity_data = pd.DataFrame(data=XY)
    return(intensity_data)
  
intensity_hg_kde = intensity_on_kde(poisson, 1.5, [200, 100], [-10, 10], [-5, 5])
intensity_ug_kde = intensity_on_kde(poisson_nieregularny, 1.5, [200, 100], [-10, 10], [-5, 5])
intensity_m_kde = intensity_on_kde(materna, 1.5, [200, 100], [-10, 10], [-5, 5])
intensity_t_kde = intensity_on_kde(thomas, 1.5, [200, 100], [-10, 10], [-5, 5])

fig, axs = plt.subplots(2, 2, figsize = (20, 10))
wykres_kde_1 = axs[0, 0].tricontourf(intensity_hg_kde["X"], intensity_hg_kde["Y"], intensity_hg_kde["I"], levels = 100, cmap = "bone")
axs[0, 0].set_title("Intensywność procesu punktowego - rozkład jednorodny Poissona", size = 15)
axs[0, 0].set_xlim([-10, 10])
axs[0, 0].set_ylim([-5, 5])
sns.scatterplot(data = poisson, x = "X", y = "Y", marker = ".", s = 20, color = "orange", ax = axs[0, 0])
fig.colorbar(wykres_kde_1, ax = axs[0, 0])
wykres_kde_2 = axs[0, 1].tricontourf(intensity_ug_kde["X"], intensity_ug_kde["Y"], intensity_ug_kde["I"], levels = 100, cmap = "bone")
axs[0, 1].set_title("Intensywność procesu punktowego - rozkład niejednorodny Poissona", size = 15)
axs[0, 1].set_xlim([-10, 10])
axs[0, 1].set_ylim([-5, 5])
sns.scatterplot(data = poisson_nieregularny, x = "X", y = "Y", marker = ".", s = 20, color = "orange", ax = axs[0, 1])
fig.colorbar(wykres_kde_2, ax = axs[0, 1])
wykres_kde_3 = axs[1, 0].tricontourf(intensity_m_kde["X"], intensity_m_kde["Y"], intensity_m_kde["I"], levels = 100, cmap = "bone")
axs[1, 0].set_title("Intensywność procesu punktowego - rozkład Materna", size = 15)
axs[1, 0].set_xlim([-10, 10])
axs[1, 0].set_ylim([-5, 5])
sns.scatterplot(data = materna, x = "X", y = "Y", marker = ".", s = 20, color = "orange", ax = axs[1, 0])
fig.colorbar(wykres_kde_3, ax = axs[1, 0])
wykres_kde_4 = axs[1, 1].tricontourf(intensity_t_kde["X"], intensity_t_kde["Y"], intensity_t_kde["I"], levels = 100, cmap = "bone")
axs[1, 1].set_title("Intensywność procesu punktowego - rozkład Thomasa", size = 15)
axs[1, 1].set_xlim([-10, 10])
axs[1, 1].set_ylim([-5, 5])
sns.scatterplot(data = thomas, x = "X", y = "Y", marker = ".", s = 20, color = "orange", ax = axs[1, 1])
fig.colorbar(wykres_kde_4, ax = axs[1, 1])
plt.show()
