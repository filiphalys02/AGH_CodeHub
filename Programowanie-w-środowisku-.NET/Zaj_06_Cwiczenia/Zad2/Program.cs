using System;
using System.Collections.Generic;

namespace Zad2
{
    // Definicja generycznego typu Stos<T>
    public class Stos<T>
    {
        private List<T> elements = new List<T>();

        // Metoda do umieszczania elementu na szczycie stosu
        public void Push(T item)
        {
            elements.Add(item);
        }

        // Metoda do zdejmowania elementu ze szczytu stosu
        public T Pop()
        {
            if (elements.Count == 0)
            {
                throw new InvalidOperationException("Stos jest pusty.");
            }

            T item = elements[elements.Count - 1];
            elements.RemoveAt(elements.Count - 1);
            return item;
        }

        // Metoda do sprawdzenia, czy stos jest pusty
        public bool IsEmpty()
        {
            return elements.Count == 0;
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            // Testowanie typu Stos<T> dla różnych typów danych

            // Stos liczb całkowitych
            Stos<int> intStos = new Stos<int>();
            intStos.Push(1);
            intStos.Push(2);
            intStos.Push(3);

            Console.WriteLine("Zdejmowanie elementów ze stosu liczb całkowitych:");
            while (!intStos.IsEmpty())
            {
                Console.WriteLine(intStos.Pop());
            }

            // Stos łańcuchów znaków
            Stos<string> stringStos = new Stos<string>();
            stringStos.Push("Hello");
            stringStos.Push("World");
            stringStos.Push("!");

            Console.WriteLine("\nZdejmowanie elementów ze stosu łańcuchów znaków:");
            while (!stringStos.IsEmpty())
            {
                Console.WriteLine(stringStos.Pop());
            }
        }
    }
}
