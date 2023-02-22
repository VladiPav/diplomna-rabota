import { Router } from "express";
import { elementController } from "../controllers/element";

const router = Router();

router.post('/', elementController.createElement);

router.get('/', elementController.getElementsByCategory);

export const elementRouter = router;