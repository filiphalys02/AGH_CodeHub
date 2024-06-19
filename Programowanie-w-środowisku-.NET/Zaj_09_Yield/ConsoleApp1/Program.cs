using System;

namespace ConsoleApp72
{
    internal class Program
    {
        static void Main(string[] args)
        {
            double[] numbers = {1, 2, 3, 2, 4, 3, 5, 6};

            Console.WriteLine("Tablica:");
            foreach (var num in numbers)
            {
                Console.Write(num + " ");
            }

            Console.WriteLine("\nTablica bez duplikatów:");
            foreach (var num in RemoveDuplicates(numbers))
            {
                Console.Write(num + " ");
            }
        }

        static IEnumerable<double> RemoveDuplicates(double[] numbers)
        {
            HashSet<double> uniqueNumbers = new HashSet<double>();

            foreach (var num in numbers)
            {
                if (uniqueNumbers.Add(num))
                {
                    yield return num;
                }
            }
        }
    }
}
