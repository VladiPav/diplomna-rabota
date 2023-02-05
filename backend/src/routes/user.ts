import { Router } from "express";
import { userController } from "../controllers/user"
import { relationshipRouter } from "./relationship";


const router = Router();

router.use(relationshipRouter);

router.get("/", userController.getAllUsers);

router.get("/:id", userController.getUserById);

//router.post("/", userController.createUser);


export const userRouter = router;
