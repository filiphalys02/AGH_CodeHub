#include <iostream>
#include "symulacja.h"

int main() {
    int N, iteracje;

    std::cout << "Podaj rozmiar siatki N: ";
    std::cin >> N;

    std::cout << "Podaj liczbe iteracji: ";
    std::cin >> iteracje;

    Symulacja sym(N, iteracje);
    sym.uruchom();
    sym.wyswietl_wyniki();
    sym.zapisz_mapy_do_csv();

    return 0;
}
