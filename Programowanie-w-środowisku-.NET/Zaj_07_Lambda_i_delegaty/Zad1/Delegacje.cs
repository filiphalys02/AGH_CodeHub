using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zad1
{
    internal class Delegacje
    {
        public delegate int Del(int aa);
        
        private int oblicz_k(int arg)
        {
            return arg * arg;
        }
        public void uruchom()
        {
            int liczba;
            Del nowa = oblicz_k;
            Console.Write("Podaj wartość całkowitą: ");
            liczba = int.Parse(Console.ReadLine());
            int wynik = nowa(liczba);
            Console.WriteLine("Wynik działania delegata to: " + wynik);
            Console.WriteLine("A teraz użycie lambdy: ");
            Del druga;
            druga = (int aa) => aa + aa;
            wynik = druga(liczba);
            Console.WriteLine("Wynik działania delegata z lambdą to: " + wynik);

        }
    }
}
