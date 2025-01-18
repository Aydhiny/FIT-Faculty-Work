using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using FIT_Api_Examples.Data;
using FIT_Api_Examples.Helper;
using FIT_Api_Examples.Helper.AutentifikacijaAutorizacija;
using FIT_Api_Examples.Modul2.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FIT_Api_Examples.Modul2.Controllers
{
    //[Authorize]
    [ApiController]
    [Route("[controller]/[action]")]
    public class UpisGodinaController : ControllerBase
    {
        private readonly ApplicationDbContext _dbContext;

        public UpisGodinaController(ApplicationDbContext dbContext)
        {
            this._dbContext = dbContext;
        }

        // GET UPISI NEKOG STUDENTA, DODAVANJE NOVOG UPISA, OVJERA UPISA

        [HttpGet]
        [Route("/GetUpisi")]
        public ActionResult<List<UpisGodina>> GetUpisi([FromQuery] int studentid)
        {
            var upisi = _dbContext.UpisGodina.Include( x => x.student).Include(x => x.evidentirao).Include(x => x.akademskaGodina)
                .Where(x => x.studentId == studentid).ToList();
            if (upisi == null)
                return BadRequest();
            return Ok(upisi);
        }

        [HttpPost]
        [Route("/DodajUpis")]
        public ActionResult DodajUpis([FromBody] DodajUpisVM x) 
        {

            if(_dbContext.UpisGodina.ToList().Exists(s => s.studentId == x.studentId && s.GodinaStudija == x.GodinaStudija)) 
            {
                if (x.Obnova)
                {

                    var noviUpis = new UpisGodina()
                    {
                        DatumUpisa = x.DatumUpisa,
                        GodinaStudija = x.GodinaStudija,
                        CijenaSkolarine = x.CijenaSkolarine,
                        Obnova = x.Obnova,
                        studentId = x.studentId,
                        akademskaGodinaId = x.akademskaGodinaId,
                        evidentiraoId = x.evidentiraoId,
                    };
                    _dbContext.UpisGodina.Add(noviUpis);
                    _dbContext.SaveChanges();

                    return Ok();
                }
                else
                    return BadRequest();
            }
            else 
            {
                var noviUpis = new UpisGodina()
                {
                    DatumUpisa = x.DatumUpisa,
                    GodinaStudija = x.GodinaStudija,
                    CijenaSkolarine = x.CijenaSkolarine,
                    Obnova = x.Obnova,
                    studentId = x.studentId,
                    akademskaGodinaId = x.akademskaGodinaId,
                    evidentiraoId = x.evidentiraoId,
                };
                _dbContext.UpisGodina.Add(noviUpis);
                _dbContext.SaveChanges();

                return Ok();
            }

        }

        [HttpPost]
        [Route("/OvjeriUpis")]
        public ActionResult OvjeriUpis([FromBody] OvjeriUpisVM x)
        {
            var odabraniUpis = _dbContext.UpisGodina.Find(x.Id);
            if (odabraniUpis == null)
                return BadRequest();

            odabraniUpis.DatumOvjere = x.DatumOvjere;
            odabraniUpis.Napomena = x.Napomena;
            _dbContext.SaveChanges();
            return Ok();
        }
    }
}
