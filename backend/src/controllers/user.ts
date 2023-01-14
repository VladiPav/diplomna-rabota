import { Request, Response } from "express";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

const createUser = async (req: Request, res: Response) => {

    const user = await prisma.user.create({
        data: {
            username: req.body.username,
            email: req.body.email,
        }
    })
}

const getUserById = async (req: Request, res: Response) => {

}

const getAllUsers = async (req: Request, res: Response) => {

}

const deleteUser = async (req: Request, res: Response) => {

}