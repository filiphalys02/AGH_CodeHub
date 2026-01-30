#include<iostream>
#include"Testy.h"

using namespace std;

int main()
{
	Testowa<int> nowa;
	for (int i = 0; i < nowa.pokaz_rozmiar(); i++)
	{
		nowa[i] = i + 3;
	}
	nowa.pokaz();
	cout << "Teraz za pomoca iteratora:" << endl;
	Testowa<int>::iterator it = nowa.begin();
	for (; it != nowa.end(); ++it)
		cout << *it << "; ";
	cout << endl;
	cout << "a teraz za pomoca petli:" << endl;
	/*for (int i = 0; i < nowa.pokaz_rozmiar(); i++)
		cout << nowa[i] << "; ";
	cout << endl;*/
	cout << nowa << endl;
	Testowa<int> drugi;
	drugi = nowa;
	cout << drugi << endl;
	return 0;
}