import { initializeApp } from 'firebase-admin/app';
import { getAuth } from 'firebase-admin/auth';
import { Request, Response, NextFunction } from "express";
import { CustomError, HTTPStatusCode, InternalErrorMessage } from '../types/error';
import { prismaService } from '../services/prisma-service';


const verifyToken = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {

        if (req.path == '/users' && req.method == 'POST') {
            return next();
        }

        const header = req.headers.authorization;
        const token = header?.split(' ')[1];

        if (!token) {
            const error = {
                statusCode: HTTPStatusCode.Forbidden,
                message: "No auth token",
                internalMessage: InternalErrorMessage.BadRequest,
            };
            throw new CustomError(error);
        }


        const decodedToken = await getAuth().verifyIdToken(token);
        console.log(token);

        res.locals.currentUser = await prismaService.user.findFirst({
            where: {
                firebaseId: decodedToken.uid
            },
            include: {
              collections: {
                include: {
                  collectionElements: {
                    include: {
                      element: true,
                    },
                  },
                },
              },
            },
        });

        return next()

    } catch (error) {
        console.log(error);
        if (error instanceof CustomError) {
            res.status(error.statusCode).send(error.message);
        } else {
            res.status(HTTPStatusCode.InternalServerError).send(error);
        }
    }
}

export const authMiddleware = verifyToken;



