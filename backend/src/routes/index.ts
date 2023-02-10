import { Router } from "express";
import { Request, Response, NextFunction } from "express";
import { uploadMiddleware } from "../middleware/upload";
import { HTTPStatusCode } from "../types/error";
import { authMiddleware } from "../middleware/auth";
import { userRouter } from "./user";
const router = Router();


router.get("/test", (req: Request, res: Response) => {
    res.send("Working as intended");
})

router.use(authMiddleware);

router.post('/profile-picture', uploadMiddleware.single('image'), (req: Request, res: Response) => {
    res.status(HTTPStatusCode.Created).json(req.file?.path);
});

router.use("/users", userRouter);

export default router;