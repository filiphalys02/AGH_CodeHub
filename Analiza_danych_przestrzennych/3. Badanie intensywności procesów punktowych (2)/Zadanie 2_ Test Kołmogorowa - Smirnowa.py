def kolmogorow_smirnow_test(tested_points, theoretical_points, alpha, ddof):
    """
    Parameters
    -------
    tested_points: DataFrame
        Tablica zawierająca kolumnę ze współrzędnymi punktów testowanego rozkładu opisaną jako "X" lub "Y".

    theoretical_points: DataFrame
        Tablica zawierająca kolumnę ze współrzędnymi punktów toeretycznego rozkładu opisaną jako "X" lub "Y".
    
    alpha: float
        Wartość z zakresu [0,1] określająca poziom istotności.
    
    ddof: int
        Liczba nieujemna określająca liczbę nieznanych parametrów rozkładu.
    """

    D,d = sp.stats.kstest(tested_points,theoretical_points)
    #print(D)
    lmbda = D*np.sqrt(len(tested_points))
    #print(lmbda)
    lmbda_alpha = sp.stats.kstwobign.ppf(1-alpha)
    #print(lmbda_alpha)
    
    print('Test Kołmogorowa-Smirnowa dla współrzędnej {}'.format(tested_points.name))
    print('H0: Testowana zmienna ma przyjęty rozkład teoretyczny')
    print('H1: Testowana zmienna nie ma przyjętego rozkładu teoretycznego')
    print('lambda = {}'.format(lmbda))
    print('lambda_alpha = {}'.format(lmbda_alpha))
    
    if lmbda < lmbda_alpha:
        print('lmbda < lmbda_alpha')
        print('Wynik testu istotności nie daje podstaw do odrzucenia H0 na rzecz H1 na poziomie istotności alpha = {}'.format(alpha))
    else:
        print('lmbda >= lmbda_alpha')
        print('Odrzucenie H0 na rzecz H1 na poziomie istotności {}'.format(alpha))
        
dysx = np.linspace(0, 20,1000)
dysy = np.linspace(0, 10,1000)
kolmogorow_smirnow_test(punkty3['X'], dysx , 0.05, 0)
kolmogorow_smirnow_test(punkty3['Y'], dysy , 0.05, 0)
