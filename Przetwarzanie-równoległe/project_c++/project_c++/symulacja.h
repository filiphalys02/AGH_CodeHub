#ifndef SYMULACJA_H
#define SYMULACJA_H

#include <vector>
#include <thread>
#include <mutex>
#include <barrier>
#include "komorka.h"

class Symulacja {
private:
    int N;
    int iteracje;
    double poziom_sniegu;

    std::vector<std::vector<Komorka>> siatka;
    std::vector<std::mutex> mutexy_wierszy;
    std::barrier<> bariera;

    void przetwarzaj_wiersz(int wiersz);

public:
    Symulacja(int n, int it);
    void uruchom();
    void wyswietl_wyniki();
    void zapisz_mapy_do_csv();
};

#endif
