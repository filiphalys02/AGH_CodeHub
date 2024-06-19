namespace Zaj_10_LINQ
{

    class Program
    {
        static void Main(string[] args)
        {
            List<Osoba> listaOsob = new List<Osoba>();

            Console.WriteLine("Dodawanie osób do kolekcji");
            Console.WriteLine("Wpisz 'koniec', aby zakończyć dodawanie");

            int id = 1;

            while (true)
            {
                Console.WriteLine("\nOsoba #" + id);

                Console.Write("Imię: ");
                string imie = Console.ReadLine();
                if (imie.ToLower() == "koniec") break;

                Console.Write("Nazwisko: ");
                string nazwisko = Console.ReadLine();

                Console.Write("Wiek: ");
                int wiek = Convert.ToInt32(Console.ReadLine());

                Console.Write("Numer telefonu: ");
                string nrTelefonu = Console.ReadLine();

                Console.Write("PESEL: ");
                string pesel = Console.ReadLine();

                Console.Write("Wykształcenie: ");
                string wyksztalcenie = Console.ReadLine();

                Osoba nowaOsoba = new Osoba(id, imie, nazwisko, wiek, nrTelefonu, pesel, wyksztalcenie);
                listaOsob.Add(nowaOsoba);

                id++;
            }

            Console.WriteLine("\nLista osób:");
            foreach (var osoba in listaOsob)
            {
                Console.WriteLine($"ID: {osoba.Id}, Imię: {osoba.Imie}, Nazwisko: {osoba.Nazwisko}, Wiek: {osoba.Wiek}, Telefon: {osoba.NrTelefonu}, PESEL: {osoba.Pesel}, Wykształcenie: {osoba.Wyksztalcenie}");
            }

            // 1. Zwraca wszystkie osobyo tym samym imieniu;
            Console.Write("\nPodaj imię osoby, aby znaleźć inne osoby o tym samym imieniu: ");
            string szukaneImie = Console.ReadLine();

            var osobyZTymSamymImieniem = listaOsob.Where(osoba => osoba.Imie.Equals(szukaneImie, StringComparison.OrdinalIgnoreCase));

            Console.WriteLine($"\nOsoby o imieniu '{szukaneImie}':");
            foreach (var osoba in osobyZTymSamymImieniem)
            {
                Console.WriteLine($"ID: {osoba.Id}, Imię: {osoba.Imie}, Nazwisko: {osoba.Nazwisko}, Wiek: {osoba.Wiek}, Telefon: {osoba.NrTelefonu}, PESEL: {osoba.Pesel}, Wykształcenie: {osoba.Wyksztalcenie}");
            }

            // 2. Zwraca wszystkie osobystarsze od wieku podanego przez użytkownika;
            Console.Write("\nPodaj minimalny wiek, aby znaleźć osoby starsze: ");
            int minimalnyWiek = Convert.ToInt32(Console.ReadLine());

            var starszeOsoby = listaOsob.Where(osoba => osoba.Wiek >= minimalnyWiek);

            Console.WriteLine($"\nOsoby starsze niż {minimalnyWiek} lat:");
            foreach (var osoba in starszeOsoby)
            {
                Console.WriteLine($"ID: {osoba.Id}, Imię: {osoba.Imie}, Nazwisko: {osoba.Nazwisko}, Wiek: {osoba.Wiek}, Telefon: {osoba.NrTelefonu}, PESEL: {osoba.Pesel}, Wykształcenie: {osoba.Wyksztalcenie}");
            }

            // 3. Zwraca kolekcję posortowaną po identyfikatorze;
            var posortowanaLista = listaOsob.OrderBy(osoba => osoba.Id);

            Console.WriteLine("\nPosortowana lista osób po identyfikatorze:");
            foreach (var osoba in posortowanaLista)
            {
                Console.WriteLine($"ID: {osoba.Id}, Imię: {osoba.Imie}, Nazwisko: {osoba.Nazwisko}, Wiek: {osoba.Wiek}, Telefon: {osoba.NrTelefonu}, PESEL: {osoba.Pesel}, Wykształcenie: {osoba.Wyksztalcenie}");
            }

            // 4. Zwraca kolekcję pogrupowaną po wykształceniu;
            var grupyWyksztalcenia = listaOsob.GroupBy(osoba => osoba.Wyksztalcenie);

            Console.WriteLine("\nPogrupowana lista osób po wykształceniu:");
            foreach (var grupa in grupyWyksztalcenia)
            {
                Console.WriteLine($"\nWykształcenie: {grupa.Key}");
                foreach (var osoba in grupa)
                {
                    Console.WriteLine($"ID: {osoba.Id}, Imię: {osoba.Imie}, Nazwisko: {osoba.Nazwisko}, Wiek: {osoba.Wiek}, Telefon: {osoba.NrTelefonu}, PESEL: {osoba.Pesel}, Wykształcenie: {osoba.Wyksztalcenie}");
                }
            }

            // 5. Wyświetl najstarszą osobę;
            var najstarszaOsoba = listaOsob.OrderByDescending(osoba => osoba.Wiek).FirstOrDefault();

            if (najstarszaOsoba != null)
            {
                Console.WriteLine("\nNajstarsza osoba:");
                Console.WriteLine($"ID: {najstarszaOsoba.Id}, Imię: {najstarszaOsoba.Imie}, Nazwisko: {najstarszaOsoba.Nazwisko}, Wiek: {najstarszaOsoba.Wiek}, Telefon: {najstarszaOsoba.NrTelefonu}, PESEL: {najstarszaOsoba.Pesel}, Wykształcenie: {najstarszaOsoba.Wyksztalcenie}");
            }
            else
            {
                Console.WriteLine("\nBrak osób w kolekcji.");
            }
        }
    }
}