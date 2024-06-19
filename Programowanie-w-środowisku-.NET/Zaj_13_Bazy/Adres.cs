using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zaj_13_Bazy
{
    public class Adres
    {
        private int id;
        private string miasto;
        private string ulica;
        private int nr_domu;
        private int nr_mieszkania;
        private string kod_pocztowy;

        public int ID { get { return id; } set { id = value; } }
        public string Miasto { get { return miasto; } set { miasto = value; } }
        public string Ulica { get { return ulica; } set { ulica = value; } }
        public int NrDomu { get { return nr_domu; } set { nr_domu = value; } }
        public int NrMieszkania { get { return nr_mieszkania; } set { nr_mieszkania = value; } }
        public string Kod_pocztowy
        {
            get { return kod_pocztowy; }
            set { kod_pocztowy = value; }
        }

        public override bool Equals(object? obj)
        {
            if (!(obj is Adres)) return false;
            Adres nowy = obj as Adres;
            return
                ID == nowy.ID && Miasto.Equals(nowy.Miasto) && Ulica.Equals(nowy.Ulica) && NrDomu == nowy.NrDomu && NrMieszkania == nowy.NrMieszkania && Kod_pocztowy.Equals(nowy.Kod_pocztowy);
        }

        public override string ToString()
        {
            return $"({ID}) {Miasto} {Ulica} {NrDomu} {NrMieszkania} {Kod_pocztowy}";
        }
    }
}
