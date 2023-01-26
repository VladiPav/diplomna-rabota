import { Category } from "@prisma/client";
import { HTTPStatusCode, CustomError, InternalErrorMessage } from "src/types/error";
import prisma from "./prisma-service";

const createCategory = async (name: string): Promise<Category> => {
    try {
        const categoryAlreadyExists = await prisma.category.findFirst({
            where: {
                name,
            }
        });

        if (categoryAlreadyExists) {
            const error = {
                statusCode: HTTPStatusCode.BadRequest,
                message: "category already exists",
                internalMessage: InternalErrorMessage.BadRequest,
            };
            throw new CustomError(error);
        }

        const category = prisma.category.create({
            data: {
                name,
            }
        });

        return category;
    } catch (error) {
        throw error;
    }
}

const getAllCategories = (name?: string): Promise<Category[]> => {
    try {
        const categories = prisma.category.findMany({
            where: {
                name: {
                    contains: name
                }
            }
        });

        return categories;

    } catch (error) {
        throw error;
    }
}


export const categoryService = {
    createCategory,
    getAllCategories,
}