"use strict";

class ErrorData {
    constructor(public  status: number, public code: number, public msg: string) {
    }
}

export class CoreError {
    public readonly errorData: ErrorData;

    constructor(status: number, code: number, message: string, private error?: Error) {
        this.errorData = new ErrorData(status, code, message);
    }
}

export class NotFoundError extends CoreError {
    public data: string;
    constructor(message: string, data?: string) {
        super(404, 404, message);
        this.data = data;
    }
}

export class InternalServerError extends CoreError {
    constructor(message: string, error?: any) {
        super(500, 500, message);
        if ( error ) {
            console.error(error);
        }
    }
}

export class BadRequestError extends CoreError {
    constructor(message: string) {
        super(400, 400, message);
    }
}

export class UnauthorizedError extends CoreError {
    constructor(message: string) {
        super(401, 401, message);
    }
}
