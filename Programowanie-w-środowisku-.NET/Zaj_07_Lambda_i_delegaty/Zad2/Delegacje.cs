using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zad2
{
    internal class Delegacje
    {
        public delegate int  Del1(int a);
        public delegate bool Del2(double a1, double a2);
        public delegate int  Del3(int a);


        public void uruchom()
        {
            Console.WriteLine("ZADANIE 1");
            int l;
            Console.Write("Podaj wartość: ");
            l = int.Parse(Console.ReadLine());
            Del1 nowa1 = (int a) =>  a + 1;
            int wynik1 = nowa1(l);
            Console.WriteLine("Zinkrementowana wartość zmiennej: " + wynik1);
            Console.WriteLine("");



            Console.WriteLine("ZADANIE 2");
            double liczba1;
            double liczba2;


            Console.Write("Podaj pierwszą wartość: ");
            liczba1 = double.Parse(Console.ReadLine());

            Console.Write("Podaj drugą wartość: ");
            liczba2 = double.Parse(Console.ReadLine());

            Del2 nowa2 = (double a1, double a2) =>
            {
                return a1 == a2;
            };

            bool wynik2 = nowa2(liczba1, liczba2);
            Console.WriteLine("Czy pierwsza wartość jest równa drugiej? Odpowiedź: " + wynik2);
            Console.WriteLine("");



            Console.WriteLine("ZADANIE 3");
            int liczba;
            Console.Write("Podaj wartość: ");
            liczba = int.Parse(Console.ReadLine());
            Del3 nowa3 = (int a) => a;
            int wynik3 = nowa3(liczba);
            Console.Write("Wartość zmiennej: " + wynik3);
        }
    }
}

