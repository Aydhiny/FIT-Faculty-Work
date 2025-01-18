import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Params } from '@angular/router';
import { MojConfig } from '../moj-config';
import { HttpClient } from '@angular/common/http';
import { AutentifikacijaHelper } from '../_helpers/autentifikacija-helper';

declare function porukaSuccess(a: string): any;
declare function porukaError(a: string): any;

@Component({
  selector: 'app-student-maticnaknjiga',
  templateUrl: './student-maticnaknjiga.component.html',
  styleUrls: ['./student-maticnaknjiga.component.css'],
})
export class StudentMaticnaknjigaComponent implements OnInit {
  SpasiUpis() {
    this.httpKlijent
      .post(
        MojConfig.adresa_servera + '/DodajUpis',
        this.novi_upis,
        MojConfig.http_opcije()
      )
      .subscribe(
        (x: any) => {
          this.ngOnInit();
          this.novi_upis = null;
          porukaSuccess('Upis uspjesno dodan!');
        },
        (error) => {
          porukaError(
            'Novi upis nije moguce dodati jer niste oznacili obnovu!'
          );
        }
      );
  }
  NoviUpis() {
    this.novi_upis = {
      studentId: this.studentID,
      evidentiraoid:
        AutentifikacijaHelper.getLoginInfo().autentifikacijaToken
          .korisnickiNalog.id,
    };
  }
  constructor(private httpKlijent: HttpClient, private route: ActivatedRoute) {
    this.route.params.subscribe((params: Params) => {
      this.studentID = params['id'];
    });
  }

  novi_upis: any;
  studentID: any;
  student: any;
  upisi: any;
  akademske: any;
  ngOnInit(): void {
    this.getStudent();
    this.getUpisiStudenta();
    this.getAkademske();
  }
  getAkademske() {
    this.httpKlijent
      .get(MojConfig.adresa_servera + '/GetAkademske', MojConfig.http_opcije())
      .subscribe((x) => {
        this.akademske = x;
      });
  }
  getUpisiStudenta() {
    this.httpKlijent
      .get(MojConfig.adresa_servera + '/GetUpisi', {
        params: { studentid: this.studentID },
        observe: 'response',
      })
      .subscribe((response) => {
        this.upisi = response.body;
      });
  }
  getStudent() {
    this.httpKlijent
      .get(MojConfig.adresa_servera + '/GetStudenta', {
        params: { studentid: this.studentID },
        observe: 'response',
      })
      .subscribe((response) => {
        this.student = response.body;
      });
  }
}
