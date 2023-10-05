using System;
using System.Collections.Generic;

namespace SolarSystem
{
    public class NebeskoTijelo
    {
        public string Name { get; set; }
        public double Mass { get; set; }

        public NebeskoTijelo(string name, double mass)
        {
            Name = name;
            Mass = mass;
        }
    }

    public class Zvijezda : NebeskoTijelo
    {
        public int Temperature { get; set; }

        public Zvijezda(string name, double mass, int temp) : base(name, mass)
        {
            Temperature = temp;
        }
    }

    public class Asteroid : NebeskoTijelo
    {
        public bool hasRings { get; set; }

        public Asteroid(string name, double mass, bool Rings) : base(name, mass)
        {
            hasRings = Rings;
        }
    }

    public class Planeta : NebeskoTijelo
    {
        public double UdaljenostOdSunca { get; set; }

        public Planeta(string name, double mass, double udaljenost) : base(name, mass)
        {
            UdaljenostOdSunca = udaljenost;
        }
    }

    internal class SolarniSistem
    {
        static void Main(string[] args)
        {
            if (args is null)
            {
                throw new ArgumentNullException(nameof(args));
            }

            Zvijezda sunce = new Zvijezda("Sunce", 1.989e30, 5778);
            Planeta zemlja = new Planeta("Zemlja", 5.972e24, 1.496e8);
            Planeta mars = new Planeta("Mars", 6.39e23, 2.279e8);
            Asteroid as1 = new Asteroid("Asteroid", 4.54e21, true);
            Asteroid as2 = new Asteroid("Asteroid2", 6.44e29, false);
            Asteroid as3 = new Asteroid("Asteroid3", 4.99e30, false);

            List<NebeskoTijelo> solarSystem = new List<NebeskoTijelo>
            {
                sunce,
                zemlja,
                mars,
                as1,
                as2,
                as3
            };

            foreach (var body in solarSystem)
            {
                Console.WriteLine($"Naziv: {body.Name}");
                Console.WriteLine($"Masa: {body.Mass} kg");

                if (body is Zvijezda star)
                {
                    Console.WriteLine($"Temperatura: {star.Temperature} K");
                }
                else if (body is Planeta planet)
                {
                    Console.WriteLine($"Udaljenost od sunca: {planet.UdaljenostOdSunca} km");
                }
                else if(body is Asteroid asteroid) 
                {
                    Console.WriteLine($"Luk:  {asteroid.hasRings}");
                }

                Console.WriteLine();
            }
        }
    }
}