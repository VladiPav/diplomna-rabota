import admin from './firebase-service.js';
import { Request, Response } from 'express';
import prisma from './prisma-service.js';

const createUser = async (req: Request, res: Response) => {
    const {
        email,
        username,
        password,
    } = req.body;

    const result = await prisma.$transaction(async (tx) => {
        const firebaseUser = await admin.auth().createUser({
            email,
            password
        });

        const firebaseId = firebaseUser.uid;

        const dbUser = tx.user.create({
            data: {
                firebaseId,
                username,
                email,
            }
        });
        return { user: { ...firebaseUser, ...dbUser } };
    })

    res.send(result);
}

const getAllUsers = async (req: Request, res: Response) => {
    const users = prisma.user.findMany();
    res.send(users);
}

export default {
    createUser,
    getAllUsers
}