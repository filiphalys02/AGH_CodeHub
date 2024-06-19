using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp72
{
    class Testy2
    {
        int[] tab;
        int rozmiar;
        public Testy2()
        {
            Console.Write("Podaj rozmiar tablicy: ");
            rozmiar = int.Parse(Console.ReadLine());
            if (rozmiar > 0)
            {
                tab = new int[rozmiar];
                for (int i = 0; i<tab.Length; i++)
                {
                    tab[i] = i + 2;
                }
            }
            else
            {
                tab = new int[1];
                tab[0] = 0;
            }
        }

        public Testy2(int rr)
        {
            if (rr > 0)
            {
                Random r = new Random();
                tab = new int[rr];
                for (int i = 0; i < tab.Length; i++)
                {
                    tab[i] = r.Next(100);
                }
            }
        }

        public void pokaz_tablice()
        {
            Console.WriteLine("Zawartość tablicy: ");
            foreach (var liczba in tab)
            {
                Console.Write(liczba + " ");
            }
        }

        public void sortuj()
        { 
            Array.Sort(tab);
        }

    }
}
