namespace Zad1
{
    internal class Para<TKey, TValue>
    {
        public TKey Klucz { get; set; }
        public TValue Wartosc { get; set; }

        public Para(TKey klucz, TValue wartosc)
        {
            Klucz = klucz;
            Wartosc = wartosc;
        }
    }

    internal class Program
    {
        static void Main(string[] args)
        {
            // Tworzymy obiekt klasy Para z różnymi typami dla klucza i wartości
            Para<int, string> para1 = new Para<int, string>(1, "wartosc1");
            Para<string, double> para2 = new Para<string, double>("klucz2", 3.14);

            // Wyświetlamy wartości pól dla obu obiektów
            Console.WriteLine($"Para 1: Klucz = {para1.Klucz}, Wartość = {para1.Wartosc}");
            Console.WriteLine($"Para 2: Klucz = {para2.Klucz}, Wartość = {para2.Wartosc}");
        }
    }
}
