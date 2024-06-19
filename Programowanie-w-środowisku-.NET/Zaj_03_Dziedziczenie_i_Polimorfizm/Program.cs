using System;
using Zaj_3;

namespace krotki_1 // Note: actual namespace depends on the project name.
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("wybierz opcje: ");
            Console.WriteLine("1 - Tworzenie krotek");
            Console.WriteLine("2 - Zwracanie wartosci przez argument metody");
            Console.WriteLine("3 - Dziedziczenie i polimorfizm");
            Console.WriteLine("4 - Kolekcje");

            int opcja = int.Parse(Console.ReadLine());

            if (opcja == 1)
            {
                // Tworzenie krotek 1 sposob
                (string, int) osoba_id;
                (string, string, int) osoba_cala_id;
                osoba_id = ("Piotr", 1);
                osoba_cala_id = ("Maria", "Mii", 1);
                osoba_id.Item1 = "Adam";
                Console.WriteLine(osoba_id);
                Console.WriteLine(osoba_cala_id.Item2);
                Console.WriteLine($"Imie:{osoba_id.Item1}, Id:{osoba_id.Item2}");

                // Tworzenie krotek 2 sposob
                (string imie, string nazwisko, int liczba) osoba_full;
                osoba_full.imie = "Alojzy";
                osoba_full.nazwisko = "Wuu";
                osoba_full.liczba = 2;
                char litera = 'a';
                string napis = "a";
            }
            else if (opcja == 2)
            {
                int wart1, wart2;
                Console.Write("Podaj liczbe calkowita: ");
                wart1 = int.Parse(Console.ReadLine());
                Console.Write("Podaj liczbe calkowita: ");
                wart2 = int.Parse(Console.ReadLine());

                pierwsza nowy = new pierwsza();
                nowy.pierwsza_f(wart1, wart2);
                nowy.pokaz();
                nowy.druga_f(out wart1, out wart2);
                Console.WriteLine("Kwadrat pierwszej wartosci: " + wart1);
                Console.WriteLine("Kwadrat drugiej wartosci: " + wart2);
            }
            else if (opcja == 3)
            {
                Bazowa nowy = new Bazowa();
                LepszaBazowa objLepsza = new LepszaBazowa();
                nowy.pokaz_dane();
                nowy.podaj_dane();
                nowy.pokaz_dane();
                Console.WriteLine();
                objLepsza.pokaz_dane();
                objLepsza.podaj_dane();
                objLepsza.pokaz_dane();
            }
            else if (opcja == 4)
            { 
                Kolekcje kolekcje = new Kolekcje();
                kolekcje.testList();
                kolekcje.testList2();
            }
            else
            {
                Console.WriteLine("ERROR, wybrales zla opcje");
            }
        }
    }
}
