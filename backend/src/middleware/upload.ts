import multer from "multer";
import path from "path";

const filestorageengine = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, './images/profilePictures');
    },
    filename: (req, file, cb) => {
        cb(null, (
            req.res?.locals.currentUser.id + path.extname(file.originalname)));
    },
});

const upload = multer({
    storage: filestorageengine,
});

export const uploadMiddleware = upload;

