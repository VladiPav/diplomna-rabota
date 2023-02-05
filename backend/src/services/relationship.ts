import { Category, Relationship, User } from "@prisma/client";
import { HTTPStatusCode, CustomError, InternalErrorMessage } from "../types/error";
import prisma from "./prisma-service";

const follow = async (follower: User, followedId: string): Promise<Relationship> => {
    try {

        const followed = await prisma.user.findFirst({
            where: {
                id: followedId,
            }
        });

        if (!followed) {
            const error = {
                statusCode: HTTPStatusCode.BadRequest,
                message: "invalid user to follow",
                internalMessage: InternalErrorMessage.BadRequest,
            };
            throw new CustomError(error);
        }

        const alreadyFollowing = await prisma.relationship.findFirst({
            where: {
                followed,
                follower,
            }
        });

        if (alreadyFollowing) {
            const error = {
                statusCode: HTTPStatusCode.BadRequest,
                message: "already following",
                internalMessage: InternalErrorMessage.BadRequest,
            };
            throw new CustomError(error);
        }

        const relationship = prisma.relationship.create({
            data: {
                followed: {
                    connect: followed,
                },
                follower: {
                    connect: follower,
                },
            }
        });

        return relationship;

    } catch (error) {
        throw error;
    }
}

const unfollow = async (follower: User, followedId: string): Promise<void> => {
    try {

        const followed = await prisma.user.findFirst({
            where: {
                id: followedId,
            }
        });

        if (!followed) {
            const error = {
                statusCode: HTTPStatusCode.BadRequest,
                message: "invalid user to unfollow",
                internalMessage: InternalErrorMessage.BadRequest,
            };
            throw new CustomError(error);
        }

        const alreadyFollowing = await prisma.relationship.findFirst({
            where: {
                followed,
                follower,
            }
        });

        if (!alreadyFollowing) {
            const error = {
                statusCode: HTTPStatusCode.BadRequest,
                message: "already following",
                internalMessage: InternalErrorMessage.BadRequest,
            };
            throw new CustomError(error);
        }

        prisma.relationship.delete({
            where: alreadyFollowing
        });

    } catch (error) {
        throw error;
    }
}

const getFollowedUsers = async (user: User): Promise<Relationship[]> => {
    return prisma.relationship.findMany({
        where: {
            followerId: user.id,
        },
    });
}

const getFollowingUsers = async (user: User): Promise<Relationship[]> => {
    return prisma.relationship.findMany({
        where: {
            followedId: user.id,
        },
    });
}



export const relationshipService = {
    follow,
    unfollow,
    getFollowedUsers,
    getFollowingUsers,
}