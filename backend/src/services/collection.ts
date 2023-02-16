import { prismaService } from "./prisma-service";

const createCollection = async () => {
  try {

  } catch (error) {

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

export const collectionService = {
  createCollection,
  getCollectionById,
}