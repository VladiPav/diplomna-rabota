import { Request, Response } from 'express';
import { categoryService } from '../services/category';
import { CustomError, HTTPStatusCode, InternalErrorMessage } from '../types/error';


const createCategory = async (req: Request, res: Response) => {
  try {
    const {
      name,
    } = req.body;

    const category = await categoryService.createCategory(name);

    res.status(HTTPStatusCode.Created).send(category);

  } catch (e) {
    console.log(e);
    if (e instanceof CustomError) {
      res.status(e.statusCode).send(e.message);
    } else {
      res.status(HTTPStatusCode.InternalServerError).send(e);
    }
  }
};

const getAllCategories = async (req: Request, res: Response) => {
  try {
    const { name } = req.query;

    if (typeof name !== 'string' && typeof name !== 'undefined') {
      const error = {
        statusCode: HTTPStatusCode.BadRequest,
        message: 'Invalid query parameter "name"',
        internalMessage: InternalErrorMessage.BadRequest,
      };
      throw new CustomError(error);
    }

    const result = await categoryService.getAllCategories(name);

    res.status(HTTPStatusCode.Ok).send(result);

  } catch (e) {
    console.log(e);
    if (e instanceof CustomError) {
      res.status(e.statusCode).send(e.message);
    } else {
      res.status(HTTPStatusCode.InternalServerError).send(e);
    }
  }
};

export const categoryController = {
  createCategory,
  getAllCategories,
};
