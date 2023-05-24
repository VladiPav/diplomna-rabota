import { Relationship, User } from '@prisma/client';
import { HTTPStatusCode, CustomError, InternalErrorMessage } from '../types/error';
import { prismaService } from './prisma-service';

const follow = async (follower: User, followedId: string) => {

  const followed = await prismaService.user.findFirst({
    where: {
      id: followedId,
    }
  });

  if (!followed) {
    const error = {
      statusCode: HTTPStatusCode.BadRequest,
      message: 'invalid user to follow',
      internalMessage: InternalErrorMessage.BadRequest,
    };
    throw new CustomError(error);
  }

  const alreadyFollowing = await prismaService.relationship.findFirst({
    where: {
      followed: {
        id: followed.id,
      },
      follower: {
        id: follower.id,
      },
    }
  });

  if (alreadyFollowing) {
    const error = {
      statusCode: HTTPStatusCode.BadRequest,
      message: 'already following',
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

};


const unfollow = async (follower: User, followedId: string) => {

  const followed = await prismaService.user.findFirst({
    where: {
      id: followedId,
    }
  });

  if (!followed) {
    const error = {
      statusCode: HTTPStatusCode.BadRequest,
      message: 'invalid user to unfollow',
      internalMessage: InternalErrorMessage.BadRequest,
    };
    throw new CustomError(error);
  }

  const alreadyFollowing = await prismaService.relationship.findFirst({
    where: {
      followed: {
        id: followed.id,
      },
      follower: {
        id: follower.id,
      },
    }
  });

  if (!alreadyFollowing) {
    const error = {
      statusCode: HTTPStatusCode.BadRequest,
      message: 'you are not following this user',
      internalMessage: InternalErrorMessage.BadRequest,
    };
    throw new CustomError(error);
  }

  await prismaService.relationship.delete({
    where: {
      id: alreadyFollowing.id,
    }
  });
};

const getFollowedUsers = async (user: User): Promise<Relationship[]> => {
  const followed = await prismaService.relationship.findMany({
    where: {
      followerId: user.id,
    },
    include: {
      followed: {
        include: {
          collections: {
            include: {
              collectionElements: {
                include: {
                  element: true,
                },
              },
            },
          },
        },
      },
    },
  });
  return followed;
};

const getFollowingUsers = async (user: User): Promise<Relationship[]> => {
  return await prismaService.relationship.findMany({
    where: {
      followedId: user.id,
    },
    include: {
      follower: {
        include: {
          collections: {
            include: {
              collectionElements: {
                include: {
                  element: true,
                },
              },
            },
          },
        },
      },
    }
  });
};

const isFollowing = async (followerId: string, followedId: string): Promise<boolean> => {
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
};



export const relationshipService = {
  follow,
  unfollow,
  getFollowedUsers,
  getFollowingUsers,
  isFollowing,
};