import { Router } from "express";
import { Request, Response } from "express";
import userRouter from "./user.js";
const router = Router();

router.get("/hello", (req: Request, res: Response) => {
    res.send("How are you doing?");
})

router.use("/users", userRouter);

export default router;