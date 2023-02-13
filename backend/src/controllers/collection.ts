import { Request, Response } from "express";
import { collectionService } from '../services/collection';
import { CustomError, HTTPStatusCode, InternalErrorMessage } from "../types/error";


const createCategory = (req: Request, res: Response) => {
    try {
        const {
            name,
        } = req.body;


    } catch (e) {
        if (e instanceof CustomError) {
            res.status(e.statusCode).send(e.message);
        } else {
            res.send(e).status(HTTPStatusCode.InternalServerError);
        }
    }
}