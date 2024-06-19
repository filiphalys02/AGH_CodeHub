namespace Zaj_13_Bazy
{
    internal class Program
    {
        static void Main(string[] args)
        {
            string dbName = "osoby.db";
            if (File.Exists(dbName))
            {
                File.Delete(dbName);
            }
            ZapisBazy bazaDanych = new ZapisBazy();
            Console.WriteLine("Dodanie rekordów do bazy danych:");
            TestyBazy nowa = new TestyBazy();
            nowa.dodajOsoby(bazaDanych);
            nowa.pokazBaze(bazaDanych);
        }
    }
}
