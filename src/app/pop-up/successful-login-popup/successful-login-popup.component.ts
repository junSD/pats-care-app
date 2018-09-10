import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material';

@Component({
  selector: 'app-successful-login-popup',
  templateUrl: './successful-login-popup.component.html',
  styleUrls: ['./successful-login-popup.component.css']
})
export class SuccessfulLoginPopupComponent {

  useremail: string;
  isLogged: boolean;

  constructor(public dialogRef: MatDialogRef<SuccessfulLoginPopupComponent>,
              @Inject(MAT_DIALOG_DATA) public data: any) {
    this.useremail = data.useremail;
    this.isLogged = data.isLogged;
    console.log(data);
    setTimeout(() => this.closeDialogProfile(), 5000);
  }

  closeDialogProfile() {
    this.dialogRef.close();
  }
}
