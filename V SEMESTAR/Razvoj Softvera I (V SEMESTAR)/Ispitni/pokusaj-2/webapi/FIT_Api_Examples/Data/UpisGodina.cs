using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace FIT_Api_Examples.Data
{
    public class UpisGodina
    {
        public int Id { get; set; }
        public DateTime DatumUpisa { get; set; }
        public int GodinaStudija { get; set; }
        public float CijenaSkolarine { get; set; }
        public bool Obnova {  get; set; }
        public DateTime? DatumOvjere { get; set; }
        public string? Napomena { get; set; }
        [ForeignKey(nameof(akademskaGodina))]
        public int akademskaGodinaId { get; set; }
        public AkademskaGodina akademskaGodina { get; set; }
        // student
        [ForeignKey(nameof(student))]
        public int studentId { get; set; }
        public Student student { get; set; }

        // evidentirao
        [ForeignKey(nameof(evidentirao))]
        public int evidentiraoId { get; set; }
        public KorisnickiNalog evidentirao { get; set; }


        /*
 * datum upisa u zimski semestar: DateTime
- godina studija: int
- akademska godina: FK na tabelu AkademskaGodina (prikazati unutar 
combobox-a)
- cijena školarine: float
- obnova: bool
- datum ovjere: DateTime
- napomena za ovjeru: text
 * 
 */

    }
}
