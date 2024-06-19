using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    internal class Slownik
    {
        private SortedList<int, string> slowniczek;
        private int nr;
        private int dodaj;
        private string nazwa;

        public Slownik() 
        { 
            slowniczek = new SortedList<int, string>();
        }

        public void wypelnijSlownik()
        {
            nr = 0;
            Console.WriteLine("Dodawanie elementow do slownika");
            do
            {
                Console.WriteLine("1 - dodaj kolejny element do slownika");
                Console.WriteLine("2 - koniec dodawania");
                dodaj = int.Parse(Console.ReadLine());
                if (dodaj == 1)
                {
                    Console.Write("Podaj nazwe obiektu: ");
                    nazwa = Console.ReadLine();
                    slowniczek.Add(nr, nazwa);
                    nr++;
                }
                else if (dodaj == 2)
                {
                    Console.WriteLine("Koniec Dodawania");
                }
                else
                {
                    Console.WriteLine("Nie ma takiej opcji");
                }
            }
            while (dodaj != 2);
        }

        public void pokazSlownik()
        {
            if (slowniczek.Count > 0)
            {
                foreach (var element in slowniczek)
                {
                    Console.WriteLine(element.Key + " " + element.Value);
                }
            }
            else
            {
                Console.WriteLine("Slowniczek jest pusty!");
            }
        }
    }
}
