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

  } catch (error) {
    throw error;
  }
}

const getAllUsers = async (currentUser: User, search?: string) => {
  try {
    console.log('Username: ' + search);
    let users = await prismaService.user.findMany({
      where: {
        username: {
          contains: search,
          mode: 'insensitive',
        },
        NOT: {
          id: currentUser.id,
        }
      },
      select: {
        username: true,
        email: true,
        id: true,
      }
    });
    console.log(users);
    return users;

  } catch (error) {
    throw error;
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

  } catch (error) {
    throw error;
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
  console.log(user2);
}


export const userService = {
  createUser,
  getAllUsers,
  getUserById,
  updateProfileImage,
}