#include "utils.h"

static std::random_device rd;
static std::mt19937 gen(rd());

double losuj_double(double min, double max) {
    std::uniform_real_distribution<> dist(min, max);
    return dist(gen);
}

int losuj_int(int min, int max) {
    std::uniform_int_distribution<> dist(min, max);
    return dist(gen);
}