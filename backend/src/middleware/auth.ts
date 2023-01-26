import firebase from 'firebase-admin';
import { Request, Response, NextFunction } from "express";
import { CustomError, HTTPStatusCode, InternalErrorMessage } from 'src/types/error';

const verifyToken = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const header = req.headers.authorization;
        const token = header?.split(' ')[1];

        if (!token) {
            const error = {
                statusCode: HTTPStatusCode.Forbidden,
                message: "No auth token",
                internalMessage: InternalErrorMessage.BadRequest,
            };
            throw error;
        }

        const decodedToken = firebase.auth().verifyIdToken(token);

        next()

    } catch (error) {
        if (error instanceof CustomError) {
            res.send(error).status(error.statusCode);
        } else {
            res.send(error).status(HTTPStatusCode.InternalServerError);
        }
    }
}

export const auth = { verifyToken };