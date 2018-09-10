import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { StaticData } from '../_util/staticData';
import { MatDialog } from '@angular/material';
import { AuthenticationService } from '../_services';
import { UsersLoginForm } from '../_models/usersLoginform.model';
import {SuccessfulLoginPopupComponent} from '../pop-up/successful-login-popup/successful-login-popup.component';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  loginForm: FormGroup;
  returnUrl: string;
  isLogin: boolean;

  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private authenticationService: AuthenticationService,
    public dialog: MatDialog) {
    this.isLogin = false;
  }

  ngOnInit() {
    this.loginForm = this.formBuilder.group({
      useremail: ['', [
        Validators.required,
        Validators.pattern(StaticData.EMAIL_VALIDATOR)
      ]
      ],
      password: ['', [
        Validators.required,
        Validators.pattern(StaticData.PASSWORD_VALIDATOR)
      ]
      ]
    });

    // reset login status
    this.authenticationService.logout();

    // get return url from route parameters or default to '/'
    this.returnUrl = this.route.snapshot.queryParams['returnUrl'] || '/';
  }

  get f() { return this.loginForm.controls; }

  isControlInvalid(controlName: string): boolean {
    const control = this.loginForm.controls[controlName];

    return control.invalid && control.touched;
  }
  onSubmit() {

    console.log(this.loginForm);
    const loginNewForm = new UsersLoginForm(
      this.loginForm.value.useremail,
      this.loginForm.value.password
    );
    console.log(loginNewForm);
    this.authenticationService.login(loginNewForm)
      .subscribe(
        (data: any) => {
          // this.router.navigate([this.returnUrl]);
          console.log(data);
          this.loginForm.reset();
          this.router.navigateByUrl('/');
          this.openDialogSuccess(loginNewForm, true);
        },
        (error: any) => {
          // this.alertService.error(error);
          this.openDialogSuccess(loginNewForm, false);
          console.log('Error', error);
        });
  }
  openDialogSuccess(userData: UsersLoginForm, isLogged: boolean): void {
    const dialogRef = this.dialog.open(SuccessfulLoginPopupComponent, {
      disableClose: true,
      maxHeight: '200px',
      width: '100px',
      position: {top: '10%', left: '20%', right: '20%'},
      data: {
        useremail: userData.email,
        isLogged: isLogged
      }
    });
    dialogRef.afterClosed().subscribe((result) => {
      // this.currentPage = 1;
      // this.restoreEmail = null;
    });
  }
}
