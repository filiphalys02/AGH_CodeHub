#ifndef KOMORKA_H
#define KOMORKA_H

struct Komorka {
    double wysokosc;
    double woda;
    double przeplyw;
    double zagrozenie;
    double pojemnosc;

    Komorka(): 
        wysokosc(0), 
        woda(0), 
        przeplyw(0),
        zagrozenie(0), 
        pojemnosc(15.0) { }
};

#endif
