using System;
using System.Collections.Generic;
using System.Linq;

namespace Zaj_12_Zapisywanie_do_pliku_tekstowego
{
    public static class ManipulatorDanychLINQ
    {
        public static void ZnajdzOsobyPoPeselu(List<Osoba> listaOsob, string pesel)
        {
            var znalezioneOsoby = from osoba in listaOsob
                                  where osoba.Pesel == pesel
                                  select osoba;

            if (znalezioneOsoby.Any())
            {
                Console.WriteLine("Znalezione osoby:");
                foreach (var osoba in znalezioneOsoby)
                {
                    Console.WriteLine($"Id: {osoba.Id}, Imię: {osoba.Imię}, Nazwisko: {osoba.Nazwisko}, PESEL: {osoba.Pesel}");
                }
            }
            else
            {
                Console.WriteLine("Brak osób o podanym numerze PESEL.");
            }
        }

        public static void ZnajdzOsobyPoNazwisku(List<Osoba> listaOsob, string nazwisko)
        {
            var znalezioneOsoby = from osoba in listaOsob
                                  where osoba.Nazwisko == nazwisko
                                  select osoba;

            if (znalezioneOsoby.Any())
            {
                Console.WriteLine("Znalezione osoby:");
                foreach (var osoba in znalezioneOsoby)
                {
                    Console.WriteLine($"Id: {osoba.Id}, Imię: {osoba.Imię}, Nazwisko: {osoba.Nazwisko}, PESEL: {osoba.Pesel}");
                }
            }
            else
            {
                Console.WriteLine("Brak osób o podanym nazwisku.");
            }
        }

        public static void ZnajdzOsobyPoMiescie(List<Osoba> listaOsob, string miasto)
        {
            var znalezioneOsoby = from osoba in listaOsob
                                  where osoba.Adres.Miasto == miasto
                                  select osoba;

            if (znalezioneOsoby.Any())
            {
                Console.WriteLine("Znalezione osoby:");
                foreach (var osoba in znalezioneOsoby)
                {
                    Console.WriteLine($"Id: {osoba.Id}, Imię: {osoba.Imię}, Nazwisko: {osoba.Nazwisko}, PESEL: {osoba.Pesel}");
                }
            }
            else
            {
                Console.WriteLine("Brak osób zamieszkujących podane miasto.");
            }
        }
    }
}
