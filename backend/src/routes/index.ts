import { Router, Request, Response } from "express";

const router = Router();

router.use("/", (req: Request, res: Response) => {
    res.send(req.query);
});

export default router;