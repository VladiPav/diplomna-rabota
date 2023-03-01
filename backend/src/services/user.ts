import { User } from '@prisma/client';
import { CustomError, HTTPStatusCode, InternalErrorMessage } from '../types/error';
import { prismaService } from './prisma-service';
import { UserCreateInfo } from '../types/customTypes';

function exclude<User, Key extends keyof User>(
  user: User,
  keys: Key[]
): Omit<User, Key> {
  for (let key of keys) {
    delete user[key]
  }
  return user
}

const createUser = async (userCreateInfo: UserCreateInfo): Promise<User> => {
  try {
    const {
      email,
      username,
      firebaseId
    } = userCreateInfo;

    const userAlreadyExists = await prismaService.user.findFirst({
      where: { OR: [{ firebaseId }, { email }, { username }] }
    });

    if (userAlreadyExists) {
      const error = {
        statusCode: HTTPStatusCode.BadRequest,
        message: "User already exists",
        internalMessage: InternalErrorMessage.BadRequest,
      };
      throw new CustomError(error);
    }

    const user = await prismaService.user.create({
      data: {
        email,
        username,
        firebaseId
      }
    });

    return user;

  } catch (e) {
    throw e;
  }
}

const getAllUsers = async (currentUser: User, query?: string) => {
  try {
    let users = await prismaService.user.findMany({
      where: {
        username: {
          contains: query,
          mode: 'insensitive',
        },
        NOT: {
          id: currentUser.id,
        }
      },
      include: {
        collections: {
          include: {
            collectionElements: {
              include: {
                element: true,
              }
            }
          }
        }
      }
    });
    return users;

  } catch (e) {
    throw e;
  }
}

const getUserById = async (id: string) => {
  try {
    const user = await prismaService.user.findFirst({
      where: { id },
      include: {
        collections: {
          include: {
            category: true,
          }
        },
      }
    });

    return user;

  } catch (e) {
    throw e;
  }
}

const updateProfileImage = async (user: User, imagePath: string) => {
  const user2 = await prismaService.user.update({
    where: {
      id: user.id
    },
    data: {
      profileImagePath: imagePath
    }
  });
}


export const userService = {
  createUser,
  getAllUsers,
  getUserById,
  updateProfileImage,
}