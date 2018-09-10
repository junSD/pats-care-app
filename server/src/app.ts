import { NextFunction, Request, Response } from "express";
import { loggerError, loggerInfo } from "./config/winston";
import { CoreError } from "./error/errorHandling";

import cookieParser = require("cookie-parser");
import * as dotenv from "dotenv";
import express = require("express");
import logger = require("morgan");
import * as path from "path";

const cors = require("cors");
const passport = require("passport");

dotenv.config({path: path.resolve(process.cwd(), "env/.env")});

const router = require("./routes/routes");
require("./config/passport");

const app = express();

// view engine setup
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "jade");

app.use(cors());
app.use((req, res, next) => {
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS, PUT, PATCH, DELETE" );
    next();
});
app.use(logger("dev"));
app.use(express.json());
app.use(express.urlencoded({extended: false}));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, "public")));

app.use(passport.initialize());

app.use(loggerInfo());

app.use("/api", router);

app.use((err: any, req: Request, res: Response, next: NextFunction) => {
        console.log("req.isAuthenticated()", req.isAuthenticated());
        if (!req.isAuthenticated()) {
            res.status(401).send(err);
        } else {
            return next();
        }
    }
);

app.use(loggerError());

app.use((error: any, req: Request, res: Response, next: NextFunction) => {
    if (error && error instanceof CoreError) {
        const appError = error;
        console.log(appError.errorData.status);
        res.status(appError.errorData.status).send(appError);
    } else {
        res.status(500).send(error);
    }
});
console.log("Server running at http://localhost:3000/api/elephant/");
module.exports = app;
