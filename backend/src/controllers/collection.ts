import { Request, Response } from "express";
import { collectionService } from '../services/collection';
import { CustomError, HTTPStatusCode, InternalErrorMessage } from "../types/error";


const createCategory = async (req: Request, res: Response) => {
    try {
        const {
            name,
        } = req.body;


    } catch (e) {
        console.log(e);
        if (e instanceof CustomError) {
            res.status(e.statusCode).send(e.message);
        } else {
            res.send(e).status(HTTPStatusCode.InternalServerError);
        }
    }
}

const getCollectionById = async (req: Request, res: Response) => {
    try {
        const {
            id,
        } = req.params;

        if (!id) {
            const error = {
                statusCode: HTTPStatusCode.BadRequest,
                message: "You must provide id",
                internalMessage: InternalErrorMessage.BadRequest,
            };
            throw new CustomError(error);
        }

        const collection = await collectionService.getCollectionById(id);
        console.log('COLLECTION:');
        console.log(collection);

        res.status(HTTPStatusCode.Ok).json(collection);

    } catch (e) {
        console.log(e);
        if (e instanceof CustomError) {
            res.status(e.statusCode).send(e.message);
        } else {
            res.send(e).status(HTTPStatusCode.InternalServerError);
        }
    }
}

export const collectionController = {
    createCategory,
    getCollectionById,
}