namespace Program
{

    public class Predmet 
    {
        public int Id { get; set; }
        public string? Name { get; set; }
    }

    public class Student 
    {
        public List<Predmet> Predmeti { get; set; }

        public Student() 
        {
            Predmeti = new List<Predmet>();
        }
    
    }
    internal class Program
    {

        // CALL STACK SE MORA KORISTITI

        static void FunctionThree() 
        {
            Console.WriteLine("Function Three is called...");
            // throw new Exception("Barking at you");
        }
        static void FunctionTwo() 
        {
            Console.WriteLine("Function Two is called...");
            FunctionThree();
        }
        static void FunctionOne()
        {
            Console.WriteLine("Function One is called...");
            FunctionTwo();
        }


        static void Main(string[] args)
        {
            if (args is null)
            {
                throw new ArgumentNullException(nameof(args));
            }

            Student student = new();

            Predmet p = new Predmet();
            student.Predmeti.Add(p);
            for(int i = 0; i < student.Predmeti.Count; i++) 
            {
                Predmet temp = student.Predmeti[i];
                Console.WriteLine(temp.Name);
            }
            Console.WriteLine("Hello, World!");
            FunctionOne();
        }
    }
}
