import { Router } from "express";
import { collectionController } from "../controllers/collection";

const router = Router();

router.post('/:id/elements', collectionController.addElementToCollection);

router.get('/:id', collectionController.getCollectionById);

router.post('/', collectionController.createCollection);




export const collectionRouter = router;