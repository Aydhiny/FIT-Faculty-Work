import { TestBed } from '@angular/core/testing';

import { SemesterEndpointService } from './semester-endpoint.service';

describe('SemesterEndpointService', () => {
  let service: SemesterEndpointService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(SemesterEndpointService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
