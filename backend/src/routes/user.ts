import { Router } from 'express';
import { userController } from '../controllers/user';
import { relationshipRouter } from './relationship';
import { uploadMiddleware } from '../middleware/upload';

const router = Router();


router.post('/', userController.createUser);

router.use(relationshipRouter);

router.get('/', userController.getAllUsers);

router.post('/me/profile-image', uploadMiddleware.single('image'), userController.uploadProfileImage);

router.get('/me', userController.getCurrentUser);

router.get('/:id', userController.getUserById);

export const userRouter = router;
