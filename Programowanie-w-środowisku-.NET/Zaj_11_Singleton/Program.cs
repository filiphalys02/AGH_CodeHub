using System;

namespace Zaj_11_Singleton
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Enter the number of elements:");
            int n = int.Parse(Console.ReadLine());

            Console.WriteLine("Enter the minimum value for random number generation:");
            int min = int.Parse(Console.ReadLine());

            Console.WriteLine("Enter the maximum value for random number generation:");
            int max = int.Parse(Console.ReadLine());

            Random rand = new Random();
            int[] numbers = new int[n];
            for (int i = 0; i < n; i++)
            {
                numbers[i] = rand.Next(min, max + 1);
            }

            SingletonList singletonList = SingletonList.Instance;

            Console.WriteLine("Generated numbers:");
            foreach (var num in numbers)
            {
                singletonList.Add(num);
                Console.Write(num + " ");
            }
            Console.WriteLine();

            SubsetCalculator subsetCalculator = new SubsetCalculator();
            List<int> oddSubset = subsetCalculator.GetOddSubset(numbers);

            Console.WriteLine("Odd subset:");
            foreach (var num in oddSubset)
            {
                Console.Write(num + " ");
            }
            Console.WriteLine();

            Console.WriteLine("Enter the threshold value for removing smaller elements:");
            int threshold = int.Parse(Console.ReadLine());
            singletonList.RemoveSmallerElements(threshold);

            singletonList.DisplayList();
        }
    }
}
