#include<iostream>
#include<thread>
#include<vector>
#include<algorithm>
#include<chrono>

using namespace std;

#define SIZE 100000000
#define NUM_THREADS 2
double tab[SIZE];
double druga[SIZE];
double sumy_cz[NUM_THREADS];

void sum_tab(int start, int end, int thread_num)
{
	double sum = 0;
	for (int i = start; i < end; i++)
	{
		sum += tab[i];
	}
	sumy_cz[thread_num] = sum;
}

void sumowanie_watki()
{
	vector<thread> watki;

	for (int i = 0; i < SIZE; i++)
		tab[i] = i + 1;

	auto start_czasu = chrono::high_resolution_clock::now();
	int podzial = SIZE / NUM_THREADS;
	for (int i = 0; i < NUM_THREADS; i++)
	{
		int start = i * podzial;
		int end = (i == NUM_THREADS - 1) ? SIZE : (i + 1) * podzial;
		watki.push_back(thread(sum_tab, start, end, i));
	}
	for (auto& wt : watki)
		wt.join();

	auto stop_czasu = chrono::high_resolution_clock::now();

	double suma = 0;
	for (int i = 0; i < NUM_THREADS; i++)
		suma += sumy_cz[i];

	cout << "suma elementow tablicy to: " << suma << endl;
	chrono::duration<double, std::milli> czas_wykoania = stop_czasu - start_czasu;
	cout << "Czas dzialania watkow w milisekundach: " << czas_wykoania.count() << endl;
}
void sumowanie_bez()
{
	for (int i = 0; i < SIZE; i++)
	{
		druga[i] = i + 1;
	}
	double suma_bez = 0;
	
	auto start_czasu_bez = chrono::high_resolution_clock::now();
	for (int i = 0; i < SIZE; i++)
	{
		suma_bez += druga[i];
	}
	auto stop_czasu_bez = chrono::high_resolution_clock::now();
	
	cout << "suma elementow tablicy to: " << suma_bez << endl;
	chrono::duration<double, std::milli> czas_wykoania_bez = stop_czasu_bez - start_czasu_bez;
	cout << "Czas dzialania bez watkow w milisekundach: " << czas_wykoania_bez.count() << endl;
}

int main()
{
	sumowanie_watki();
	cout << endl;
	sumowanie_bez();

	return 0;
}