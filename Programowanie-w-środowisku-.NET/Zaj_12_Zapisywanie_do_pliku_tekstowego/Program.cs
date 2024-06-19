using System;
using System.Collections.Generic;

namespace Zaj_12_Zapisywanie_do_pliku_tekstowego
{
    internal class Program
    {
        static List<Osoba> listaOsob = new List<Osoba>();

        static void Main(string[] args)
        {
            WczytajDaneZPliku("C:\\C#\\Zaj_12_Zapisywanie_do_pliku_tekstowego\\dane.txt");

            WyswietlMenu();
        }

        static void DodajOsobe(Osoba osoba)
        {
            listaOsob.Add(osoba);
            Console.WriteLine("Dodano osobę: " + osoba.Imię + " " + osoba.Nazwisko);
        }

        static void UsunOsobe(int id)
        {
            Osoba osoba = listaOsob.Find(o => o.Id == id);
            if (osoba != null)
            {
                listaOsob.Remove(osoba);
                Console.WriteLine("Usunięto osobę: " + osoba.Imię + " " + osoba.Nazwisko);
            }
            else
            {
                Console.WriteLine("Osoba o podanym identyfikatorze nie istnieje.");
            }
        }

        static void WyswietlWszystkieOsoby()
        {
            Console.WriteLine("\nLista osób:");
            foreach (Osoba osoba in listaOsob)
            {
                Console.WriteLine($"Id: {osoba.Id}, Imię: {osoba.Imię}, Nazwisko: {osoba.Nazwisko}, Wiek: {osoba.Wiek}, Wzrost: {osoba.Wzrost}, PESEL: {osoba.Pesel}");
                Console.WriteLine($"Adres: {osoba.Adres.Miasto}, {osoba.Adres.KodPocztowy}, {osoba.Adres.NazwaUlicy} {osoba.Adres.NrDomu}/{osoba.Adres.NrMieszkania}\n");
            }
        }

        static void ZapiszDaneDoPliku(string nazwaPliku)
        {
            string fullPath = Path.GetFullPath(nazwaPliku);
            try
            {
                using (StreamWriter sw = new StreamWriter(fullPath))
                {
                    foreach (Osoba osoba in listaOsob)
                    {
                        sw.WriteLine($"{osoba.Id},{osoba.Imię},{osoba.Nazwisko},{osoba.Wiek},{osoba.Wzrost},{osoba.Pesel},{osoba.Adres.Miasto},{osoba.Adres.KodPocztowy},{osoba.Adres.NazwaUlicy},{osoba.Adres.NrDomu},{osoba.Adres.NrMieszkania}");
                    }
                }
                Console.WriteLine($"Dane zostały zapisane do pliku: {fullPath}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Wystąpił błąd podczas zapisywania danych do pliku {fullPath}:");
                Console.WriteLine(ex.Message);
            }
        }



        static void WczytajDaneZPliku(string nazwaPliku)
        {
            if (File.Exists(nazwaPliku))
            {
                listaOsob.Clear();
                string[] lines = File.ReadAllLines(nazwaPliku);
                foreach (string line in lines)
                {
                    string[] elements = line.Split(',');
                    int id = int.Parse(elements[0]);
                    string imie = elements[1];
                    string nazwisko = elements[2];
                    int wiek = int.Parse(elements[3]);
                    int wzrost = int.Parse(elements[4]);
                    string pesel = elements[5];
                    string miasto = elements[6];
                    string kodPocztowy = elements[7];
                    string nazwaUlicy = elements[8];
                    string nrDomu = elements[9];
                    string nrMieszkania = elements[10];
                    Adres adres = new Adres(miasto, kodPocztowy, nazwaUlicy, nrDomu, nrMieszkania);
                    Osoba osoba = new Osoba(id, imie, nazwisko, wiek, wzrost, pesel, adres);
                    listaOsob.Add(osoba);
                }
                Console.WriteLine("Dane zostały wczytane z pliku.");
            }
            else
            {
                Console.WriteLine("Plik danych nie istnieje.");
            }
        }


