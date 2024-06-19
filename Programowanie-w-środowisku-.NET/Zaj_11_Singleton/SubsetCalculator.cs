using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zaj_11_Singleton
{
    internal class SubsetCalculator
    {
        public List<int> GetOddSubset(int[] numbers)
        {
            List<int> oddSubset = new List<int>();
            foreach (var num in numbers)
            {
                if (num % 2 != 0)
                {
                    oddSubset.Add(num);
                }
            }
            return oddSubset;
        }
    }
}
