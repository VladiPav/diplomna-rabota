import { CustomError, HTTPStatusCode, InternalErrorMessage } from '../types/error';
import { CollectionElement, Prisma } from '@prisma/client';
import { prismaService } from './prisma-service';

const createCollection = async (name: string, userId: string, categoryId: string) => {
  const collectionAlreadyExists = await prismaService.collection.findFirst({
    where: {
      name: name,
      userId: userId,
    },
  });
  if (collectionAlreadyExists) {
    const error = {
      statusCode: HTTPStatusCode.BadRequest,
      message: 'Collection already exists on your profile',
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
};

const reorderCollection = async (collectionId: string, reorderedCollection: CollectionElement[]) => {
  await prismaService.$transaction(async (prisma) => {
    for (let i = 0; i < reorderedCollection.length; i++) {
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

};

const getCollectionById = async (id: string) => {
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

};

const addElementToCollection = async (elementId: string, collectionId: string, position: string) => {
  const collectionElement = await prismaService.collectionElement.create({
    data: {
      elementId: elementId,
      collectionId: collectionId,
      position: position,
    },
  });

  return collectionElement;
};

const removeElementFromCollection = async (elementId: string, collectionId: string) => {

  const result = await prismaService.collectionElement.deleteMany({
    where: {
      elementId: elementId,
      collectionId: collectionId,
    }
  });

  return result;

};

const deleteCollection = async (id: string) => {
  try {
    console.log('DELETING');
    const deleted = await prismaService.collection.delete({
      where: {
        id: id
      }
    });
    console.log('DELETED: ' + deleted);
  } catch (e) {
    console.log(e);
    if (e instanceof Prisma.PrismaClientKnownRequestError) {
      if (e.code === 'P2025') {
        const error = {
          statusCode: HTTPStatusCode.BadRequest,
          message: 'Collection to delete doesn\'t exist',
          internalMessage: InternalErrorMessage.BadRequest,
        };
        throw new CustomError(error);
      }
      throw e;
    }
  }
};


export const collectionService = {
  createCollection,
  getCollectionById,
  reorderCollection,
  addElementToCollection,
  removeElementFromCollection,
  deleteCollection,
};