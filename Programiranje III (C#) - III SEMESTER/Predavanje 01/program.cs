using DLWMSConsoleApp.Predavanja;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
//include

namespace DLWMS.ConsoleApp 
{
    internal class Program 
    {
        static void Main(string[] args) 
        {
            // Encoder - objašnjenje korišteći foldere (Namespace ideja).    
            Encoder encoder;
            DLWMSConsoleApp.Helper.Encoder encoder2;
            // ------------------------------- //


            string prIII = "Programiranje III";
            Console.WriteLine("Hello world! Stoti put ;) " + prIII);
            
            // cout << " " << endl; 
            //WriteLine - statička metoda.

            for(int i = 0; i < args.Length; i++) 
            {
                // cout << " " << endl; 
                Console.WriteLine(args[i]);
            }
        }

        P1 p1;
    }

}
