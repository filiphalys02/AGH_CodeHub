using System;
namespace ConsloleAPPI
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            Console.WriteLine("Click 1 - If you want to count sum");
            Console.WriteLine("Click 2 - If you want to create person");
            int funcionallity = int.Parse(Console.ReadLine());

            if (funcionallity == 1)
            {
                Sum obj = new Sum();
                obj.show();
            }
            else if (funcionallity == 2)
            {
                Person obj = new Person();
                obj.show();
            }
            else
            {
                Console.WriteLine("You have to click 1 or 2!");
            }
        }
    }
}


