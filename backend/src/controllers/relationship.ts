import { Request, Response } from "express";
import { relationshipService } from '../services/relationship';

const follow = (req: Request, res: Response) => {
    try {

        const followedId = req.params.id;

        relationshipService.follow(res.locals.currentUser, followedId);


    } catch (e) {
        res.send(e);
    }
}


const unfollow = (req: Request, res: Response) => {
    try {

        const followedId = req.params.id;

        relationshipService.unfollow(res.locals.currentUser, followedId);

    } catch (e) {
        res.send(e);
    }
}

const getFollowedUsers = (req: Request, res: Response) => {
    try {
        const followedUsers = relationshipService.getFollowedUsers(res.locals.currentUser);

        res.json(followedUsers);
    } catch (e) {
        res.send(e);
    }
}

const getFollowingUsers = (req: Request, res: Response) => {
    try {
        const followingUsers = relationshipService.getFollowingUsers(res.locals.currentUser);

        res.json(followingUsers);

    } catch (e) {
        res.send(e);
    }
}

export const relationshipController = {
    follow,
    unfollow,
    getFollowedUsers,
    getFollowingUsers,
}
