import { NextFunction, Request, Response } from "express";
import { BadRequestError } from "../error/errorHandling";

import * as bcrypt from "bcrypt";
import _ = require("lodash");

const passport = require("passport");
const LocalStrategy = require("passport-local").Strategy;
const JWTstrategy = require("passport-jwt").Strategy;
// We use this to extract the JWT sent by the user
const ExtractJWT = require("passport-jwt").ExtractJwt;
const query = require("../queries/queries");

// LocalStrategy - register
passport.use("register", new LocalStrategy({
    usernameField: "email"
}, (username: string, password: string, done: any) => {
    query.db.one("SELECT * FROM el_users" +
        " WHERE email=$1", [username])
        .then((result: any) => {
            if (result) {
                done(undefined, true);
            }
        })
        .catch((err: any) => {
            console.log("catch -------");
            done(undefined, false);
        });
}));

// Local Strategy - login
passport.use("login", new LocalStrategy({
    usernameField: "email"
}, (username: string, password: string, done: any) => {
    query.db.one("SELECT * FROM el_users" +
        " WHERE email=$1", [username])
        .then((result: any) => {
                return comparePass(password, result);
            }, (err: any) => {
            const error = new BadRequestError("Do not have current input email in base!");
            done(error);
        })
        .then((result: any) => {
            console.log("RESULT", result);
            if (result) {
                done(undefined, result, {message: "Logged In Successfully"});
            }})
        .catch((err: any) => {
            done(err);
        });
}));
/**
 * Login Required middleware.
 */
export let isAuthenticated = (req: Request, res: Response, next: NextFunction) => {
    if (req.isAuthenticated()) {
        return next();
    }
    res.redirect("/login");
};

// passport.serializeUser((user: any, done: any) => {
//     done(undefined, user.id);
// });
//
// passport.deserializeUser((id: any, cb: any) => {
//     db.query("SELECT id, email, firstname, lastname, created_on, last_login FROM el_users" +
//         "WHERE id = $1", [parseInt(id, 10)])
//         .then(function (results: any) {
//         cb(undefined, results.rows[0]);
//         })
//         .catch(function (err: any) {
//             return cb(err);
//         });
// });

// JWT
// This verifies that the token sent by the user is valid
passport.use(new JWTstrategy({
    // we expect the user to send the token as a query paramater with the name "secret_token"
    jwtFromRequest: ExtractJWT.fromAuthHeaderAsBearerToken(),
    // secret we used to sign our JWT
    secretOrKey: process.env.JWT_SECRET
}, async (token: any, done: any, res: Response) => {
    try {
        // Pass the user details to the next middleware
        console.log("token", token);
        const idUserInLocal = token.id;
        query.db.one("select * from el_users_with_permissions" +
            " where id=$1", parseInt(idUserInLocal, 10))
            .then((data: any) => {
                const permFromView = data.array_agg;
                const permFromLocal = token.permissions;
                console.log("dataFromView", data.array_agg);
                console.log("LOCALE", token.permissions);
                const hasEqual = _.isEqual(permFromView, permFromLocal);
                console.log("hasEqual", hasEqual);
                if (hasEqual) {
                    done(undefined, token);
                } else {
                    console.log("redirect");
                    res.redirect("/api/elephant/login");
                }
            })
            .catch((err1: any) => {
                console.log("Token false!!!");
                done(err1);
            });
    } catch (err) {
        console.log("Catch- try");
        done(err);
    }
}));

export function comparePass(password: string, result: any): Promise<any> {
    const promise = new Promise<any>((resolve, reject) => {
        bcrypt.compare(password, result.password)
            .then((res) => {
                if (res) {
                    resolve(result);
                } else {
                    console.log("new Error");
                    const error = new BadRequestError("Incorrect password or email");
                    reject(error);
                }
            })
            .catch((err) => reject(err));
    });
    return promise;

}
