using System;

namespace ConsloleAPPI
{
    internal class Sum
    {
        private double first;
        private double second;
        private double result;

        public Sum()
        {
            first = 0;
            second = 0;
            result = 0;
        }

        public void download()
        {
            Console.WriteLine("Let's sum!");
            Console.Write("First number: ");
            first = double.Parse(Console.ReadLine());
            Console.Write("Second number: ");
            second = double.Parse(Console.ReadLine());
        }

        public void count()
        {
            result = first + second;
        }

        public void show()
        {
            download();
            count();
            Console.WriteLine("Result: " + result);
        }
    }
}