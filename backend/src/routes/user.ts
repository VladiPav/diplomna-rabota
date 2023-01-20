import { Router } from "express";
import userController from "../controllers/user.js"

const router = Router();

router.get("/", userController.getAllUsers);

router.get("/", userController.getUserById);

router.post("/", userController.createUser);

export  const userRouter = router;
