using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zaj_11_Singleton
{
    internal class SingletonList
    {
        private static SingletonList instance;
        private List<int> list;

        private SingletonList()
        {
            list = new List<int>();
        }

        public static SingletonList Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new SingletonList();
                }
                return instance;
            }
        }

        public void Add(int value)
        {
            list.Add(value);
        }

        public void RemoveSmallerElements(int threshold)
        {
            list = list.Where(x => x >= threshold).ToList();
        }

        public void DisplayList()
        {
            Console.WriteLine("Elements in the list:");
            foreach (var item in list)
            {
                Console.Write(item + " ");
            }
            Console.WriteLine();
        }
    }
}
