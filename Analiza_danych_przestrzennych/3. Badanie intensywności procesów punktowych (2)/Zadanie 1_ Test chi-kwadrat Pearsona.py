def distribution_table(bin_counts):
    """
    Parameters
    -------
    bin_counts: array
        Macierz 2D z liczbą punków przypisanych do każdego z podobszarów.

    Returns
    -------
    table: DataFrame
        Tablica zawierająca 2 kolumny:
        - "K", która zawiera wszystkie wartości całkowite z zakresu od minimalnej do maksymalnej liczby zliczeń w obrębie podobszarów,
        - "N(K)", która zawiera liczby podobszarów, którym zostały przypisane poszczególne liczby punktów.
    """    

    bin_counts_min = int(np.min(bin_counts))
    bin_counts_max = int(np.max(bin_counts))
    
    k = np.linspace(bin_counts_min, bin_counts_max, bin_counts_max - bin_counts_min+1)
    nk = list()
    for i in k:
        nk.append(np.sum(bin_counts==i))
    table = pd.DataFrame()
    table['K'] = k
    table['N(K)'] = nk
    return table

def poisson_distribution_table(k, mu):
    """
    Parameters
    -------
    k: array
        Macierz 1D z wariantami badanej cechy, dla którym ma zostać wyliczone prawdopodobieństwo.
    mu: int
        Wartość oczekiwana rozkładu Poissona.

    Returns
    -------
    table: DataFrame
        Tablica zawierająca 2 kolumny:
        - "K", która zawiera warianty badanej cechy,
        - "P(K)", która zawiera wartości prawdopodobieństw rozkładu Poissona wyliczone dla wartości oczekiwanej mu
        oraz poszczególnych wariantów badanej cechy znormalizowane do sumy wartości równej 1.
    """  
    
    pk = list()
    for i in range(len(k)):
        pk.append(sp.stats.poisson.pmf(k[i], mu))
    pk = pk/sum(pk)
    table = pd.DataFrame()
    table['K'] = k
    table['P(K)'] = pk
    return table

def pearsons_chi2_test(tested_distribution, theoretical_distribution, alpha, ddof):
    """
    Parameters
    -------
    tested_distribution: DataFrame
        Tablica opisująca testowany rozkład i zawierająca 2 kolumny:
        - "K", która zawiera warianty badanej cechy, wartości muszą być identycznej jak kolumna "K" zmiennej lokalnej theoretical_distribution,
        - "N(K)", która zawiera liczebności poszczególnych wariantów badanej cechy.

    theoretical_distribution: DataFrame
        Tablica opisująca rozkład teoretyczny i zawierająca 2 kolumny:
        - "K", która zawiera warianty badanej cechy, wartości muszą być identycznej jak kolumna "K" zmiennej lokalnej tested_distribution,
        - "P(K)", która zawiera prawdopodobieństwa poszczególnych wariantów badanej cechy. Wartości z tej kolumny muszą sumować się do 1.
    
    alpha: float
        Wartość z zakresu [0,1] określająca poziom istotności.
    
    ddof: int
        Liczba nieujemna określająca liczbę nieznanych parametrów rozkładu.
    """
    
    n = sum(tested_distribution["N(K)"])
    chi_2 = ((tested_distribution["N(K)"]-n*theoretical_distribution["P(K)"])**2)/(n*theoretical_distribution["P(K)"])
    sum_chi_2 = sum(chi_2)
    chi_2a=sp.stats.chi2.ppf(1-alpha, len(tested_distribution["K"]-1-ddof))
    print('Test chi-kwadrat Pearsona')
    print('H0: Testowana zmienna ma przyjęty rozkład teoretyczny')
    print('H1: Testowana zmienna nie ma przyjętego rozkładu teoretycznego')
    print('chi2 = {}'.format(sum_chi_2))
    print('chi2_alpha = {}'.format(chi_2a))
    
    if sum_chi_2 < chi_2a:
        print('chi2 < chi2_alpha')
        print('Wynik testu istotności nie daje podstaw do odrzucenia H0 na rzecz H1 na poziomie istotności alpha = {}'.format(alpha))
    else:
        print('chi2 >= chi2_alpha')
        print('Odrzucenie H0 na rzecz H1 na poziomie istotności {}'.format(alpha))
        
a = np.histogram2d(punkty1['X'], punkty1['Y'], bins = [40,20], range=[[0,20], [0,10]])[0]
b = distribution_table(a)
c = poisson_distribution_table(b['K'], 5)
d = pearsons_chi2_test(b, c, 0.05, 0)

a = np.histogram2d(punkty2['X'], punkty2['Y'], bins = [40,20], range=[[0,20], [0,10]])[0]
b = distribution_table(a)
c = poisson_distribution_table(b['K'], 5)
d = pearsons_chi2_test(b, c, 0.05, 0)
