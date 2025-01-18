import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { MojConfig } from '../moj-config';
import { Router } from '@angular/router';
import { AutentifikacijaHelper } from '../_helpers/autentifikacija-helper';
declare function porukaSuccess(a: string): any;
declare function porukaError(a: string): any;

@Component({
  selector: 'app-studenti',
  templateUrl: './studenti.component.html',
  styleUrls: ['./studenti.component.css'],
})
export class StudentiComponent implements OnInit {
  EditujStudenta() {
    this.httpKlijent
      .post(
        MojConfig.adresa_servera + '/DodajStudenta',
        this.edit_student,
        MojConfig.http_opcije()
      )
      .subscribe((x: any) => {
        this.ngOnInit();
        this.edit_student = null;
        porukaSuccess('Student uspješno editovan!');
      });
  }
  ObrisiStudenta(id: any) {
    this.httpKlijent
      .post(
        MojConfig.adresa_servera + '/ObrisiStudenta',
        id,
        MojConfig.http_opcije()
      )
      .subscribe((x: any) => {
        this.ngOnInit();
        porukaSuccess('Student uspješno obrisan!');
      });
  }
  DodajStudenta() {
    this.httpKlijent
      .post(
        MojConfig.adresa_servera + '/DodajStudenta',
        this.novi_student,
        MojConfig.http_opcije()
      )
      .subscribe((x: any) => {
        this.ngOnInit();
        this.novi_student = null;
        porukaSuccess('Student uspješno dodan!');
      });
  }
  NoviStudent() {
    this.novi_student = {
      ime:
        this.ime_prezime.charAt(0).toUpperCase() +
        this.ime_prezime.substring(1),
      prezime: '',
      opstina_rodjenja_id:
        AutentifikacijaHelper.getLoginInfo().autentifikacijaToken
          .korisnickiNalog.DefaultOpstinaId,
    };
  }
  novi_student: any;
  edit_student: any;
  FiltrirajStudente() {
    if (this.ime_prezime == '' && this.opstina == '') return this.studentPodaci;

    return this.studentPodaci.filter(
      (x: any) =>
        (!this.filter_ime_prezime ||
          (x.ime + ' ' + x.prezime)
            .toLowerCase()
            .startsWith(this.ime_prezime) ||
          (x.prezime + ' ' + x.ime)
            .toLowerCase()
            .startsWith(this.ime_prezime)) &&
        (!this.filter_opstina ||
          x.opstina_rodjenja.description.toLowerCase().startsWith(this.opstina))
    );
  }

  title: string = 'angularFIT2';
  ime_prezime: string = '';
  opstina: string = '';
  studentPodaci: any;
  filter_ime_prezime: boolean;
  filter_opstina: boolean;

  constructor(private httpKlijent: HttpClient, private router: Router) {}

  testirajWebApi(): void {
    this.httpKlijent
      .get(
        MojConfig.adresa_servera + '/Student/GetAll',
        MojConfig.http_opcije()
      )
      .subscribe((x) => {
        this.studentPodaci = x;
      });
  }

  ngOnInit(): void {
    this.testirajWebApi();
    this.GetOpstine();
  }

  opstine: any;
  GetOpstine() {
    this.httpKlijent
      .get(MojConfig.adresa_servera + '/GetOpstine', MojConfig.http_opcije())
      .subscribe((x) => {
        this.opstine = x;
      });
  }
}
