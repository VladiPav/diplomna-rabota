import express, { Express } from 'express';
import router from "./routes/index";
import morganBody from 'morgan-body';
import bodyParser from 'body-parser';
import { initializeApp } from "firebase-admin/app";
import { authMiddleware } from './middleware/auth';

initializeApp();

const app: Express = express();

app.use(bodyParser.json());
app.use(express.urlencoded({ extended: true }));

morganBody(app);

app.use('/images', express.static('images'));

app.use("/", authMiddleware, router);

app.use('*', (req, res) => res.status(404).send('Not Found'));

const port: number = 8080;

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});