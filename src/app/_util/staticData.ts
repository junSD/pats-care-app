export class StaticData {
  static PASSWORD_VALIDATOR = /^\d{6,15}$/;
  static EMAIL_VALIDATOR = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  static FIRSTNAME_VALIDATOR = /^[a-zA-Zа-яА-Я]{2,25}$/;
  static LASTNAME_VALIDATOR = /^[a-zA-Zа-яА-Я]{2,35}$/;
}
