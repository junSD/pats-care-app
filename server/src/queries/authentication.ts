import { NextFunction, Request, Response } from "express";
import { BadRequestError } from "../error/errorHandling";
import { User } from "../typings/userType";

import * as bcrypt from "bcrypt";
import _ = require("lodash");
import moment = require ("moment");
import * as passport from "passport";

const jwt = require("jsonwebtoken");
const query = require("../queries/queries");

function registerUser(req: Request, res: Response, next: NextFunction) {
    if (!checkInputParams(req)) {
        const error = new BadRequestError("Body is incorrect - registration new user");
        return next(error);
    }
    passport.authenticate("register", (err, userIsExist, info) => {
        if (err) {
            return next(err);
        }
        console.log(userIsExist);
        if (userIsExist) {
            const error = new BadRequestError("User with this email already exists");
            return next(error);
        }
        const userProm = () => Promise.resolve(User.parseFromRequest(req.body));
        userProm()
            .then((user: User) => {
                console.log("user", user);
                return Promise.all([bcrypt.hash(req.body.password, parseInt(process.env.SALT_ROUND, 10)), user]);
            }, (err1: any) => {
                console.log("From USER");
                return next(err1);
            })
            .then((arr: any) => {
                arr[1].password = arr[0];
                return Promise.all([arr[1]]);
            })
            .then((arr: any) => Promise.resolve(query.db.one("insert into" +
                " el_users (email, password, firstname, lastname)" +
                "values (${email}, ${password}, ${firstname}, ${lastname})" +
                "returning id, email, firstname, lastname, created_on, last_login",
                arr[0])))
            .then((data: any) => {
                console.log("DATA!!!!!", data);
                loginUser(req, res, next);
            }, (err1: any) => {
                const error = new BadRequestError("User with this email already exists");
                return next(error);
            })
            .catch((err2: any) => {
                return next(err2);
            });
    })(req, res, next);
}

function loginUser(req: Request, res: Response, next: NextFunction) {
    if (req.body.password && req.body.email) {
        passport.authenticate("login", (err, user, info) => {
            if (err) {
                return next(err);
            }
            console.log("INFO!!!!-----", info);
            if (!user) {
                res.status(401)
                    .json({
                        info
                    });
            }
            query.db.none("update el_users set last_login = $1" +
                " where id=$2", [moment(new Date()).format(), user.id])
                .then((data: any) => Promise.resolve(query.db.one("select * from el_users_with_permissions" +
                    " where id=$1", parseInt(user.id, 10))),
                    (err1: any) => {
                        const error = new BadRequestError("Update field last_login was not successful");
                        return next(error);
                    })
                .then((data: any) => {
                    console.log("data - view---", data);
                    const token = generateJWT(data);
                    res.status(200)
                        .json({
                            token
                        });
                }, (err1: any) => {
                    const error = new BadRequestError("Do not have any data from view");
                    return next(error);
                })
                .catch((err1: any) => {
                    return next(err1);
                });
        })(req, res, next);
    } else {
        const error = new BadRequestError("Empty field");
        return next(error);
    }
}

function generateJWT(user: any) {
    const expiry = new Date();
    expiry.setDate(expiry.getDate() + 7);
    const permissions: string[] = [];
    for (const profile of user.array_agg) {
        permissions.push(profile);
    }

    return jwt.sign({
        email: user.email,
        exp: expiry.getTime() / 1000,
        firstname: user.firstname,
        id: user.id,
        lastname: user.lastname,
        permissions: permissions
    }, process.env.JWT_SECRET);
}

function checkInputParams(req: Request) {
    console.log("Check");
    return !!(!_.isEmpty(req.body) && req.body.password && req.body.email);
}

module.exports = {
    loginUser,
    registerUser
};
