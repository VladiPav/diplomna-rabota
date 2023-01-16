import express from 'express';
import router from "./routes/index.js";
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
const port = 8080;
app.use("/", router);
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
//# sourceMappingURL=index.js.map