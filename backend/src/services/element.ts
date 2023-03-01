import { Element } from "@prisma/client";
import { CustomError, HTTPStatusCode, InternalErrorMessage } from "../types/error";
import { prismaService } from "./prisma-service";

const createElement = async (name: string, categoryId: string): Promise<Element> => {
    try {

        const category = await prismaService.category.findFirst({
            where: {
                id: categoryId,
            }
        });

        if (!category) {
            const error = {
                statusCode: HTTPStatusCode.BadRequest,
                message: "Category not found",
                internalMessage: InternalErrorMessage.BadRequest,
            };
            throw new CustomError(error);
        }

        const elementAlreadyExists = await prismaService.element.findFirst({
            where: {
                name,
                category,
            },
        });

        if (elementAlreadyExists) {
            const error = {
                statusCode: HTTPStatusCode.BadRequest,
                message: "element already exists",
                internalMessage: InternalErrorMessage.BadRequest,
            };
            throw new CustomError(error);
        }

        const element = await prismaService.element.create({
            data: {
                name,
                category: {
                    connect: { id: category.id },
                }
            }
        });

        return element;

    } catch (e) {
        throw e;
    }
}

const getElementsByCategory = async (categoryId: string, query?: string, collectionId?: string): Promise<Element[]> => {
    try {

        const category = await prismaService.category.findFirst({
            where: {
                id: categoryId,
            }
        });

        if (!category) {
            const error = {
                statusCode: HTTPStatusCode.BadRequest,
                message: "Category not found",
                internalMessage: InternalErrorMessage.BadRequest,
            };
            throw new CustomError(error);
        }
        console.log(collectionId);

        const elements = await prismaService.element.findMany({
            where: {
                categoryId: categoryId,
                name: {
                    contains: query,
                },
                collectionElements: {
                    every: {
                        NOT: {
                            collectionId: collectionId,
                        }
                    }
                }
            },
        });


        return elements;

    } catch (e) {
        throw e;
    }
}

const deleteElement = async () => {
    try {

    } catch (e) {
        throw e;
    }
}

export const elementService = {
    createElement,
    getElementsByCategory,
}