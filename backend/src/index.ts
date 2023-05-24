import express, { Express, Request, Response } from 'express';
import * as admin from 'firebase-admin';
import router from './routes/index';
import morganBody from 'morgan-body';
import bodyParser from 'body-parser';
import { initializeApp } from 'firebase-admin/app';
import { authMiddleware } from './middleware/auth';


const serviceAccount = JSON.parse(
    process.env.GOOGLE_APPLICATION_CREDENTIALS as string
);

initializeApp({ credential: admin.credential.cert(serviceAccount) });

const app: Express = express();

app.use(bodyParser.json());
app.use(express.urlencoded({ extended: true }));

morganBody(app);


app.get('/test', (req: Request, res: Response) => {
  res.send('Working as intended');
});

app.use('/images', express.static('images'));

app.use('/', authMiddleware, router);

app.use('*', (req, res) => res.status(404).send('Not Found'));

const port = 8080;

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});