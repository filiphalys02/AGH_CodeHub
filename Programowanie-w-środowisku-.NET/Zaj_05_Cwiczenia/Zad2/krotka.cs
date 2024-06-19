using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zad2
{
    internal class krotka
    {
        List<(string, string, int)> lista = new List<(string, string, int)>();


        public void wczytaj_dane()
        {
            Console.Write("Podaj Imie: ");
            string imie = Console.ReadLine();
            Console.Write("Podaj Nazwisko: ");
            string nazwisko = Console.ReadLine();
            Console.Write("Podaj Numer id: ");
            int id = int.Parse(Console.ReadLine());
            lista.Add((imie, nazwisko, id));
            decyzja();
        }
        private void decyzja()
        {
            Console.WriteLine("1 - Dodaj osobe");
            Console.WriteLine("2 - Zakoncz i wypisz");
            int decyzja = int.Parse(Console.ReadLine());
            if (decyzja == 1)
            {
                wczytaj_dane();
            }
            else if (decyzja == 2)
            {
                Console.WriteLine("Koniec");
            } 
            else
            {
                Console.WriteLine("ERROR");
            }
        }
        public void wypisz_dane()
        {
            Console.WriteLine("Zawartość listy: ");
            foreach (var osoba in lista)
            {
                Console.WriteLine($"Imię: {osoba.Item1}, Nazwisko: {osoba.Item2}, Numer ID: {osoba.Item3}");
            }
        }
    }
}
