using FIT_Api_Examples.Data;
using System.ComponentModel.DataAnnotations.Schema;
using System;

namespace FIT_Api_Examples.Modul2.ViewModels
{
    public class OvjeriUpisVM
    {
        public int Id { get; set; }
        public DateTime? DatumOvjere { get; set; }
        public string? Napomena { get; set; }
    }
}