        static void ManipulujDanymiLINQ()
        {
            Console.WriteLine("Podaj kryterium wyszukiwania (PESEL, nazwisko, miasto):");
            string kryterium = Console.ReadLine();

            switch (kryterium.ToLower())
            {
                case "pesel":
                    Console.WriteLine("Podaj numer PESEL:");
                    string pesel = Console.ReadLine();
                    ManipulatorDanychLINQ.ZnajdzOsobyPoPeselu(listaOsob, pesel);
                    break;
                case "nazwisko":
                    Console.WriteLine("Podaj nazwisko:");
                    string nazwisko = Console.ReadLine();
                    ManipulatorDanychLINQ.ZnajdzOsobyPoNazwisku(listaOsob, nazwisko);
                    break;
                case "miasto":
                    Console.WriteLine("Podaj miasto:");
                    string miasto = Console.ReadLine();
                    ManipulatorDanychLINQ.ZnajdzOsobyPoMiescie(listaOsob, miasto);
                    break;
                default:
                    Console.WriteLine("Niepoprawne kryterium wyszukiwania.");
                    break;
            }
        }


        static void WyswietlMenu()
        {
            Console.WriteLine("Wybierz opcję:");
            Console.WriteLine("1. Dodaj osobę");
            Console.WriteLine("2. Usuń osobę");
            Console.WriteLine("3. Wyświetl wszystkie osoby");
            Console.WriteLine("4. Zapisz dane do pliku");
            Console.WriteLine("5. Wczytaj dane z pliku");
            Console.WriteLine("6. Manipuluj danymi za pomocą LINQ");
            Console.WriteLine("7. Wyjście");

            int opcja = int.Parse(Console.ReadLine());

            switch (opcja)
            {
                case 1:
                    Console.WriteLine("Podaj imię:");
                    string imie = Console.ReadLine();
                    Console.WriteLine("Podaj nazwisko:");
                    string nazwisko = Console.ReadLine();
                    Console.WriteLine("Podaj wiek:");
                    int wiek = int.Parse(Console.ReadLine());
                    Console.WriteLine("Podaj wzrost:");
                    int wzrost = int.Parse(Console.ReadLine());
                    Console.WriteLine("Podaj PESEL:");
                    string pesel = Console.ReadLine();
                    Console.WriteLine("Podaj miasto:");
                    string miasto = Console.ReadLine();
                    Console.WriteLine("Podaj kod pocztowy:");
                    string kodPocztowy = Console.ReadLine();
                    Console.WriteLine("Podaj nazwę ulicy:");
                    string nazwaUlicy = Console.ReadLine();
                    Console.WriteLine("Podaj numer domu:");
                    string nrDomu = Console.ReadLine();
                    Console.WriteLine("Podaj numer mieszkania:");
                    string nrMieszkania = Console.ReadLine();

                    Adres adres = new Adres(miasto, kodPocztowy, nazwaUlicy, nrDomu, nrMieszkania);
                    Osoba nowaOsoba = new Osoba(listaOsob.Count + 1, imie, nazwisko, wiek, wzrost, pesel, adres);

                    DodajOsobe(nowaOsoba);
                    break;
                case 2:
                    Console.WriteLine("Podaj ID osoby do usunięcia:");
                    int idToDelete = int.Parse(Console.ReadLine());
                    UsunOsobe(idToDelete);
                    break;
                case 3:
                    WyswietlWszystkieOsoby();
                    break;
                case 4:
                    ZapiszDaneDoPliku("C:\\C#\\Zaj_12_Zapisywanie_do_pliku_tekstowego\\dane.txt");
                    break;
                case 5:
                    WczytajDaneZPliku("C:\\C#\\Zaj_12_Zapisywanie_do_pliku_tekstowego\\dane.txt");
                    break;
                case 6:
                    ManipulujDanymiLINQ();
                    break;
                case 7:
                    Environment.Exit(0);
                    break;
                default:
                    Console.WriteLine("Niepoprawna opcja.");
                    break;
            }

            WyswietlMenu();
        }
    }
}
