using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zaj_3
{
    internal abstract class Figura
    {
        private int aa;
        public abstract int Wierzcholki { get; }
        public abstract int IleWierzcholkow();
    }
}
