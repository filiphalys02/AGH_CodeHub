using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace Zad1
{
    internal class Osoba
    {
        private string nazwisko;
        private string imie;
        private string ulica;
        private int nr_ulicy;
        private string kod_pocztowy;
        private string miasto;


        public Osoba ()
        {
            Console.WriteLine("Brak parametrów");
        }
        public Osoba (string naz)
        {
            Console.WriteLine("Jeden parametr");
            Console.WriteLine("Nazwisko: " + naz);
        }
        public Osoba (string naz, string imi)
        {
            Console.WriteLine("Dwa parametry");
            Console.WriteLine("Nazwisko: " + naz);
            Console.WriteLine("Imie: " + imi);
        }
        public Osoba(string naz, string imi, string uli)
        {
            Console.WriteLine("Trzy parametry");
            Console.WriteLine("Nazwisko: " + naz);
            Console.WriteLine("Imie: " + imi);
            Console.WriteLine("Ulica: " + uli);
        }
        public Osoba(string naz, string imi, string uli, int nru)
        {
            Console.WriteLine("Cztery parametry");
            Console.WriteLine("Nazwisko: " + naz);
            Console.WriteLine("Imie: " + imi);
            Console.WriteLine("Ulica: " + uli);
            Console.WriteLine("Numer ulicy: " + nru);
        }
        public Osoba(string naz, string imi, string uli, int nru, string kod)
        {
            Console.WriteLine("Pięć parametrów");
            Console.WriteLine("Nazwisko: " + naz);
            Console.WriteLine("Imie: " + imi);
            Console.WriteLine("Ulica: " + uli);
            Console.WriteLine("Numer ulicy: " + nru);
            Console.WriteLine("Kod pocztowy: " + kod);
        }
        public Osoba(string naz, string imi, string uli, int nru, string kod, string mia)
        {
            Console.WriteLine("Sześć parametrów");
            Console.WriteLine("Nazwisko: " + naz);
            Console.WriteLine("Imie: " + imi);
            Console.WriteLine("Ulica: " + uli);
            Console.WriteLine("Numer ulicy: " + nru);
            Console.WriteLine("Kod pocztowy: " + kod);
            Console.WriteLine("Miasto: " + mia);
        }

        public string Nazwisko 
        {
            get { return nazwisko; }
            set { nazwisko = value; }
        }
        public string Imie 
        {
            get { return imie; }
            set { imie = value; }
        }
        public string Ulica 
        {
            get { return ulica; }
            set { ulica = value; }
        }
        public int Nr_ulicy
        {
            get { return nr_ulicy; }
            set { nr_ulicy = value; }
        }
        public string Kod_pocztowy
        {
            get { return kod_pocztowy; }
            set { kod_pocztowy = value; }
        }
        public string Miasto
        {
            get { return miasto; }
            set { miasto = value; }
        }
    }
}
