using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zaj_3
{
    internal class Bazowa
    {
        private string _nazwa;
        private string _kod;
        private int _id;

        public Bazowa() 
        {
            _nazwa = "brak";
            _kod = "brak";
            _id = 0;
        }
        public virtual void podaj_dane()
        {
            Console.Write("Podaj pelna nazwe obiektu: ");
            _nazwa = Console.ReadLine();
            Console.Write("Podaj kod obiektu: ");
            _kod = Console.ReadLine();
            Console.Write("Podaj identyfikator obiektu: ");
            _id = int.Parse(Console.ReadLine());
        }
        public virtual void pokaz_dane()
        {
            Console.WriteLine("Pelna nazwa obiektu to: " + _nazwa);
            Console.WriteLine("Kod obiektu to: " + _kod);
            Console.WriteLine("Identyfikator obiektu to: " + _id);

        }
    }
}
