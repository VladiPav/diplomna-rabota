import { Router } from "express";
import { relationshipController } from "../controllers/relationship";

const router = Router();

router.post("/:id/follow", relationshipController.follow);

router.delete("/:id/unfollow", relationshipController.unfollow);

router.get("/followers", relationshipController.getFollowingUsers);

router.get("/followeing", relationshipController.getFollowedUsers);


export const relationshipRouter = router;
