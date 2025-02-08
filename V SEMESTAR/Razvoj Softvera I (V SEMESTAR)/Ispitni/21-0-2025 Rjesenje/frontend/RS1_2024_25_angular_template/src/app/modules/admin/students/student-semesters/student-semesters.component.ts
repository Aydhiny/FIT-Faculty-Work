import {Component, OnInit} from '@angular/core';
import {MatTableDataSource} from '@angular/material/table';
import {
  StudentGetByIdEndpointService
} from '../../../../endpoints/student-endpoints/student-get-by-id-endpoint.service';
import {ActivatedRoute, Router} from '@angular/router';
import {SemesterEndpointService, SemesterResponse} from '../../../../endpoints/semester-endpoint.service';
import {debounceTime} from 'rxjs';

@Component({
  selector: 'app-student-semesters',
  standalone: false,

  templateUrl: './student-semesters.component.html',
  styleUrl: './student-semesters.component.css'
})
export class StudentSemestersComponent implements OnInit {
  studentid:any;
  student:any;
  semestri:any;
  ngOnInit(): void {
  this.aktivna.params.subscribe(params => {
    this.studentid = params['id'];
  })
    this.UcitajStudenta();
    this.UcitajSemestre();
  }
  constructor(private studentService: StudentGetByIdEndpointService,
              private router: Router,
              private aktivna: ActivatedRoute,
              private semestarService: SemesterEndpointService) {
  }
  displayedColumns: string[] = ["red1", "red2", "red3", "red4", "red5", "red6", "red7", "red8"];
  dataSource: MatTableDataSource<SemesterResponse> = new MatTableDataSource<SemesterResponse>();

  UcitajStudenta() {

    this.studentService.handleAsync(this.studentid).subscribe({
      next: res => {
        this.student = res;
        console.log("Uspjeh student");
      }
    })
  }

  UcitajSemestre() {
    this.semestarService.GetSemestri(this.studentid).pipe(debounceTime(10000)).subscribe({
      next: res => {
        this.semestri = res;
        console.log("Uspjeh semestar");
        this.dataSource.data = this.semestri;
      }
    })
  }

  PredjiNaNovi() {
    this.router.navigateByUrl(`admin/semester/new/${this.studentid}`);
  }

  ovjeriSemestar(id: number) {
    this.semestarService.OvjeriSemestar(id).subscribe({
      next: res => {
        console.log("Bravo majmune! :)");
        this.UcitajSemestre();
      }
    })

  }
}
