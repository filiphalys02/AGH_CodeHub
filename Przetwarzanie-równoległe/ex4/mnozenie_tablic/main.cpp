#include<iostream>
#include<vector>
#include<thread>

using namespace std;

void mnozenie_wektorow(vector<int>& pierwszy, vector<int>& drugi);
void mnozenie_tablic(vector<vector<int>>& pierwszy, vector<vector<int>>& drugi);
void wypelnij_wektor(vector<int>& wektor, int ini);
void pokaz_wektor(vector<int>& wektor);
void pokaz_tablice(vector<vector<int>>& tablica);
void wypelnij_tablice(vector<vector<int>>& tablica, int ini);
void mnozenie_macierzy(vector<vector<int>>& pierwszy, vector<vector<int>>& drugi, vector<vector<int>>& wynik);
void mnozenie_macierzy_wiersz(vector<vector<int>>& pierwszy, vector<vector<int>>& drugi, vector<vector<int>>& wynik, int wiersz);

int main()
{
	vector<int> wektor;
	vector<int> drugi_wektor;
	vector<vector<int>> tablica_pierwsza(5,vector<int>(5));
	vector<vector<int>> tablica_druga(5,vector<int>(5));
	vector<vector<int>> wynik(5, vector<int>(5));

	int wybor =0;
	int ini1 = 2;
	int ini2 = 5;
	do 
	{
		cout << "1 - mnozenie wektorow\n2 - mnozenie tablic\n3 - mnozenie macierzy\n4 - koniec\n";
		cin >> wybor;
		switch (wybor) {
		case 1:
			wypelnij_wektor(wektor, ini1);
			wypelnij_wektor(drugi_wektor, ini2);
			mnozenie_wektorow(wektor, drugi_wektor);
			break;
		case 2:
			wypelnij_tablice(tablica_pierwsza, ini2);
			wypelnij_tablice(tablica_druga, ini1);
			cout << "Tablica pierwsza:" << endl;
			pokaz_tablice(tablica_pierwsza);
			cout << "\nTablica druga:" << endl;
			pokaz_tablice(tablica_druga);
			mnozenie_tablic(tablica_pierwsza, tablica_druga);
			break;
		case 3:
			wypelnij_tablice(tablica_pierwsza, ini2);
			wypelnij_tablice(tablica_druga, ini1);
			cout << "Tablica pierwsza:" << endl;
			pokaz_tablice(tablica_pierwsza);
			cout << "\nTablica druga:" << endl;
			pokaz_tablice(tablica_druga);
			mnozenie_macierzy(tablica_pierwsza, tablica_druga, wynik);
			cout << "Wynik mnozenia macierzy:" << endl;
			pokaz_tablice(wynik);
			break;
		case 4:
			cout << "Koniec\n";
			break;
		default:
			cout << "Nie ma takiej opcji!!" << endl;
			break;
		}
	} while (wybor != 3);

}

void mnozenie_wektorow(vector<int>& pierwszy, vector<int>& drugi)
{
	vector<int> wynik;

	if (pierwszy.size() == drugi.size()) {
		for (int i = 0; i < pierwszy.size(); i++)
		{
			wynik.push_back(pierwszy[i] * drugi[i]);
		}
		for (int i = 0; i < pierwszy.size(); i++) {
			cout << wynik[i] << "; ";
		}
		cout << endl;
	}
	else
		cout << "Dlugosci wektorow roznia sie, nie mozna wykonac operacji!!" << endl;
}
void mnozenie_tablic(vector<vector<int>>& pierwszy, vector<vector<int>>& drugi)
{
	vector<vector<int>> wynik(pierwszy.size(), vector<int>(pierwszy[0].size()));

	for (int i = 0; i < pierwszy.size(); i++)
		for (int j = 0; j < pierwszy[i].size(); j++)
			wynik[i][j] = pierwszy[i][j] * drugi[i][j];
	
	pokaz_tablice(wynik);
}
void wypelnij_wektor(vector<int>& wektor, int ini)
{
	for (int i = 0; i < wektor.size(); i++)
	{
		wektor.push_back(ini + i);
	}
}
void wypelnij_tablice(vector<vector<int>>& tablica, int ini)
{
	for (int i = 0; i < tablica.size(); i++)
		for (int j = 0; j < tablica[i].size(); j++)
			tablica[i][j] = ini +j;
}
void pokaz_wektor(vector<int>& wektor)
{
	for (int i = 0; i < wektor.size(); i++)
		cout << wektor[i] << "; ";

	cout << endl;
}
void pokaz_tablice(vector<vector<int>>& tablica)
{
	for (int i = 0; i < tablica.size(); i++)
	{
		for (int j = 0; j < tablica[i].size(); j++)
			cout << tablica[i][j] << "; ";
		cout << endl;
	}
}
void mnozenie_macierzy(vector<vector<int>>& pierwszy, vector<vector<int>>& drugi, vector<vector<int>>& wynik)
{
	vector<thread> watki;
	int rozmiar = pierwszy.size();

	for (int i = 0; i < rozmiar; i++)
		watki.emplace_back(mnozenie_macierzy_wiersz, ref(pierwszy), ref(drugi),ref(wynik), i);

	for (auto& w : watki)
		w.join();
}
void mnozenie_macierzy_wiersz(vector<vector<int>>& pierwszy, vector<vector<int>>& drugi, vector<vector<int>>& wynik, int wiersz)
{
	int n = pierwszy.size();
	int m = drugi[0].size();
	int d = drugi.size();
	for (int j = 0; j < m; j++)
	{
		wynik[wiersz][j] = 0;
		for (int k = 0; k < drugi.size(); k++)
			wynik[wiersz][j] += pierwszy[wiersz][k] * drugi[k][j];
	}
}