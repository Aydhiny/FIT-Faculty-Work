using FIT_Api_Examples.Data;
using System.ComponentModel.DataAnnotations.Schema;
using System;

namespace FIT_Api_Examples.Modul2.ViewModels
{
    public class DodajUpisVM
    {
        public DateTime DatumUpisa { get; set; }
        public int GodinaStudija { get; set; }
        public float CijenaSkolarine { get; set; }
        public bool Obnova { get; set; }
        public int akademskaGodinaId { get; set; }
        // student
        public int studentId { get; set; }
        // evidentirao
        public int evidentiraoId { get; set; }
    }
}
