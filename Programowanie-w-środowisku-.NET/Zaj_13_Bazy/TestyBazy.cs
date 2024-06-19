namespace Zaj_13_Bazy
{
    internal class TestyBazy
    {
        public void dodajOsoby(ZapisBazy db)
        {
            List<Osoba> osoby = new List<Osoba>();

            osoby.Add(new Osoba()
            {
                ID = 1,
                Imie = "Martyna",
                Nazwisko = "Trala",
                Wiek = 22,
                Wzrost = 178,
                Adres = new Adres()
                {
                    ID = 1,
                    Miasto = "Kraków",
                    Ulica = "Ładna",
                    NrDomu = 5,
                    NrMieszkania = 10,
                    Kod_pocztowy = "31-000"
                }
            });

            osoby.Add(new Osoba()
            {
                ID = 2,
                Imie = "Stefan",
                Nazwisko = "Grzmot",
                Wiek = 21,
                Wzrost = 165,
                Adres = new Adres()
                {
                    ID = 2,
                    Miasto = "Warszawa",
                    Ulica = "Brzydka",
                    NrDomu = 5,
                    NrMieszkania = 10,
                    Kod_pocztowy = "00-001"
                }
            });

            osoby.Add(new Osoba()
            {
                ID = 3,
                Imie = "Edward",
                Nazwisko = "Staw",
                Wiek = 33,
                Wzrost = 177,
                Adres = new Adres()
                {
                    ID = 3,
                    Miasto = "Kraków",
                    Ulica = "Rynek",
                    NrDomu = 1,
                    NrMieszkania = 1,
                    Kod_pocztowy = "50-001"
                }
            });

            foreach (var osoba in osoby)
            {
                db.DodajOsobe(osoba);
            }
        }

        public void pokazBaze(ZapisBazy db)
        {
            Console.WriteLine();
            Console.WriteLine("Podgląd bazy danych:");
            Console.WriteLine("Osoby:");
            foreach (Osoba osoba in db.OsobyKolekcja)
            {
                Console.WriteLine(osoba);
            }
        }
    }
}
