import { Element } from "@prisma/client";
import { CustomError, HTTPStatusCode, InternalErrorMessage } from "src/types/error";
import prisma from "./prisma-service";

const createElement = async (name: string, categoryId: string): Promise<Element> => {
    try {

        const category = await prisma.category.findFirst({
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

        const elementAlreadyExists = await prisma.element.findFirst({
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

        const element = prisma.element.create({
            data: {
                name,
                category: {
                    connect: category
                }
            }
        });

        return element;

    } catch (error) {
        throw error;
    }
}