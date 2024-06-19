using System;

namespace Zadanie
{
    public struct Ulamek
    {
        private int licznik;
        private int mianownik;

        // Właściwości do dostępu do zmiennych prywatnych
        public int Licznik
        {
            get { return licznik; }
            set { licznik = value; }
        }

        public int Mianownik
        {
            get { return mianownik; }
            set
            {
                if (value == 0)
                {
                    throw new ArgumentException("Mianownik nie może być zerem.");
                }
                mianownik = value;
            }
        }

        // Konstruktor inicjujący zmienne
        public Ulamek(int licznik, int mianownik)
        {
            if (mianownik == 0)
            {
                throw new ArgumentException("Mianownik nie może być zerem.");
            }

            this.licznik = licznik;
            this.mianownik = mianownik;
        }

        // Metoda upraszczająca ułamek
        public void Upraszcz()
        {
            int gcd = NajwiekszyWspolnyDzielnik(licznik, mianownik);
            licznik /= gcd;
            mianownik /= gcd;
        }

        private int NajwiekszyWspolnyDzielnik(int a, int b)
        {
            while (b != 0)
            {
                int temp = b;
                b = a % b;
                a = temp;
            }
            return a;
        }

        // Operator jednoargumentowy +
        public static Ulamek operator +(Ulamek u)
        {
            return u;
        }

        // Operator jednoargumentowy -
        public static Ulamek operator -(Ulamek u)
        {
            return new Ulamek(-u.Licznik, u.Mianownik);
        }

        // Operatory dwuargumentowe +, -, *, /
        public static Ulamek operator +(Ulamek u1, Ulamek u2)
        {
            int nowyLicznik = u1.Licznik * u2.Mianownik + u2.Licznik * u1.Mianownik;
            int nowyMianownik = u1.Mianownik * u2.Mianownik;
            return new Ulamek(nowyLicznik, nowyMianownik);
        }

        public static Ulamek operator -(Ulamek u1, Ulamek u2)
        {
            return u1 + (-u2);
        }

        public static Ulamek operator *(Ulamek u1, Ulamek u2)
        {
            int nowyLicznik = u1.Licznik * u2.Licznik;
            int nowyMianownik = u1.Mianownik * u2.Mianownik;
            return new Ulamek(nowyLicznik, nowyMianownik);
        }

        public static Ulamek operator /(Ulamek u1, Ulamek u2)
        {
            if (u2.Licznik == 0)
            {
                throw new DivideByZeroException("Nie można dzielić przez zero.");
            }
            return u1 * new Ulamek(u2.Mianownik, u2.Licznik);
        }

        // Operatory porównania ==, !=, >, <, >=, <=
        public static bool operator ==(Ulamek u1, Ulamek u2)
        {
            return (u1.Licznik * u2.Mianownik) == (u2.Licznik * u1.Mianownik);
        }

        public static bool operator !=(Ulamek u1, Ulamek u2)
        {
            return !(u1 == u2);
        }

        public static bool operator >(Ulamek u1, Ulamek u2)
        {
            return (u1.Licznik * u2.Mianownik) > (u2.Licznik * u1.Mianownik);
        }

        public static bool operator <(Ulamek u1, Ulamek u2)
        {
            return (u1.Licznik * u2.Mianownik) < (u2.Licznik * u1.Mianownik);
        }

        public static bool operator >=(Ulamek u1, Ulamek u2)
        {
            return (u1 > u2) || (u1 == u2);
        }

        public static bool operator <=(Ulamek u1, Ulamek u2)
        {
            return (u1 < u2) || (u1 == u2);
        }

        // Przesłonięcie metody Equals
        public override bool Equals(object obj)
        {
            if (!(obj is Ulamek))
                return false;

            Ulamek other = (Ulamek)obj;
            return this == other;
        }

        // Przesłonięcie metody GetHashCode
        public override int GetHashCode()
        {
            return licznik.GetHashCode() ^ mianownik.GetHashCode();
        }

        // Przesłonięcie metody ToString
        public override string ToString()
        {
            return $"{licznik}/{mianownik}";
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            // Testowanie struktury Ulamek

            Ulamek u1 = new Ulamek(1, 2);
            Ulamek u2 = new Ulamek(3, 4);

            Console.WriteLine("Ułamki:");
            Console.WriteLine($"u1: {u1}");
            Console.WriteLine($"u2: {u2}");

            Ulamek suma = u1 + u2;
            Console.WriteLine("\nSuma u1 i u2:");
            Console.WriteLine(suma);

            Ulamek roznica = u1 - u2;
            Console.WriteLine("\nRóżnica u1 i u2:");
            Console.WriteLine(roznica);

            Ulamek iloczyn = u1 * u2;
            Console.WriteLine("\nIloczyn u1 i u2:");
            Console.WriteLine(iloczyn);

            Ulamek iloraz = u1 / u2;
            Console.WriteLine("\nIloraz u1 i u2:");
            Console.WriteLine(iloraz);

            Console.WriteLine("\nPorównanie u1 i u2:");
            Console.WriteLine($"Czy u1 == u2? {u1 == u2}");
            Console.WriteLine($"Czy u1 != u2? {u1 != u2}");
            Console.WriteLine($"Czy u1 > u2? {u1 > u2}");
            Console.WriteLine($"Czy u1 < u2? {u1 < u2}");
            Console.WriteLine($"Czy u1 >= u2? {u1 >= u2}");
            Console.WriteLine($"Czy u1 <= u2? {u1 <= u2}");
        }
    }
}
