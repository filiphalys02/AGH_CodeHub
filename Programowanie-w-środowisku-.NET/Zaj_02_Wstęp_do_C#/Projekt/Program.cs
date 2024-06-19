using System;
using System.Security.Cryptography.X509Certificates;


namespace ConsoleApp
{
    internal class Osoba
    {
        private string imie;
        private string nazwisko;
        private int wiek;
        private long pesel;
        private Adres adres;

        public Osoba()
        {
            imie = "brak";
            nazwisko = "brak";
            wiek = 0;
            pesel = 0;
            adres = new Adres();
        }

        public void dodaj_osobe()
        {
            Console.Write("Podaj imie: ");
            imie = Console.ReadLine();
            Console.Write("Podaj nazwisko: ");
            nazwisko = Console.ReadLine(); 
            Console.Write("Podaj wiek: ");
            wiek = int.Parse(Console.ReadLine()); 
            Console.Write("Podaj pesel: ");
            pesel = long.Parse(Console.ReadLine());
            Console.Write("Podaj adres: ");
            imie = Console.ReadLine();
            adres.dodaj();
        }
        public void zmien_osobe()
        { 
            
        }
        public void pokaz_osobe()
        {
            Console.WriteLine("Pokazuje osobe");
            Console.WriteLine("IMIE: " + imie);
            Console.WriteLine("NAZWISKO: " + nazwisko);
            Console.WriteLine("WIEK: " + wiek);
            Console.WriteLine("PESEL: " + pesel);
        }
        private void dodaj_adres()
        { 
            
        }

        private class Adres
        {
            private string ulica;
            private short nr_domu;
            private short nr_mieszkania;
            private string kod_pocztowy;
            private string miejscowosc;

            public Adres()
            {
                ulica = "brak";
                nr_domu = 0;
                nr_mieszkania = 0;
                kod_pocztowy = "brak";
                miejscowosc = "brak";
            }
            public void dodaj()
            {
                Console.Write("Podaj nazwe ulicy: ");
                ulica = Console.ReadLine();
                Console.Write("Podaj numer domu: ");
                nr_domu = short.Parse(Console.ReadLine());
                Console.Write("Podaj numer mieszkania: ");
                nr_mieszkania = short.Parse(Console.ReadLine());
                Console.Write("Podaj kod pocztowy: ");
                kod_pocztowy = Console.ReadLine();
                Console.Write("Podaj miejscowosc: ");
                miejscowosc = Console.ReadLine();
            }
            public void pokaz()
            {
                Console.WriteLine("ULICA: " + ulica);
                Console.WriteLine("NUMER DOMU: : " + nr_domu);
                Console.WriteLine("NUMER MIESZKANIA: " + nr_mieszkania);
                Console.WriteLine("KOD_POCZTOWY: " + kod_pocztowy);
                Console.WriteLine("MIEJSCOWOSC: " + miejscowosc);
            }
        }

    }
}