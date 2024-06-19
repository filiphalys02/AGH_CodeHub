namespace ConsoleApp1
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int wybor;
            Console.WriteLine(" 1 - Kolejki i stosy");
            Console.WriteLine(" 2 - Slowniki");
            wybor = int.Parse(Console.ReadLine());

            if (wybor == 1)
            {
                Kolejka_stos nowa = new Kolejka_stos();
                //nowa.kolejka_ustalona();
                //nowa.pokaz_kolejka();
                //nowa.kolejka_zdejmij();

                //nowa.stos_ustalony();
                //nowa.pokaz_stos();
                //nowa.stos_zdejmij();

                nowa.kolejka_dodaj();
                nowa.pokaz_kolejka_pusta();
            }
            else if (wybor == 2) 
            {
                Slownik nowy = new Slownik();
                nowy.wypelnijSlownik();
                nowy.pokazSlownik();
            }
            else
            {
                Console.WriteLine("Nie ma takiej opcji!");
            }
        }
    }

}