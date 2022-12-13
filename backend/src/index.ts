import express, { Express } from 'express';
import router from "./routes/index.js";

const app: Express = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const port: number = 8080;

app.use("/", router);


app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
})