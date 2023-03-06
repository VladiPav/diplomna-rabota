import { Request, Response } from "express";
import { elementService } from "../services/element";
import { CustomError, HTTPStatusCode, InternalErrorMessage } from "../types/error";


const createElement = async (req: Request, res: Response) => {
    try {
        const {
            name,
            categoryId,
        } = req.body;

        console.log(name);
        console.log(categoryId);

        const element = await elementService.createElement(name, categoryId);

        res.status(HTTPStatusCode.Created).send(element);

    } catch (e) {
        console.log(e);
        if (e instanceof CustomError) {
            res.status(e.statusCode).send(e.message);
        } else {
            res.status(HTTPStatusCode.InternalServerError).send(e);
        }
    }
}

const getElementsByCategory = async (req: Request, res: Response) => {
    try {
        const {
            name,
            categoryId,
            collectionId,
        } = req.query;

        if (typeof name !== 'string' && typeof name !== 'undefined') {
            const error = {
                statusCode: HTTPStatusCode.BadRequest,
                message: 'Invalid query parameter "name"',
                internalMessage: InternalErrorMessage.BadRequest,
            };
            throw new CustomError(error);
        }

        if (typeof collectionId !== 'string' && typeof collectionId !== 'undefined') {
            const error = {
                statusCode: HTTPStatusCode.BadRequest,
                message: 'Invalid query parameter "collectionId"',
                internalMessage: InternalErrorMessage.BadRequest,
            };
            throw new CustomError(error);
        }

        if (typeof categoryId !== 'string') {
            const error = {
                statusCode: HTTPStatusCode.BadRequest,
                message: 'Invalid query parameter "categoryId"',
                internalMessage: InternalErrorMessage.BadRequest,
            };
            throw new CustomError(error);
        }

        const elements = await elementService.getElementsByCategory(categoryId, name, collectionId);

        res.status(HTTPStatusCode.Ok).send(elements);

    } catch (e) {
        console.log(e);
        if (e instanceof CustomError) {
            res.status(e.statusCode).send(e.message);
        } else {
            res.status(HTTPStatusCode.InternalServerError).send(e);
        }
    }
}

const deleteElement = async  (req: Request, res: Response) => {
  try {
  } catch(e) {
    if (e instanceof CustomError) {
      res.status(e.statusCode).send(e.message);
    } else {
      res.status(HTTPStatusCode.InternalServerError).send(e);
    }
  }
}

export const elementController = {
    createElement,
    getElementsByCategory,
}