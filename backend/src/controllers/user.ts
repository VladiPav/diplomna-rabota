import { Request, Response } from "express";
import { userService } from "../services/user"
import { CustomError, HTTPStatusCode, InternalErrorMessage } from "../types/error";
import path from "path";

const createUser = async (req: Request, res: Response) => {
  try {
    const {
      email,
      username,
      firebaseId,
    } = req.body;

    if (!email || !username || !firebaseId) {
      const error = {
        statusCode: HTTPStatusCode.BadRequest,
        message: "Invalid input",
        internalMessage: InternalErrorMessage.BadRequest,
      };
      throw new CustomError(error);
    }

    const user = await userService.createUser({ email, username, firebaseId });

    res.send(user);

  } catch (e) {
    if (e instanceof CustomError) {
      res.status(e.statusCode).send(e.message);
    } else {
      res.send(e).status(HTTPStatusCode.InternalServerError);
    }
  }

}

const uploadProfileImage = async (req: Request, res: Response) => {
  try {
    if (!req.file?.path) {
      const error = {
        statusCode: HTTPStatusCode.BadRequest,
        message: "Image path is undefined",
        internalMessage: InternalErrorMessage.BadRequest,
      };
      throw new CustomError(error);
    }

    const imagePath = (req.file?.path).split(path.sep).join(path.posix.sep);;
    console.log(req.file?.path);
    console.log(imagePath);
    userService.updateProfileImage(res.locals.currentUser, imagePath);
    res.status(HTTPStatusCode.Created).json(imagePath);
  }
  catch (e) {
    if (e instanceof CustomError) {
      res.status(e.statusCode).send(e.message);
    } else {
      res.status(HTTPStatusCode.InternalServerError).send(e);
    }
  }
}

const getAllUsers = async (req: Request, res: Response) => {
  try {
    const { username } = req.query;

    if (typeof username !== 'string' && typeof username !== 'undefined') {
      const error = {
        statusCode: HTTPStatusCode.BadRequest,
        message: 'Invalid query parameter "username"',
        internalMessage: InternalErrorMessage.BadRequest,
      };
      throw new CustomError(error);
    }

    const result = await userService.getAllUsers(res.locals.currentUser, username);

    res.send(result);

  } catch (e) {
    if (e instanceof CustomError) {
      res.status(e.statusCode).send(e.message);
    } else {
      res.status(HTTPStatusCode.InternalServerError).send(e);
    }
  }
}

const getUserById = async (req: Request, res: Response) => {

}

const getCurrentUser = async (req: Request, res: Response) => {
  try {
    const response = {
      id: res.locals.currentUser.id,
      email: res.locals.currentUser.email,
      username: res.locals.currentUser.username,
      collections: res.locals.currentUser.collections,
      profileImagePath: res.locals.currentUser.profileImagePath
    }
    res.json(response);
  } catch (e) {
    if (e instanceof CustomError) {
      res.status(e.statusCode).send(e.message);
    } else {
      res.status(HTTPStatusCode.InternalServerError).send(e);
    }
  }
}

const deleteUser = async (req: Request, res: Response) => {

}


export const userController = {
  createUser,
  uploadProfileImage,
  getAllUsers,
  getUserById,
  getCurrentUser,
  deleteUser,
}