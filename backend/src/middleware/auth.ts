import firebase from 'firebase-admin';
import { Request, Response, NextFunction } from "express";
import { CustomError, HTTPStatusCode, InternalErrorMessage } from '../types/error';
import prisma from '../services/prisma-service';

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

        const decodedToken = await firebase.auth().verifyIdToken(token);

        res.locals.currentUser = prisma.user.findFirst({
            where: {
                firebaseId: decodedToken.uid
            },
        },);

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