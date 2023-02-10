import express, { Express } from 'express';
import router from "./routes/index";
import morganBody from 'morgan-body';
import bodyParser from 'body-parser';
import { initializeApp } from "firebase-admin/app";

initializeApp();

const app: Express = express();

const originalSend = app.response.send;

app.use(bodyParser.json());
app.use(express.urlencoded({ extended: true }));

morganBody(app);


app.use('/images', express.static('images'));



app.use("/", router);


const port: number = 8080;

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});