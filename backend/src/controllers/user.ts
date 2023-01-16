import { Request, Response } from "express";
import { PrismaClient } from "@prisma/client";
import userService from "../services/user.js"

const prisma = new PrismaClient();

const createUser = async (req: Request, res: Response) => {
    userService.createUser(req, res);
}

const getAllUsers = async (req: Request, res: Response) => {
    console.log("Hello");
    userService.getAllUsers(req, res);
}

const getUserById = async (req: Request, res: Response) => {

}

const deleteUser = async (req: Request, res: Response) => {

}

export default {
    createUser,
    getAllUsers,
    getUserById,
    deleteUser
}