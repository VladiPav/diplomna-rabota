import { CustomError, HTTPStatusCode, InternalErrorMessage } from "../types/error";
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

  } catch (error) {
    throw error;
  }
}

const reorderCollection = async (collectionId: string, newPostitions: string[]) => {
  try {


    // prismaService.$transaction(async (prisma) => {
    //     for (let i in newPostitions) {
    //         await prisma.collectionElement.update({
    //             where: {
    //                 id
    //             }
    //         });
    //     }
    // })
  } catch (error) {
    throw error;
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

const addElementToCollection = async(elementId: string, collectionId: string, position: string) => {
  try {
    const collectionElement = await prismaService.collectionElement.create({
      data: {
        elementId: elementId,
        collectionId: collectionId,
        position:position,
      },
    });

    return collectionElement;

  } catch (e) {
    throw e;
  }
}

export const collectionService = {
  createCollection,
  getCollectionById,
  addElementToCollection,
}