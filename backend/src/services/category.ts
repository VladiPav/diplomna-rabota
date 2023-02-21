import { Category } from "@prisma/client";
import { HTTPStatusCode, CustomError, InternalErrorMessage } from "../types/error";
import { prismaService } from "./prisma-service";

const createCategory = async (name: string): Promise<Category> => {
    try {
        const categoryAlreadyExists = await prismaService.category.findFirst({
            where: {
                name: name,
            }
        });
      

        if (categoryAlreadyExists) {
            const error = {
                statusCode: HTTPStatusCode.BadRequest,
                message: "Category already exists",
                internalMessage: InternalErrorMessage.BadRequest,
            };
            throw new CustomError(error);
        }

        const category = prismaService.category.create({
            data: {
                name: name,
            }
        });

        return category;
    } catch (error) {
        throw error;
    }
}

const getAllCategories = (name?: string): Promise<Category[]> => {
    try {
        const categories = prismaService.category.findMany({
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