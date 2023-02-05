import { Router } from "express";
import { Request, Response } from "express";
import { userRouter } from "./user";
const router = Router();

router.get("/test", (req: Request, res: Response) => {
    res.send("Working as intended");
})

router.use("/users", userRouter);

export default router;