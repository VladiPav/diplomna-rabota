import { Router } from 'express';
import { categoryRouter } from './category';
import { collectionRouter } from './collection';
import { userRouter } from './user';

const router = Router();


router.use('/users', userRouter);

router.use('/collections', collectionRouter);

router.use('/categories', categoryRouter);

export default router;