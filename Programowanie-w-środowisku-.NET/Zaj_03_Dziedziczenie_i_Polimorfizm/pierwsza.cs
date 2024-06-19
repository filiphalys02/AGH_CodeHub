using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zaj_3
{
    internal class pierwsza
    {
        private int liczba;
        private string napis;
        private int wynik;

        public pierwsza()
        { 
            liczba = 0;
            napis = "brak";
            wynik = 0;
        }

        public void pierwsza_f(int pierwsza, int druga)
        {
            liczba = pierwsza;
            wynik = druga;
        }
        public void druga_f(out int pierwsza, out int druga) 
        {
            pierwsza = liczba * liczba;
            druga = wynik * wynik;
        }
        public void pokaz()
        {
            Console.WriteLine("Wartość zmiennej liczba: " + liczba);
            Console.WriteLine("Wartość zmiennej wynik: " + wynik);
        }

    }
}
