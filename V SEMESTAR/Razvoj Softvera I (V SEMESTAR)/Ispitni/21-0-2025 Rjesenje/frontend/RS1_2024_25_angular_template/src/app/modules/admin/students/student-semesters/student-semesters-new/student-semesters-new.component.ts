import {Component, OnInit} from '@angular/core';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import {ActivatedRoute, Router} from '@angular/router';
import {CityGetByIdEndpointService} from '../../../../../endpoints/city-endpoints/city-get-by-id-endpoint.service';
import {
  CityUpdateOrInsertEndpointService
} from '../../../../../endpoints/city-endpoints/city-update-or-insert-endpoint.service';
import {CountryLookupEndpointService} from '../../../../../endpoints/lookup-endpoints/country-lookup-endpoint.service';
import {RegionLookupEndpointService} from '../../../../../endpoints/lookup-endpoints/region-lookup-endpoint.service';
import {
  SemesterEndpointService,
  SemesterRequest,
  SemesterResponse
} from '../../../../../endpoints/semester-endpoint.service';
import {
  StudentGetByIdEndpointService
} from '../../../../../endpoints/student-endpoints/student-get-by-id-endpoint.service';
import {MySnackbarHelperService} from '../../../../shared/snackbars/my-snackbar-helper.service';

@Component({
  selector: 'app-student-semesters-new',
  standalone: false,

  templateUrl: './student-semesters-new.component.html',
  styleUrl: './student-semesters-new.component.css'
})
export class StudentSemestersNewComponent implements OnInit {

  ngOnInit() {
    this.route.params.subscribe(params => {
      this.studentid = params['id'];
    })
    this.UcitajStudenta();
    this.UcitajAkademske();
    this.UcitajSemestre();
    this.semestarForm.get('godinaStudija')?.valueChanges.subscribe((value) => {
      const exist = this.semestri.some((semestarValue: SemesterResponse) => semestarValue.godinaStudija === Number(value));
      this.semestarForm.get('obnova')?.setValue(exist);
    })

    this.semestarForm.get('obnova')?.valueChanges.subscribe((checked: boolean) => {
      this.semestarForm.patchValue({
        cijenaSkolarine : checked ? 400 : 1800
      })
    })
    this.semestarForm.get('obnova')?.disable();
    this.semestarForm.get('cijenaSkolarine')?.disable();
  }

  student: any;
  semestri: any;
  studentid: any;
  akademske:any;
  semestarForm: FormGroup;

  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute,
    public router: Router,
    private snackbar: MySnackbarHelperService,
    private semestarEndpoint: SemesterEndpointService,
    private studentService: StudentGetByIdEndpointService
  ) {

    this.semestarForm = this.fb.group({
      datumUpisa: ['', ],
      godinaStudija: [null,[Validators.min(50), Validators.max(2000)]],
      akademskaGodinaId: [null,],
      cijenaSkolarine: [1800,],
      obnova: [false,],
    });
  }

  SpremiSemestar() {
    const noviSemestar: SemesterRequest = {
      studentId: this.student.id,
      datumUpisa: this.semestarForm.get('datumUpisa')?.value,
      godinaStudija: this.semestarForm.get('godinaStudija')?.value,
      akademskaGodinaId: this.semestarForm.get('akademskaGodinaId')?.value,
      cijenaSkolarine: this.semestarForm.get('cijenaSkolarine')?.getRawValue(),
      obnova: this.semestarForm.get('obnova')?.getRawValue(),
    };
    this.semestarEndpoint.CreateSemestar(noviSemestar).subscribe({
      next: res => {
        this.snackbar.showMessage("Uspjesno napravljen semestar :D ", 1000);
        this.router.navigateByUrl(`admin/semester/${this.studentid}`);
      }
    });
  }

  private UcitajStudenta() {
    this.studentService.handleAsync(this.studentid).subscribe({
      next: res => {
        this.student = res;
        console.log("Dule kralj :)");
      }
    })
  }

  private UcitajAkademske() {
    this.semestarEndpoint.GetAkademske().subscribe({
      next: res => {
        this.akademske = res;
        console.log("Dule kralj 2 :)");
      }
    })
  }

  private UcitajSemestre() {
    this.semestarEndpoint.GetSemestri(this.studentid).subscribe({
      next: res => {
        this.semestri = res;
        console.log("Dule kralj 3 :)");
      }
    })
  }
}
