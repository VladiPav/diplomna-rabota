import { Router } from 'express';
import { categoryRouter } from './category';
import { collectionRouter } from './collection';
import { elementRouter } from './element';
import { userRouter } from './user';

const router = Router();


router.use('/users', userRouter);

router.use('/collections', collectionRouter);

router.use('/categories', categoryRouter);

router.use('/elements', elementRouter);

export default router;