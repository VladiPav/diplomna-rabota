import multer from "multer";

const filestorageengine = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, './images/profilePictures');
    },
    filename: (req, file, cb) => {
        cb(null, req.res?.locals.currentUser.id);
    },
});

const upload = multer({
    storage: filestorageengine,
});

export const uploadMiddleware = upload;