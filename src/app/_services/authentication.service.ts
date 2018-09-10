import { Inject, Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { UsersLoginForm } from '../_models/usersLoginform.model';
import { Observable } from 'rxjs';
import { BASE_URL_TOKEN } from '../configs';

@Injectable()
export class AuthenticationService {
    constructor(@Inject(BASE_URL_TOKEN) private baseUrl: string, private http: HttpClient) { }

    login(loginForm: UsersLoginForm): Observable<object>  {
      const url = `${this.baseUrl}/api/elephant/login`;
      return this.http.post(url, loginForm);
    }

    logout() {
        // remove user from local storage to log user out
        localStorage.removeItem('currentUser');
    }
}
