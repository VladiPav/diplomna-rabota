import { Router } from "express";
import { auth } from "firebase-admin";
import { userController } from "../controllers/user"
import { relationshipRouter } from "./relationship";


const router = Router();


router.post("/", userController.createUser);

router.use(relationshipRouter);

router.get("/", userController.getAllUsers);

router.get("/:id", userController.getUserById);


export const userRouter = router;
