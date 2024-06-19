using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zaj_10_LINQ
{
    class Osoba
    {
        public int Id { get; set; }
        public string Imie { get; set; }
        public string Nazwisko { get; set; }
        public int Wiek { get; set; }
        public string NrTelefonu { get; set; }
        public string Pesel { get; set; }
        public string Wyksztalcenie { get; set; }

        public Osoba(int id, string imie, string nazwisko, int wiek, string nrTelefonu, string pesel, string wyksztalcenie)
        {
            Id = id;
            Imie = imie;
            Nazwisko = nazwisko;
            Wiek = wiek;
            NrTelefonu = nrTelefonu;
            Pesel = pesel;
            Wyksztalcenie = wyksztalcenie;
        }
    }
}
