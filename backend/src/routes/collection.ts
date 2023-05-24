import { Router } from 'express';
import { collectionController } from '../controllers/collection';

const router = Router();

router.delete(
  '/:collectionId/elements/:elementId', 
  collectionController.removeElementFromCollection
);

router.delete('/:id', collectionController.deleteCollection);

router.post('/:id/elements', collectionController.addElementToCollection);

router.get('/:id', collectionController.getCollectionById);

router.post('/', collectionController.createCollection);

router.put('/:id', collectionController.reorderCollection);




export const collectionRouter = router;