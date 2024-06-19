using ConsoleApp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Projekt
{
    internal class Projekt
    {
        static void Main(string[] args)
        { 
            Osoba osoba = new Osoba();
            osoba.dodaj_osobe();
            osoba.pokaz_osobe();
        }
    }
}
