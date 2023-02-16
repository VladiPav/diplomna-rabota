import { Category, Relationship, User } from "@prisma/client";
import { HTTPStatusCode, CustomError, InternalErrorMessage } from "../types/error";
import { prismaService } from "./prisma-service";

const follow = async (follower: User, followedId: string) => {
    try {

        const followed = await prismaService.user.findFirst({
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

        const alreadyFollowing = await prismaService.relationship.findFirst({
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

        const relationship = await prismaService.relationship.create({
            data: {
                followed: {
                    connect: {
                        id: followed.id,
                    },
                },
                follower: {
                    connect: {
                        id: follower.id,
                    },
                },
            }
        });

        return relationship;

    } catch (error) {
        throw error;
    }
}


const unfollow = async (follower: User, followedId: string) => {
    try {

        const followed = await prismaService.user.findFirst({
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

        const alreadyFollowing = await prismaService.relationship.findFirst({
            where: {
                followed,
                follower,
            }
        });

        if (!alreadyFollowing) {
            const error = {
                statusCode: HTTPStatusCode.BadRequest,
                message: "you are not following this user",
                internalMessage: InternalErrorMessage.BadRequest,
            };
            throw new CustomError(error);
        }

        await prismaService.relationship.delete({
            where: {
                id: alreadyFollowing.id,
            }
        });



    } catch (error) {
        throw error;
    }
}

const getFollowedUsers = async (user: User): Promise<Relationship[]> => {
    try {
        const followed = await prismaService.relationship.findMany({
            where: {
                followerId: user.id,
            },
            include: {
                followed: true,
            }
        });
        return followed;

    } catch (error) {
        throw error;
    }
}

const getFollowingUsers = async (user: User): Promise<Relationship[]> => {
    return await prismaService.relationship.findMany({
        where: {
            followedId: user.id,
        },
    });
}

const isFollowing = async (followerId: string, followedId: string): Promise<boolean> => {
    try {
        const relationship = await prismaService.relationship.findFirst({
            where: {
                followerId: followerId,
                followedId: followedId,
            }
        });
        if (relationship) {
            return true;
        }
        return false;
    } catch (error) {
        throw error;
    }
}



export const relationshipService = {
    follow,
    unfollow,
    getFollowedUsers,
    getFollowingUsers,
    isFollowing,
}