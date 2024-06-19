using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zaj_13_Bazy;

namespace Zaj_13_Bazy
{
    internal class TestyXml
    {
        public void ZapiszXml()
        {
            List<Osoba> listOsob = new List<Osoba>
            {
                new Osoba{ID=1, Imie="Martyna", Nazwisko = "Trala", Wiek =22, Wzrost = 178 },
                new Osoba{ID=2,Imie="Stefan", Nazwisko= "Grzmot", Wiek = 21, Wzrost = 165},
                new Osoba{ID=3,Imie = "Edward", Nazwisko= "Staw", Wiek=33, Wzrost = 177}
            };

            DoXml nowy = new DoXml();
            nowy.ZapiszPlik(listOsob, "D:/osoby_lista.xml");
        }

    }
}
