import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { AppRoutingModule } from './app-routing.module';
import { LoginComponent } from './login';
import { AuthenticationService, UserService } from './_services';
import { BASE_URL_TOKEN } from './configs';
import { environment } from '../environments/environment';
import { CommonModule } from '@angular/common';
import { MatDialogModule } from '@angular/material';
import { SuccessfulLoginPopupComponent } from './pop-up/successful-login-popup/successful-login-popup.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    SuccessfulLoginPopupComponent
  ],
  entryComponents: [
    SuccessfulLoginPopupComponent
  ],
  imports: [
    CommonModule,
    BrowserModule,
    ReactiveFormsModule,
    HttpClientModule,
    AppRoutingModule,
    MatDialogModule,
    BrowserAnimationsModule
  ],
  providers: [
    AuthenticationService,
    UserService,
    {
      provide: BASE_URL_TOKEN,
      useValue: environment.baseUrl
    }
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
