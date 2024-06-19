using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zaj_12_Zapisywanie_do_pliku_tekstowego
{
    public class Osoba
    {
        public int Id { get; set; }
        public string Imię { get; set; }
        public string Nazwisko { get; set; }
        public int Wiek { get; set; }
        public int Wzrost { get; set; }
        public string Pesel { get; set; }
        public Adres Adres { get; set; }

        public Osoba(int id, string imię, string nazwisko, int wiek, int wzrost, string pesel, Adres adres)
        {
            Id = id;
            Imię = imię;
            Nazwisko = nazwisko;
            Wiek = wiek;
            Wzrost = wzrost;
            Pesel = pesel;
            Adres = adres;
        }
    }
}
