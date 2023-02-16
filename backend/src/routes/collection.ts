import { Router } from "express";
import { collectionController } from "../controllers/collection";

const router = Router();

router.get('/:id', collectionController.getCollectionById);



export const collectionRouter = router;