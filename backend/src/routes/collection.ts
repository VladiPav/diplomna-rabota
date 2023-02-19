import { Router } from "express";
import { collectionController } from "../controllers/collection";

const router = Router();

router.get('/:id', collectionController.getCollectionById);

router.post('/', collectionController.createCollection);


export const collectionRouter = router;