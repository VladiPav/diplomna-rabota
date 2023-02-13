import { Request, Response } from "express";
import { userService } from "../services/user"
import { CustomError, HTTPStatusCode, InternalErrorMessage } from "../types/error";

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
    res.status(HTTPStatusCode.Created).json(req.file?.path);
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
    return res.locals.currentUser;
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