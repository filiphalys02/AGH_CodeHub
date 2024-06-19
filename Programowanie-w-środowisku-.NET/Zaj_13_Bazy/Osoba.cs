namespace Zaj_13_Bazy
{
    public class Osoba
    {
        private int id;
        private string imie;
        private string nazwisko;
        private int wiek;
        private float wzrost;
        private Adres adres;

        public int ID { get { return id; } set { id = value; } }
        public string Imie { get { return imie; } set { imie = value; } }
        public string Nazwisko { get { return nazwisko; } set { nazwisko = value; } }
        public int Wiek { get { return wiek; } set { wiek = value; } }
        public float Wzrost { get { return wzrost; } set { wzrost = value; } }
        public Adres Adres { get { return adres; } set { adres = value; } }

        public override string ToString()
        {
            return $"{id} {imie} {nazwisko} {wiek} {wzrost} {adres}";
        }

        public override bool Equals(object? obj)
        {
            if (!(obj is Osoba)) return false;
            Osoba nowa = obj as Osoba;
            return
                ID == nowa.ID && Imie.Equals(nowa.Imie) && Nazwisko.Equals(nowa.Nazwisko) && Wiek == nowa.Wiek && Wzrost == nowa.Wzrost && Adres.Equals(nowa.Adres);
        }
    }
}
