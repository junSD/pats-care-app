import { BadRequestError } from "../error/errorHandling";

export class User {
    private static PASSWORD_VALIDATOR = /^\d{6,15}$/;
    private static EMAIL_VALIDATOR = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    private static FIRSTNAME_VALIDATOR = /^[a-zA-Zа-яА-Я]{2,25}$/;
    private static LASTNAME_VALIDATOR = /^[a-zA-Zа-яА-Я]{2,35}$/;
    public email: string;
    public password: string;
    public firstname: string;
    public lastname: string;
    public static parseFromRequest(obj: any): Promise<User> {
        const promise = new Promise<User>((resolve, reject) => {

            if (!User.EMAIL_VALIDATOR.test(obj.email)) {
                const error = new BadRequestError("Email not match with pattern");
                reject(error);
            } else if (!User.PASSWORD_VALIDATOR.test(obj.password)) {
                const error = new BadRequestError("Password not match with pattern");
                reject(error);
            } else if (!User.FIRSTNAME_VALIDATOR.test(obj.firstname)) {
                const error = new BadRequestError("Firstname not match with pattern");
                reject(error);
            } else if (!User.LASTNAME_VALIDATOR.test(obj.lastname)) {
                const error = new BadRequestError("Lastname not match with pattern");
                reject(error);
            }

            resolve(new User(obj));
        });
        return promise;
    }

    constructor(obj: any) {
        this.email = obj.email;
        this.password = obj.password;
        this.firstname = obj.firstname;
        this.lastname = obj.lastname;
    }
}
