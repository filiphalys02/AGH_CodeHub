using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using Zaj_13_Bazy;

namespace Zaj_13_Bazy
{
    internal class DoXml
    {
        public void ZapiszPlik(IEnumerable<Osoba> osoby, string path)
        {
            XDocument xml_dok = new XDocument(new XDeclaration("1.0", "utf-8", "yes"),
                new XElement("osoby", from osoba in osoby
                                      orderby osoba.Nazwisko, osoba.Imie
                                      select
                                      new XElement("osoba", new XAttribute("Id", osoba.ID.ToString()),
                                      new XElement("imie", osoba.Imie),
                                      new XElement("nazwisko", osoba.Nazwisko),
                                      new XElement("wiek", osoba.Wiek.ToString()),
                                      new XElement("wzrost", osoba.Wzrost.ToString()))));

            xml_dok.Save(path);
        }
    }
}

