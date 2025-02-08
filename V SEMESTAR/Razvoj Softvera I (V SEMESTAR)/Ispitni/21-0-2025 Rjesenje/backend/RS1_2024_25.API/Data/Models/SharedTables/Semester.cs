using RS1_2024_25.API.Data.Models.TenantSpecificTables.Modul1_Auth;
using RS1_2024_25.API.Data.Models.TenantSpecificTables.Modul2_Basic;
using System.ComponentModel.DataAnnotations.Schema;

namespace RS1_2024_25.API.Data.Models.SharedTables
{
    public class Semester
    {
        public int Id { get; set; }
        public DateTime datumUpisa { get; set; }
        public DateTime? datumOvjere { get; set; }
        public int godinaStudija { get; set; }
        public float cijenaSkolarine { get; set; }
        public bool obnova { get; set; }

        [ForeignKey(nameof(akademskaGodinaId))]
        public int akademskaGodinaId { get; set; }
        public AcademicYear akademskaGodina { get; set; }

        [ForeignKey(nameof(studentId))]
        public int studentId { get; set; }
        public Student student { get; set; }

        [ForeignKey(nameof(profesorId))]
        public int profesorId { get; set; }
        public MyAppUser profesor { get; set; }

    }
}
