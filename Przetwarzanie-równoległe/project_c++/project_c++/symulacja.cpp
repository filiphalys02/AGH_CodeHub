#include "symulacja.h"
#include "utils.h"
#include <iostream>
#include <algorithm>
#include <fstream>

Symulacja::Symulacja(int n, int it)
    : N(n), iteracje(it), poziom_sniegu(50.0),
    siatka(n, std::vector<Komorka>(n)),
    mutexy_wierszy(n),
    bariera(n)
{
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            siatka[i][j].wysokosc = losuj_double(0, 100);
            if (i < 2) siatka[i][j].woda = losuj_double(0, 3);
        }
    }
}

void Symulacja::przetwarzaj_wiersz(int i) {
    for (int it = 0; it < iteracje; it++) {

        for (int j = 0; j < N; j++) {

            Komorka& k = siatka[i][j];

            // Opady
            if (losuj_int(0, 100) < 5) { // 5% komórek               
                k.woda += losuj_double(0, 5);
            }

            // Topnienie śniegu
            if (k.wysokosc > poziom_sniegu) {
                k.woda += (k.wysokosc - poziom_sniegu) * 0.01;
            }

            // Szukanie najniższych sąsiadów
            double min_wys = k.wysokosc;
            std::vector<std::pair<int, int>> sasiedzi;

            for (int dx = -1; dx <= 1; dx++) {
                for (int dy = -1; dy <= 1; dy++) {
                    if (dx == 0 && dy == 0) continue;
                    int ni = i + dx;
                    int nj = j + dy;
                    if (ni >= 0 && ni < N && nj >= 0 && nj < N) {
                        if (siatka[ni][nj].wysokosc < min_wys) {
                            min_wys = siatka[ni][nj].wysokosc;
                            sasiedzi.clear();
                            sasiedzi.emplace_back(ni, nj);
                        }
                        else if (siatka[ni][nj].wysokosc == min_wys) {
                            sasiedzi.emplace_back(ni, nj);
                        }
                    }
                }
            }

            if (!sasiedzi.empty()) {
                double spadek = k.wysokosc - min_wys;
                double maks_przeplyw = k.woda * 0.3;   // max 30% wody na iterację
                double przeplyw = std::min(maks_przeplyw, k.woda * spadek * 0.05);
                double na_sasiada = przeplyw / sasiedzi.size();

                for (auto& [ni, nj] : sasiedzi) {
                    std::scoped_lock lock(mutexy_wierszy[ni]);
                    double wolne = siatka[ni][nj].pojemnosc - siatka[ni][nj].woda;
                    double rzeczywisty = std::min(na_sasiada, wolne);
                    siatka[ni][nj].woda += rzeczywisty;
                    k.woda -= rzeczywisty;
                }
            }

            // Zagrożenie powodziowe
            if (k.woda > k.pojemnosc) {
                k.zagrozenie = std::min(1.0,
                    (k.woda - k.pojemnosc) / k.pojemnosc);
            }
            else {
                k.zagrozenie = 0.0;
            }
            k.woda *= 0.99; // parowanie / infiltracja
        }

        bariera.arrive_and_wait();
    }
}

void Symulacja::uruchom() {
    std::vector<std::thread> watki;
    for (int i = 0; i < N; i++) {
        watki.emplace_back(&Symulacja::przetwarzaj_wiersz, this, i);
    }
    for (auto& t : watki) t.join();
}

void Symulacja::wyswietl_wyniki() {
    std::cout << "\nMapa wody:\n";
    for (auto& w : siatka) {
        for (auto& k : w)
            std::cout << k.woda << "\t";
        std::cout << "\n";
    }

    std::cout << "\nMapa zagrożenia:\n";
    for (auto& w : siatka) {
        for (auto& k : w)
            std::cout << k.zagrozenie << "\t";
        std::cout << "\n";
    }
}

void Symulacja::zapisz_mapy_do_csv() {

    std::ofstream plik_woda("woda.csv");
    std::ofstream plik_zagrozenie("zagrozenie.csv");

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            plik_woda << siatka[i][j].woda;
            plik_zagrozenie << siatka[i][j].zagrozenie;

            if (j < N - 1) {
                plik_woda << ",";
                plik_zagrozenie << ",";
            }
        }
        plik_woda << "\n";
        plik_zagrozenie << "\n";
    }

    plik_woda.close();
    plik_zagrozenie.close();
}

