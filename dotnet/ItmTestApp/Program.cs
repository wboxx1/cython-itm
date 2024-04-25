using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ITS.Propagation;

namespace ItmTestApp
{
    class Program
    {
        static void Main(string[] args)
        {
            double h_tx__meter = 10.0;
            double h_rx__meter = 10.0;
            double[] pfl = {10.0, 100.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0};
            int climate = 5;
            double N_0 = 301;
            double f__mhz = 2000.0;
            int pol = 1;
            double epsilon = 15.0;
            double sigma = 0.008;
            double time = 0.9;
            double location = 0.95;
            double situation = 0.9;
            int mdvar = 12;
            double A__db;
            long warnings;

            int test_val = ITM.ITM_P2P_TLS(h_tx__meter, h_rx__meter, pfl, climate, N_0, f__mhz, pol, epsilon, sigma, mdvar, time, location, situation, out A__db, out warnings);

            Console.WriteLine(A__db);
            Console.WriteLine(warnings);
            Console.ReadLine();
        }
    }
}
