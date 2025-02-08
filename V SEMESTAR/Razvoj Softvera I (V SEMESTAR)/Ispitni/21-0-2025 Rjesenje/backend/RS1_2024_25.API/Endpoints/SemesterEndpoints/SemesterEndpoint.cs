using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using RS1_2024_25.API.Data;
using RS1_2024_25.API.Data.Models.SharedTables;
using RS1_2024_25.API.Data.Models.TenantSpecificTables.Modul1_Auth;
using RS1_2024_25.API.Data.Models.TenantSpecificTables.Modul2_Basic;
using RS1_2024_25.API.Services;
using System.ComponentModel.DataAnnotations.Schema;

namespace RS1_2024_25.API.Endpoints.SemesterEndpoints
{
    [Microsoft.AspNetCore.Mvc.Route("/semester")]
    public class SemesterEndpoint(ApplicationDbContext db, IHttpContextAccessor accessor) : ControllerBase
    {
        [HttpGet("all/{studentid}")]
        public async Task<ActionResult> GetAllSemestri(int studentid, CancellationToken token = default) 
        {
            var semestri = await db.Semesters.Where(x => x.studentId == studentid).Include(x => x.profesor).
                Include(x => x.student).Include(x => x.akademskaGodina).Select(x => new SemesterResponse
            {
                Id = x.Id,
                datumUpisa = x.datumUpisa,
                datumOvjere = x.datumOvjere,
                akademskaGodinaId = x.akademskaGodinaId,
                akademskaGodina = x.akademskaGodina,
                akademskiOpis = x.akademskaGodina.Description.Substring(x.akademskaGodina.Description.IndexOf('r') + 2),
                studentId = x.studentId,
                student = x.student,
                cijenaSkolarine = x.cijenaSkolarine,
                godinaStudija = x.godinaStudija,
                obnova = x.obnova,
                profesor = x.profesor,
                profesorId = x.profesorId,
                profesorIme = x.profesor.FirstName
            }).ToListAsync(token);
            return Ok(semestri);
        }
        [HttpPost("create")]
        public async Task<ActionResult> CreateSemestar([FromBody]SemesterRequest r, CancellationToken token = default)
        {
            MyAuthInfo profa = MyAuthServiceHelper.GetAuthInfoFromRequest(db, accessor);
            if (!profa.IsLoggedIn)
                return Unauthorized();
            var profaId = profa.UserId;
            var noviSemestar = new Semester()
            {
                studentId = r.studentid,
                godinaStudija = r.godinaStudija,
                cijenaSkolarine = r.cijenaSkolarine,
                datumUpisa = r.datumUpisa,
                obnova = r.obnova,
                profesorId = profaId,
                akademskaGodinaId = r.akademskaGodinaId
            };
            db.Semesters.Add(noviSemestar);
            await db.SaveChangesAsync(token);
            return StatusCode(201, new {Message = "Uspjesno kreiran sa id: ", semestarId=noviSemestar.Id});
        }
        [HttpGet]
        [Microsoft.AspNetCore.Mvc.Route("/GetAkademske")]
        public async Task<ActionResult> GetAkademske(CancellationToken token = default)
        {
            var akademske = await db.AcademicYears.Select(x => new AkademskaResponse
            {
                Id = x.ID,
                Description = x.Description.Substring(x.Description.IndexOf('r') + 2),
            }).ToListAsync(token);
            return Ok(akademske);
        }
        [HttpPost]
        [Microsoft.AspNetCore.Mvc.Route("/IzvrsiOvjeru")]
        public async Task<ActionResult> IzvrsiOvjeru([FromBody] int semestarId, CancellationToken token = default)
        {
            var semestar = db.Semesters.Find(semestarId);
            if (semestar == null)
                return BadRequest();
            semestar.datumOvjere = DateTime.Now;
            db.Semesters.Update(semestar);
            await db.SaveChangesAsync(token);
            return Ok();
        }
    }
    public class SemesterResponse 
    {
        public int Id { get; set; }
        public DateTime datumUpisa { get; set; }
        public DateTime? datumOvjere { get; set; }
        public int godinaStudija { get; set; }
        public float cijenaSkolarine { get; set; }
        public bool obnova { get; set; }

        public int akademskaGodinaId { get; set; }
        public AcademicYear akademskaGodina { get; set; }
        public string akademskiOpis { get; set; }

        public int studentId { get; set; }
        public Student student { get; set; }

        public int profesorId { get; set; }
        public MyAppUser profesor { get; set; }
        public string profesorIme { get; set; }
    }
    public class SemesterRequest 
    {
        public int studentid { get; set; }
        public DateTime datumUpisa { get; set; }
        public int godinaStudija { get; set; }
        public int akademskaGodinaId { get; set; }
        public int cijenaSkolarine { get; set; }
        public bool obnova { get; set; }
    }

    public class AkademskaResponse 
    {
        public int Id { get; set; }
        public string Description { get; set; }
    }
}
