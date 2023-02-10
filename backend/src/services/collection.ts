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

export const collectionService = {
    createCollection,

}