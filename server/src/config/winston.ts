import * as path from "path";
const expressWinston = require("express-winston");
const winston = require("winston");

// define the custom settings for each transport (file, console)
const options = {
    file: {
        // level: "debug",
        filename: `${path.resolve(".")}/logs/app.log`,
        handleExceptions: true,
        json: true,
        maxsize: 5242880, // 5MB
        maxFiles: 5,
        colorize: false
    },
    console: {
        // level: "debug",
        handleExceptions: true,
        json: false,
        colorize: true
    }
};

// instantiate a new Winston Logger with the settings defined above

export const loggerInfo = () => {
        return expressWinston.logger({
            winstonInstance: (winston.createLogger)({
                format: winston.format.combine(
                    winston.format.timestamp({
                        format: "YYYY-MM-DD HH:mm:ss"
                    }),
                    winston.format.simple()
                ),
                transports: [
                    new winston.transports.Console(options.console),
                    new winston.transports.File(options.file)
                ]
            }),
            exceptionToMeta: (err: any) => {
                return err;
            }
        });
};

export const loggerError = () => {
    return expressWinston.errorLogger({
        winstonInstance: (winston.createLogger)({
            format: winston.format.combine(
                winston.format.timestamp({
                    format: "YYYY-MM-DD HH:mm:ss"
                }),
                winston.format.simple()
            ),
            transports: [
                new winston.transports.Console(options.console),
                new winston.transports.File(options.file)
            ]
        }),
        exceptionToMeta: (err: any) => {
            return err;
        }
    });
};
