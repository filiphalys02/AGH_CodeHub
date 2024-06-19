using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace Zaj_13_Bazy
{
    public class DoPliku
    {
        private string nazwa;
        private string odczyt;
        private string path = "D:/drugi.txt";
        private FileStream fin;
        private FileStream fout;
        public void pobierzDane()
        {
            Console.WriteLine("Dane do zapisania w pliku tekstowym:");
            Console.Write("Podaj swoje imię i nazwisko: ");
            nazwa = Console.ReadLine();
        }
        public void zapiszDoPliku()
        {

            if (File.Exists(path))
            {
                fout = new FileStream(path, FileMode.Append, FileAccess.Write);
            }
            else
            {
                fout = new FileStream(path, FileMode.Create);
            }
            //fout = new FileStream(path, FileMode.Create);
            StreamWriter streamWriter = new StreamWriter(fout);
            streamWriter.WriteLine(nazwa);
            streamWriter.Close();
            fout.Close();
        }
        public void czytajZPliku()
        {
            Console.WriteLine("Odczyt danych z pliku");
            fin = new FileStream(path, FileMode.Open);
            StreamReader streamReader = new StreamReader(fin);

            while ((odczyt = streamReader.ReadLine()) != null)
            {
                Console.WriteLine(odczyt);
            }
        }
    }
}

