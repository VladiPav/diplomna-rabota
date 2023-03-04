import { CustomError, HTTPStatusCode, InternalErrorMessage } from "../types/error";
import { CollectionElement, Prisma } from "@prisma/client";
import { prismaService } from "./prisma-service";

const createCollection = async (name: string, userId: string, categoryId: string) => {
  try {
    const collectionAlreadyExists = await prismaService.collection.findFirst({
      where: {
        name: name,
        userId: userId,
      },
    });

    if (collectionAlreadyExists) {
      const error = {
        statusCode: HTTPStatusCode.BadRequest,
        message: "Collection already exists on your profile",
        internalMessage: InternalErrorMessage.BadRequest,
      };
      throw new CustomError(error);
    }

    const collection = await prismaService.collection.create({
      data: {
        name: name,
        user: {
          connect: {
            id: userId,
          },
        },
        category: {
          connect: {
            id: categoryId,
          },
        },
      },
    });

    return collection;

  } catch (e) {
    throw e;
  }
}

const reorderCollection = async (collectionId: string, reorderedCollection: CollectionElement[]) => {
  try {
    await prismaService.$transaction(async (prisma) => {
      for (let i = 0; i < reorderedCollection.length; i++) {
        console.log('\x1b[41m hello \x1b[0m');
        await prisma.collectionElement.updateMany({
          where: {
            collectionId: collectionId,
            elementId: reorderedCollection[i].elementId,
          },
          data: {
            position: `${i + 1}`,
          }
        });
      }


    });

  } catch (e) {
    throw e;
  }
}

const getCollectionById = async (id: string) => {
  try {
    const collection = await prismaService.collection.findFirst({
      where: {
        id: id,
      },
      include: {
        collectionElements: {
          include: {
            element: true,
          },
        }
      }
    },
    );

    return collection;

  } catch (e) {
    throw e;
  }
}

const addElementToCollection = async (elementId: string, collectionId: string, position: string) => {
  try {
    const collectionElement = await prismaService.collectionElement.create({
      data: {
        elementId: elementId,
        collectionId: collectionId,
        position: position,
      },
    });

    return collectionElement;

  } catch (e) {
    throw e;
  }
}

const removeElementFromCollection = async (elementId: string, collectionId: string) => {
  try {

    const result = await prismaService.collectionElement.deleteMany({
      where: {
        elementId: elementId,
        collectionId: collectionId,
      }
    });

    return result;

  } catch (e) {
    throw e;
  }
}

const deleteCollection = async (id: string) => {
  try {
    await prismaService.collection.delete({
      where: {
        id: id
      }
    });
  } catch (e) {
    if (e instanceof Prisma.PrismaClientKnownRequestError) {
      if (e.code === 'P2025') {
        const error = {
          statusCode: HTTPStatusCode.BadRequest,
          message: "Collection to delete doesn't exist",
          internalMessage: InternalErrorMessage.BadRequest,
        };
        throw new CustomError(error);
      }
      throw e;
    }
  }
}


export const collectionService = {
  createCollection,
  getCollectionById,
  reorderCollection,
  addElementToCollection,
  removeElementFromCollection,
  deleteCollection,
}