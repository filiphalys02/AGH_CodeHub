using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp72
{
    internal class KlasyWew
    {
        private string nazwa;
        private int id;
        private Pomocnik pomocnik;
        public string Nazwa
        { 
            get => nazwa;
        }
        public int Id
        {
            get => id;
        }
        public KlasyWew()
        {
            nazwa = "brak";
            id = 0;
        }
        public void test_klasywew()
        { 
            pomocnik = new Pomocnik();
            pomocnik.wypelnij();
        }
        private class Pomocnik
        {
            private long pierwsza;
            private string klasa_obiektu;

            public void wypelnij()
            {
                Console.Write("Podaj numer ewidencyjny: ");
                pierwsza = long.Parse(Console.ReadLine());
                Console.Write("Podaj klase obiektu: ");
                klasa_obiektu = Console.ReadLine();
            }
            public Pomocnik() 
            {
                Console.WriteLine("Klasa wewnetrzna");
            }
        }
    }
}
