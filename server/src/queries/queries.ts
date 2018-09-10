import * as bcrypt from "bcrypt";
import * as promise from "bluebird";
import * as monitor from "pg-monitor";

import _ = require("lodash");

import { NextFunction, Request, Response } from "express";
import { BadRequestError } from "../error/errorHandling";

const hm = require("../help_functions/help_module");

const initOptions = {
    // Initialization Options
    promiseLib: promise
};

const pgp = require("pg-promise")(initOptions);

monitor.attach(initOptions);
monitor.setTheme("matrix");

const connectionOption = {
    database: process.env.DB_DATABASE,
    host: process.env.DB_HOST, // "localhost" is the default;
    password: process.env.DB_PASS,
    port: process.env.DB_PORT, // 5432 is the default;
    user: process.env.DB_USER
};

const db = pgp(connectionOption);

// add query functions

function getAllUsers(req: Request, res: Response, next: NextFunction) {
    db.any("select * from el_users order by id asc")
        .then(hm.getOutData(res))
        .catch((err: any) => {
            return next(err);
        });
}

function getUserById(req: Request, res: Response, next: NextFunction) {
    const userID = parseInt(req.params.id , 10);
    const authUser = req.user.id;
    console.log("authUser", authUser);
    console.log("req.user ---- ", req.user);
    if (!authUser) {
        const error = new BadRequestError("Unauthorized");
        return next(error);
    }
    if (!(req.params.id && !_.isNaN(userID))) {
        const error = new BadRequestError("ID not sending or not a number");
        return next(error);
    }
    db.one("select id, email, firstname, lastname, created_on, last_login" +
        " from el_users where id=$1", userID)
        .then(hm.getOutData(res))
        .catch((err: any) => {
            const error = new BadRequestError(`Query to bd is incorrect, Error: ${err.message}`);
            return next(error);
        });
}

function createUser(req: Request, res: Response, next: NextFunction) {
    console.log(req.body);
    if (!(!_.isEmpty(req.body) && req.body.password)) {
        const error = new BadRequestError("Body is incorrect");
        return next(error);
    }
    bcrypt.hash(req.body.password, parseInt(process.env.SALT_ROUND, 10))
        .then((hash) => {
            req.body.password = hash;
            return true;
        })
        .then(() => Promise.resolve(db.one("insert into el_users (email, password)" +
                    " values (${email}, ${password})" +
                    " returning email, firstname, lastname, created_on, last_login", req.body)))
        .then(hm.getOutData(res))
        .catch((err: any) => {
            return next(err);
        });
}

function updateUserByID(req: Request, res: Response, next: NextFunction) {
    if (!_.isEmpty(req.body)) {
        const error = new BadRequestError("Body is empty");
        return next(error);
    }
    db.one("update el_users set email=$1, firstname=$2, lastname=$3 where id=$4 " +
        "returning email, firstname, lastname, created_on, last_login",
        [req.body.email, req.body.firstname, req.body.lastname, parseInt(req.params.id, 10)])
        .then(hm.getOutData(res))
        .catch((err: any) => {
            const error = new BadRequestError(`Update data in user not success, Error: ${err.message}`);
            return next(error);
        });
}

function removeUserById(req: Request, res: Response, next: NextFunction) {
    const userID = parseInt(req.params.id, 10);
    if (req.params.id && !_.isNaN(userID)) {
        const error = new BadRequestError("ID not sending or not a number");
        return next(error);
    }
    db.one("delete from el_users where id = $1" +
        "returning email, firstname, lastname, created_on, last_login", userID)
        .then(hm.getOutData(res))
        .catch((err: any) => {
            const error = new BadRequestError(`Delete user not success, Error: ${err.message}`);
            return next(error);
        });
}

module.exports = {
    createUser,
    db,
    getAllUsers,
    getUserById,
    removeUserById,
    updateUserByID
};
