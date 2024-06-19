using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp72
{
    internal class Nowa
    {
        private int numer;
        private string nazwa;
        private short wiek;

        public Nowa()
        {
            numer = 0;
            nazwa = "brak";
            wiek = 0;
        }

        public int Numer // sposob 1
        {
            get { return numer; }
            set { numer = value; }
        }

        public string Nazwa // sposob 2
        { 
            get => nazwa;
            set => nazwa = value;
        }

        public short Wiek
        { 
            get => wiek;
            set => wiek = value;
        }

        public void wypelnij_obiekt()
        {
            Console.Write("Podaj numer identyfikacyjny: ");
            numer = int.Parse(Console.ReadLine());
            Console.Write("Podaj nazwe obiektu: ");
            nazwa = Console.ReadLine();
            Console.Write("Podaj wiek obiektu: ");
            wiek = short.Parse(Console.ReadLine());

            if (numer == 0) 
            { 
                
            } 
        }

    }
}
