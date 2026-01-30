//#include"Testy.h"
#include<iostream>

//template<typename T>
//Testowa<T>::Testowa()
//{
//	//int rr = 0;
//	//std::cout << "Podaj rozmiar tablicy: ";
//	//std::cin >> rr;
//	//if (rr > 0)
//	//{
//	//	rozmiar = rr;
//	//}
//	//else
//	//{
//	//	std::cout << "To nie jest prawidlowy rozmiar tablicy!!" << std::endl;
//	//	std::cout << "zostanie stworzona tablica o rozmiarze 1" << std::endl;
//	//	rozmiar = 1;
//	//}
//	//tab = new T[rozmiar];
//	////wypelnij();
//}
//template<typename T>
//Testowa<T>::Testowa(int rr)
//{
//	if (rr > 0)
//	{
//		rozmiar = rr;
//	}
//	else
//	{
//		std::cout << "To nie jest prawidlowy rozmiar tablicy!!" << std::endl;
//		std::cout << "zostanie stworzona tablica o rozmiarze 1" << std::endl;
//		rozmiar = 1;
//	}
//	tab = new T[rozmiar];
//	//wypelnij();
//}
//template<typename T>
//void Testowa<T>::pokaz()
//{
//	for (int i = 0; i < rozmiar; i++)
//	{
//		std::cout << tab[i] << "; ";
//	}
//	std::cout << std::endl;
//}
//template<typename T>
//T Testowa<T>::suma()
//{
//	T sum = 0;
//	for (int i = 0; i < rozmiar; i++)
//		sum += tab[i];
//	return sum;
//}
//template<typename T>
//int Testowa<T>::pokaz_rozmiar()
//{
//	return rozmiar;
//}
//template<typename T>
//Testowa<T>::~Testowa()
//{
//	delete[] tab;
//}
//template<typename T>
//Testowa<T>::Testowa(Testowa<T>& kopiowana)
//{
//	this->rozmiar = kopiowana.rozmiar;
//	this->tab = new T[rozmiar];
//	for (int i = 0; i < rozmiar; i++)
//	{
//		this->tab[i] = kopiowana.tab[i];
//	}
//}
//template<typename T>
//void Testowa<T>::czysc()
//{
//	for (int i = 0; i < rozmiar; i++)
//		tab[i] = 0;
//}
//template<typename T>
//T& Testowa<T>::operator[](unsigned int index)
//{
//	return tab[index];
//}