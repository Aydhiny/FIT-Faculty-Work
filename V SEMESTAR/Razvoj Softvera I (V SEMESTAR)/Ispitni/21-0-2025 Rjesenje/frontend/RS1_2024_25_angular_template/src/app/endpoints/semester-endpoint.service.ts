import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {MyConfig} from '../my-config';
import {MyCacheService} from '../services/cache-service/my-cache.service';
import {of} from 'rxjs';
/*     const cacheKey = JSON.stringify(request);
    if(this.cacheService.has(cacheKey)){
      return of (this.cacheService.get(cacheKey) as SemesterResponse);
    } */
export interface SemesterRequest {
  studentId:number;
  datumUpisa: Date;
  godinaStudija: number;
  akademskaGodinaId: number;
  cijenaSkolarine: number;
  obnova: boolean;
}
export interface SemesterResponse {
  Id: number;
  datumOvjere?: Date;
  datumUpisa: Date;
  godinaStudija: number;
  cijenaSkolarine: number;
  obnova: boolean;
  akademskaGodinaId: number;
  akademskiOpis: string;
  studentId:number;
  profesorId: number;
  profesorIme: string;
}
export interface AkademskeResponse {
  id:number;
  description: string;
}

@Injectable({
  providedIn: 'root'
})
export class SemesterEndpointService {
  private apiUrl = `${MyConfig.api_address}`;

  constructor(private http: HttpClient, private cacheService: MyCacheService) {

  }

  GetAkademske() {
    return this.http.get<AkademskeResponse[]>(`${this.apiUrl}/GetAkademske`);
  }
  GetSemestri(id:number) {
    return this.http.get<SemesterResponse[]>(`${this.apiUrl}/semester/all/${id}`);
  }

  CreateSemestar(request: SemesterRequest) {

    return this.http.post<number>(`${this.apiUrl}/semester/create`, request);
  }
  OvjeriSemestar(id:any) {
    return this.http.post(`${this.apiUrl}/IzvrsiOvjeru`, id);
  }
}
