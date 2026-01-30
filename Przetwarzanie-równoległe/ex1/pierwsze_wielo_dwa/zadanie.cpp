#include"zadanie.h"
#include<iostream>

void Zadania::operator()()
{
	zadanie_pierwsze();
	zadanie_drugie();
}
void Zadania::zadanie_pierwsze()
{
	std::cout << "Jestem zadaniem pierwszym" << std::endl;
}
void Zadania::zadanie_drugie()
{
	std::cout << "Jestem zadaniem drugim" << std::endl;
}