using System;

namespace DelegateExample
{
    public delegate bool delegat(int zmienna);

    internal class Program
    {
        static void Main(string[] args)
        {
            int rozmiar = 10;

            Random random = new Random();

            int[] tablica = new int[rozmiar];

            for (int i = 0; i < rozmiar; i++)
            {
                tablica[i] = random.Next(1, 101);
            }

            Console.WriteLine("Losowo wypełniona tablica: ");
            foreach (int number in tablica)
            {
                Console.Write(number + " ");
            }
            Console.WriteLine();


            Console.Write("Podaj wartość graniczną: ");
            int kryterium = int.Parse(Console.ReadLine());

            int iloscElementow = zlicz(tablica, x => x >= kryterium);
            Console.WriteLine($"Ilość elementów większych bądź równych niż {kryterium}: {iloscElementow}");
        }

        static int zlicz(int[] tablica, delegat delegat)
        {
            int ilosc = 0;
            foreach (var element in tablica)
            {
                if (delegat(element))
                {
                    ilosc++;
                }
            }
            return ilosc;
        }
    }
}
