using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace Zaj_13_Bazy
{
    class BazaDanych : DbContext
    {
        public DbSet<Osoba> osoby { get; set; }
        public DbSet<Adres> adresy { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlite("Data Source=osoby.db");
        }
    }
    public class ZapisBazy : IDisposable
    {
        private BazaDanych db = new BazaDanych();

        public ZapisBazy()
        {
            db.Database.EnsureCreated();
        }
        public void Dispose()
        {
            db.Dispose();
        }

        public int DodajOsobe(Osoba osoba)
        {
            if (db.osoby.ToArray().Any(o => o.Equals(osoba)))
            {
                return osoba.ID;
            }
            else
            {
                db.osoby.Add(osoba);
                db.SaveChanges();
                return osoba.ID;
            }
        }

        public Osoba[] OsobyKolekcja { get { return db.osoby.ToArray(); } }
    }
}
