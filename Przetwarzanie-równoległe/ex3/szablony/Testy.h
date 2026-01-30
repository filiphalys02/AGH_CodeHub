#pragma once
#include<iostream>

template<typename T>
class Testowa;

template<typename T>
std::ostream& operator<<(std::ostream& strumien, Testowa<T> obj);

template<typename T>
class Testowa
{
private:
	//void obliczenia();
	int rozmiar;
	T* tab;
	//void wypelnij();
public:
	Testowa();
	Testowa(Testowa<T>& kopiowana);
	~Testowa();
	Testowa(int rr);
	void pokaz();
	T suma();
	int pokaz_rozmiar();
	void czysc();
	T& operator[](unsigned int index);
	Testowa<T>& operator=(Testowa<T>& kopiowany);
	using iterator = T*;
	iterator begin();
	iterator end();

friend
	std::ostream& operator<<<>(std::ostream& strumien, Testowa<T> obj);
};

template<typename T>
Testowa<T>::Testowa()
{
	int rr = 0;
	std::cout << "Podaj rozmiar tablicy: ";
	std::cin >> rr;
	if (rr > 0)
	{
		rozmiar = rr;
	}
	else
	{
		std::cout << "To nie jest prawidlowy rozmiar tablicy!!" << std::endl;
		std::cout << "zostanie stworzona tablica o rozmiarze 1" << std::endl;
		rozmiar = 1;
	}
	tab = new T[rozmiar];
	////wypelnij();
}
template<typename T>
Testowa<T>::Testowa(int rr)
{
	if (rr > 0)
	{
		rozmiar = rr;
	}
	else
	{
		std::cout << "To nie jest prawidlowy rozmiar tablicy!!" << std::endl;
		std::cout << "zostanie stworzona tablica o rozmiarze 1" << std::endl;
		rozmiar = 1;
	}
	tab = new T[rozmiar];
	//wypelnij();
}
template<typename T>
void Testowa<T>::pokaz()
{
	for (int i = 0; i < rozmiar; i++)
	{
		std::cout << tab[i] << "; ";
	}
	std::cout << std::endl;
}
template<typename T>
T Testowa<T>::suma()
{
	T sum = 0;
	for (int i = 0; i < rozmiar; i++)
		sum += tab[i];
	return sum;
}
template<typename T>
int Testowa<T>::pokaz_rozmiar()
{
	return rozmiar;
}
template<typename T>
Testowa<T>::~Testowa()
{
	delete[] tab;
}
template<typename T>
Testowa<T>::Testowa(Testowa<T>& kopiowana)
{
	this->rozmiar = kopiowana.rozmiar;
	this->tab = new T[rozmiar];
	for (int i = 0; i < rozmiar; i++)
	{
		this->tab[i] = kopiowana.tab[i];
	}
}
template<typename T>
Testowa<T>& Testowa<T>::operator=(Testowa<T>& kopiowany)
{
	delete[] tab;
	this->rozmiar = kopiowany.rozmiar;
	this->tab = new T[rozmiar];
	for (int i = 0; i < rozmiar; i++)
	{
		this->tab[i] = kopiowany.tab[i];
	}
	return *this;
}

template<typename T>
void Testowa<T>::czysc()
{
	for (int i = 0; i < rozmiar; i++)
		tab[i] = 0;
}
template<typename T>
T& Testowa<T>::operator[](unsigned int index)
{
	return tab[index];
}
template<typename T>
typename Testowa<T>::iterator Testowa<T>::begin() {
	return &tab[0];
}
template<typename T>
typename Testowa<T>::iterator Testowa<T>::end() {
	return &tab[rozmiar];
}


template<typename T>
std::ostream& operator<<(std::ostream& strumien, Testowa<T> obj)
{
	strumien << "tablica o rozmiarze " << obj.pokaz_rozmiar()<<":" << std::endl;
	for (int i = 0; i < obj.pokaz_rozmiar(); i++)
	{
		strumien << obj[i] << "; ";
	}
	strumien << std::endl;
	return strumien;
}