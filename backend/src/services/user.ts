import { User } from '@prisma/client';
import { Request, Response } from 'express';
import { CustomError, HTTPStatusCode, InternalErrorMessage } from 'src/types/error.js';
import prisma from './prisma-service.js';

const createUser = async (userCreateInfo: userCreateInfo): Promise<User> => {
  try {
    const {
      email,
      username,
      firebaseId
    } = userCreateInfo;

    const userAlreadyExists = await prisma.user.findFirst({
      where: { firebaseId }
    });

    if (userAlreadyExists) {
      const error = {
        statusCode: HTTPStatusCode.BadRequest,
        message: "User already exists",
        internalMessage: InternalErrorMessage.BadRequest,
      };
      throw new CustomError(error);
    }

    const user = prisma.user.create({
      data: {
        email,
        username,
        firebaseId
      }
    });

    return user;

  } catch (error) {
    throw error;
  }
}

const getAllUsers = async () => {
  const users = prisma.user.findMany();
  return users;
}

const getUserById = async () => {

}



export default {
  createUser,
  getAllUsers
}