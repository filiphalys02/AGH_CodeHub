#include<iostream>
#include<string>
#include<vector>
#include<algorithm>
#include<thread>
#include"zadanie.h"

using namespace std;

class Test_funkcyjny {
private:
	int porownanie;
public:
	Test_funkcyjny(int p);
	Test_funkcyjny() { porownanie = 0; }
	bool operator()(int liczba);
};
void test_f()
{
	cout << "a to funkcja" << endl;
}
void szybka_funkcja()
{
	vector<int> wektor{ 2, 33,12,21,45,3,8,45,9,17 };
	int warunek;
	cout << "Podaj warunek: ";
	cin >> warunek;
	Test_funkcyjny nowy_funkcyjny(warunek);
	int zliczaj = 0;
	for (int i = 0; i < wektor.size(); i++)
	{
		if (nowy_funkcyjny(wektor[i]))
			zliczaj += 1;
	}
	cout << "Ilosc elementow wieksza od " << warunek << " wynosi: " << zliczaj << endl;
}
int main()
{
	Zadania noweZadania;
	thread t1(noweZadania);
	t1.join();
	thread t2(test_f);
	t2.join();
	thread t3(szybka_funkcja);
	t3.join();
	return 0;
}

Test_funkcyjny::Test_funkcyjny(int p)
{
	porownanie = p;
}
bool Test_funkcyjny::operator()(int liczba)
{
	return liczba > porownanie;
}