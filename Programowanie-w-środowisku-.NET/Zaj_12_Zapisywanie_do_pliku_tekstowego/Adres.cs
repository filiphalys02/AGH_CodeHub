using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zaj_12_Zapisywanie_do_pliku_tekstowego
{
    public class Adres
    {
        public string Miasto { get; set; }
        public string KodPocztowy { get; set; }
        public string NazwaUlicy { get; set; }
        public string NrDomu { get; set; }
        public string NrMieszkania { get; set; }

        public Adres(string miasto, string kodPocztowy, string nazwaUlicy, string nrDomu, string nrMieszkania)
        {
            Miasto = miasto;
            KodPocztowy = kodPocztowy;
            NazwaUlicy = nazwaUlicy;
            NrDomu = nrDomu;
            NrMieszkania = nrMieszkania;
        }
    }
}

