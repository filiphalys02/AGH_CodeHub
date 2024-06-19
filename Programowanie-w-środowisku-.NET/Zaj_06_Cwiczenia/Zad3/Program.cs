using System;

namespace Zad3
{
    public class TablicaGeneryczna<T>
    {
        private T[] tablica;

        // Konstruktor ustawiający rozmiar tablicy
        public TablicaGeneryczna(int rozmiar)
        {
            if (rozmiar <= 0)
            {
                throw new ArgumentException("Rozmiar tablicy musi być większy od zera.");
            }

            tablica = new T[rozmiar];
        }

        // Metoda do pobierania wartości z tablicy
        public T PobierzWartosc(int indeks)
        {
            if (indeks < 0 || indeks >= tablica.Length)
            {
                throw new IndexOutOfRangeException("Indeks wykracza poza zakres tablicy.");
            }

            return tablica[indeks];
        }

        // Metoda do ustawiania wartości w tablicy
        public void UstawWartosc(int indeks, T wartosc)
        {
            if (indeks < 0 || indeks >= tablica.Length)
            {
                throw new IndexOutOfRangeException("Indeks wykracza poza zakres tablicy.");
            }

            tablica[indeks] = wartosc;
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            // Testowanie typu TablicaGeneryczna<T>

            // Tablica liczb całkowitych
            TablicaGeneryczna<int> tablicaInt = new TablicaGeneryczna<int>(5);
            tablicaInt.UstawWartosc(0, 1);
            tablicaInt.UstawWartosc(1, 2);
            tablicaInt.UstawWartosc(2, 3);

            Console.WriteLine("Wartości z tablicy liczb całkowitych:");
            for (int i = 0; i < 3; i++)
            {
                Console.WriteLine(tablicaInt.PobierzWartosc(i));
            }

            // Tablica łańcuchów znaków
            TablicaGeneryczna<string> tablicaString = new TablicaGeneryczna<string>(3);
            tablicaString.UstawWartosc(0, "Hello");
            tablicaString.UstawWartosc(1, "World");
            tablicaString.UstawWartosc(2, "!");

            Console.WriteLine("\nWartości z tablicy łańcuchów znaków:");
            for (int i = 0; i < 3; i++)
            {
                Console.WriteLine(tablicaString.PobierzWartosc(i));
            }
        }
    }
}
