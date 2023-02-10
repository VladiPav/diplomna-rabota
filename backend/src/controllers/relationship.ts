import { Request, Response } from "express";
import { relationshipService } from '../services/relationship';
import { CustomError, HTTPStatusCode, InternalErrorMessage } from "../types/error";


const follow = (req: Request, res: Response) => {
    try {

        const followedId = req.params.id;

        relationshipService.follow(res.locals.currentUser, followedId);


    } catch (e) {
        if (e instanceof CustomError) {
            res.status(e.statusCode).send(e.message);
        } else {
            res.status(HTTPStatusCode.InternalServerError).send(e);
        }
    }
}


const unfollow = (req: Request, res: Response) => {
    try {

        const followedId = req.params.id;

        relationshipService.unfollow(res.locals.currentUser, followedId);

    } catch (e) {
        if (e instanceof CustomError) {
            res.status(e.statusCode).send(e.message);
        } else {
            res.send(e).status(HTTPStatusCode.InternalServerError);
        }
    }
}

const getFollowedUsers = async (req: Request, res: Response) => {
    try {
        const followedUsers = await relationshipService.getFollowedUsers(res.locals.currentUser);

        console.log(followedUsers);

        res.json(followedUsers);
    } catch (e) {
        if (e instanceof CustomError) {
            res.status(e.statusCode).send(e.message);
        } else {
            res.send(e).status(HTTPStatusCode.InternalServerError);
        }
    }
}

const getFollowingUsers = async (req: Request, res: Response) => {
    try {
        const followingUsers = await relationshipService.getFollowingUsers(res.locals.currentUser);
        console.log(followingUsers);
        res.json(followingUsers);

    } catch (e) {
        if (e instanceof CustomError) {
            res.status(e.statusCode).send(e.message);
        } else {
            res.send(e).status(HTTPStatusCode.InternalServerError);
        }
    }
}

export const relationshipController = {
    follow,
    unfollow,
    getFollowedUsers,
    getFollowingUsers,
}
