import { Response } from "express";

function getOutData(res: Response) {
    return (data: any) => {
        res.status(200)
            .json({
                data: data
            });
    };
}
function isEmptyObject(obj: object) {
    let name;
    for (name in obj) {
        if (obj.hasOwnProperty(name)) {
            return false;
        }
    }
    return true;
}

module.exports = {
    getOutData,
    isEmptyObject
};
