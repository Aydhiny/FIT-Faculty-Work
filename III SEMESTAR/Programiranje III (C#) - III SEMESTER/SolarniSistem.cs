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
        
        // Lista planeta koje su u asocijaciji s ovom zvijezdom
        public List<Planeta> Planets { get; set; } 

        public Zvijezda(string name, double mass, int temp) : base(name, mass)
        {
            Temperature = temp;
            Planets = new List<Planeta>();
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
        public List<Mjesec> Mjeseci { get; set; }

        public Planeta(string name, double mass, double udaljenost) : base(name, mass)
        {
            UdaljenostOdSunca = udaljenost;
            Mjeseci = new List<Mjesec>();
        }
    }

    public class Mjesec : NebeskoTijelo
    {
        public double UdaljenostOdPlanete { get; set; }
        public Planeta ParentPlaneta { get; set; }

        public Mjesec(string name, double mass, double udaljenost) : base(name, mass)
        {
            UdaljenostOdPlanete = udaljenost;
        }
    }

    internal class SolarniSistem
    {
        static void Main(string[] args)
        {
            Zvijezda sunce = new Zvijezda("Sunce", 1.989e30, 5778);
            Planeta zemlja = new Planeta("Zemlja", 5.972e24, 1.496e8);
            Planeta mars = new Planeta("Mars", 6.39e23, 2.279e8);
            Asteroid as1 = new Asteroid("Asteroid", 4.54e21, true);
            Asteroid as2 = new Asteroid("Asteroid2", 6.44e29, false);
            Asteroid as3 = new Asteroid("Asteroid3", 4.99e30, false);

            // Dodao sam ovdje relationships izmedju klasa
            sunce.Planets.Add(zemlja);
            sunce.Planets.Add(mars);
            zemlja.Mjeseci.Add(new Mjesec("Luna", 7.35e22, 384400));
            zemlja.Mjeseci.Add(new Mjesec("Phobos", 1.08e16, 9377));

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
                    Console.WriteLine("Planete:");
                    if (star.Planets.Count == 0)
                        Console.WriteLine("nema");
                    foreach (var planet in star.Planets)
                    {
                        Console.WriteLine($" - {planet.Name}");
                    }
                }
                else if (body is Planeta planet)
                {
                    Console.WriteLine($"Udaljenost od sunca: {planet.UdaljenostOdSunca} km");
                    Console.WriteLine("Mjeseci:");
                    if (planet.Mjeseci.Count == 0)
                        Console.WriteLine("nema");
                    foreach (var moon in planet.Mjeseci)
                    {
                        Console.WriteLine($" - {moon.Name}");
                    }
                }
                else if (body is Asteroid asteroid)
                {
                    Console.WriteLine($"Luk:  {asteroid.hasRings}");
                }

                Console.WriteLine();
            }
        }
    }
}
