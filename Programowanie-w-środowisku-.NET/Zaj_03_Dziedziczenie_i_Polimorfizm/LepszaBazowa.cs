using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zaj_3
{
    internal class LepszaBazowa : Bazowa
    {
        private string _opis;
        private int _pozycja;

        public LepszaBazowa()
        {
            _opis = "brak";
            _pozycja = 0;
        }

        public override void podaj_dane() 
        {
            base.podaj_dane();
            Console.Write("Podaj opis obiektu: ");
            _opis = Console.ReadLine();
            Console.Write("Podaj pozycje obiektu: ");
            _pozycja = int.Parse(Console.ReadLine());
        }
        public override void pokaz_dane()
        { 
            base.pokaz_dane();
            Console.WriteLine("Opis obiektu: " + _opis);
            Console.WriteLine("Pozycja obiektu to: " + _pozycja);
        }
    }
}
