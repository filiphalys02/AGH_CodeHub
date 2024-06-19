using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    internal class Kolejka_stos
    {
        private Queue<int> kolejka;
        private Stack<int> stos;
        private Queue<int> kolejka_pusta;
        int rozmiar;
        public Kolejka_stos() 
        {
            kolejka_pusta = new Queue<int>();
        }

        public void kolejka_ustalona() 
        {
            Console.Write("Podaj długość kolejki: ");
            rozmiar = int.Parse(Console.ReadLine());
            if (rozmiar > 0)
            {
                kolejka = new Queue<int>(rozmiar);
                for (int i = 0; i < rozmiar; i++) 
                { 
                    kolejka.Enqueue(i+1);
                }
            }
        }
        public void kolejka_dodaj()
        {
            bool czy_dodac = false;
            int dodaj;
            int i = 10;
            do
            {
                Console.WriteLine(" 1 - dodaj element do kolejki");
                Console.WriteLine(" 2 - koniec dodwania");
                dodaj = int.Parse(Console.ReadLine());
                if (dodaj == 1)
                {
                    kolejka_pusta.Enqueue(i);
                    czy_dodac = true;
                }
                else if (dodaj == 2)
                {
                    czy_dodac = false;
                }
                else
                {
                    Console.WriteLine("Nie ma takiej opcji");
                    czy_dodac = true;
                }
                i = i + 2;
            } 
            while( czy_dodac ); 
            {

            }
        }
        public void pokaz_kolejka_pusta()
        {
            Console.WriteLine("Kolejka: ");
            foreach (int element in kolejka_pusta)
            {
                Console.Write(element + " ");
            }
        }

        public void pokaz_kolejka()
        {
            foreach (int element in kolejka)
            {
                Console.Write(element + " ");
            }
        }
        public void kolejka_zdejmij()
        {
            //Console.WriteLine("Elementy usuwane z kolejki: ");
            Console.WriteLine("");
            string s= "Elementy usuwane z kolejki: ";
            for (int i = 0; i < rozmiar; ++i)
            {
                s += kolejka.Dequeue().ToString() + " ";
            }
            Console.WriteLine(s);
        }


        public void stos_ustalony()
        {
            Console.Write("Podaj długość stosu: ");
            rozmiar = int.Parse(Console.ReadLine());
            if (rozmiar > 0)
            {
                stos = new Stack<int>(rozmiar);
                for (int i = 0; i < rozmiar; i++)
                {
                    stos.Push(i + 1);
                }
            }
        }
        public void pokaz_stos()
        {
            foreach (int element in stos)
            {
                Console.Write(element + " ");
            }
        }
        public void stos_zdejmij()
        {
            Console.WriteLine("");
            string s = "Elementy usuwane ze stosu: ";
            for (int i = 0; i < rozmiar; ++i)
            {
                s += stos.Pop().ToString() + " ";
            }
            Console.Write(s);
        }
    }
}
