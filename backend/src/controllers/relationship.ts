import { Request, Response } from 'express';
import { relationshipService } from '../services/relationship';
import { CustomError, HTTPStatusCode, InternalErrorMessage } from '../types/error';


const follow = async (req: Request, res: Response) => {
  try {
    const followedId = req.params.id;

    const result = await relationshipService.follow(res.locals.currentUser, followedId);

    res.status(HTTPStatusCode.Created).send(result);

  } catch (e) {
    if (e instanceof CustomError) {
      console.log(e);
      res.status(e.statusCode).send(e.message);
    } else {
      res.status(HTTPStatusCode.InternalServerError).send(e);
    }
  }
};


const unfollow = async (req: Request, res: Response) => {
  try {

    const followedId = req.params.id;

    await relationshipService.unfollow(res.locals.currentUser, followedId);

    res.status(200).send();

  } catch (e) {
    if (e instanceof CustomError) {
      console.log(e);
      res.status(e.statusCode).send(e.message);
    } else {
      res.status(HTTPStatusCode.InternalServerError).send(e);
    }
  }
};

const getFollowedUsers = async (req: Request, res: Response) => {
  try {
    const followedUsers = await relationshipService.getFollowedUsers(res.locals.currentUser);
    res.json(followedUsers);
  } catch (e) {
    console.log(e);
    if (e instanceof CustomError) {
      res.status(e.statusCode).send(e.message);
    } else {
      res.status(HTTPStatusCode.InternalServerError).send(e);
    }
  }
};

const getFollowingUsers = async (req: Request, res: Response) => {
  try {
    const followingUsers = await relationshipService.getFollowingUsers(res.locals.currentUser);
    res.json(followingUsers);

  } catch (e) {
    console.log(e);
    if (e instanceof CustomError) {
      res.status(e.statusCode).send(e.message);
    } else {
      res.status(HTTPStatusCode.InternalServerError).send(e);
    }
  }
};

const isFollowing = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;

    if (!id) {
      const error = {
        statusCode: HTTPStatusCode.BadRequest,
        message: 'You must provide id',
        internalMessage: InternalErrorMessage.BadRequest,
      };
      throw new CustomError(error);
    }

    const isFollowing = await relationshipService.isFollowing(res.locals.currentUser.id, id);
    res.status(HTTPStatusCode.Ok).json(isFollowing);

  } catch (e) {
    console.log(e);
    if (e instanceof CustomError) {
      res.status(e.statusCode).send(e.message);
    } else {
      res.status(HTTPStatusCode.InternalServerError).send(e);
    }
  }
};
export const relationshipController = {
  follow,
  unfollow,
  getFollowedUsers,
  getFollowingUsers,
  isFollowing,
};
