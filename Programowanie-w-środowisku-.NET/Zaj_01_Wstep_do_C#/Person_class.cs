using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsloleAPPI
{
    internal class Person
    {
        private string name;
        private string surname;
        private int age;

        public Person()
        {
            name = "nothing";
            surname = "nothing";
            age = 0;
        }
        public void Personal_data()
        {
            Console.WriteLine("Let's create Person!");
            Console.Write("Name: ");
            name = Console.ReadLine();
            Console.Write("Surname: ");
            surname = Console.ReadLine();
            Console.Write("Age: ");
            age = int.Parse(Console.ReadLine());
        }

        public void show()
        {
            Personal_data();
            Console.WriteLine(name + " " + surname + ", " + age + "yo");
        }
    }
}

