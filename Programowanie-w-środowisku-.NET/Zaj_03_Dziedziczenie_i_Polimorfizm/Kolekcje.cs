using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace Zaj_3
{
    internal class Kolekcje
    {
        public Kolekcje() 
        { 
            
        }

        public void testList()
        {
            int rozmiar = 10;
            Random random = new Random();
            List<int> lista = new List<int>(rozmiar);
            
            for (int i = 0; i < rozmiar; i++)
            { 
                lista.Add(random.Next(100));
            }

            Console.WriteLine("Lista: ");

            foreach (int element in lista) 
            { 
                Console.Write(" " + element);
            }
            Console.WriteLine();
            
            lista.Sort();
            Console.WriteLine("Lista posortowana: ");

            foreach (int element in lista)
            {
                Console.Write(" " + element);
            }
            Console.WriteLine();
            //Console.WriteLine(lista[0]);
            //Console.WriteLine(lista[1]);
            //Console.WriteLine(lista[2]);
            Console.WriteLine();
            //Console.WriteLine(lista.ElementAt(0));
            //Console.WriteLine(lista.ElementAt(1));
            //Console.WriteLine(lista.ElementAt(2));
        }

        public void testList2()
        { 
            Random random = new Random();
            List<int> lista = new List<int>();
            Console.WriteLine("Dodawanie elementow do listy");
            int dodaj;
            do
            {
                Console.WriteLine("1 - dodaj kolejny element");
                Console.WriteLine("2 - koniec dodawania");
                dodaj = int.Parse(Console.ReadLine());
                if (dodaj == 1)
                {
                    lista.Add(random.Next(100));
                }
                else if (dodaj == 2)
                {
                    Console.WriteLine("Koniec dodawania");
                }
                else
                {
                    Console.WriteLine("Error");
                }
            } while ( dodaj != 2 );

            Console.WriteLine("Dodane elementy: ");
            foreach (int element in lista)
            {
                Console.Write(" " + element);
            }
        }
    }
}
