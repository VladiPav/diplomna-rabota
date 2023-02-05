import { Request, Response } from "express";
import { PrismaClient } from "@prisma/client";
import userService from "../services/user"
import { CustomError, HTTPStatusCode } from "../types/error";

const prisma = new PrismaClient();

// const createUser = async (req: Request, res: Response) => {
//   try {
//     const {
//       email,
//       username,
//       firebaseId,
//     } = req.body;

//     if (!email) {

//     }

//     userService.createUser({ email, username, firebaseId });

//   } catch (e) {
//     if (e instanceof CustomError) {
//       res.send(e).status(e.statusCode);
//     } else {
//       res.send(e).status(HTTPStatusCode.InternalServerError);
//     }
//   }

// }

const getAllUsers = async (req: Request, res: Response) => {
  userService.getAllUsers();
}

const getUserById = async (req: Request, res: Response) => {

}

const deleteUser = async (req: Request, res: Response) => {

}

export const userController = {
  // createUser,
  getAllUsers,
  getUserById,
  deleteUser
}