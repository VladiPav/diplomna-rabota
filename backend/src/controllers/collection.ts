import { Request, Response } from "express";
import { collectionService } from '../services/collection';
import { CustomError, HTTPStatusCode, InternalErrorMessage } from "../types/error";


const createCollection = async (req: Request, res: Response) => {
    try {
        const {
            name,
            categoryId,
        } = req.body;

        console.log(name);
        console.log(categoryId);

        const collection = await collectionService.createCollection(name, res.locals.currentUser.id, categoryId);

        res.status(HTTPStatusCode.Created).send(collection);

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

const addElementToCollection = async (req: Request, res: Response) => {
    try {
        const collectionId = req.params.id;

        if (!collectionId) {
            const error = {
                statusCode: HTTPStatusCode.BadRequest,
                message: "You must provide collection id",
                internalMessage: InternalErrorMessage.BadRequest,
            };
            throw new CustomError(error);
        }

        const {
            elementId,
            position,
        } = req.body;

        if (!elementId || !position) {
            const error = {
                statusCode: HTTPStatusCode.BadRequest,
                message: "You must provide elementId and position",
                internalMessage: InternalErrorMessage.BadRequest,
            };
            throw new CustomError(error);
        }

        // const collection = await collectionService.getCollectionById(collectionId);
        
        const result = await collectionService.addElementToCollection(elementId, collectionId, position);



        res.status(HTTPStatusCode.Created).json(result);

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
    createCollection,
    getCollectionById,
    addElementToCollection,
}