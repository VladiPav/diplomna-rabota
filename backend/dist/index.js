import express from 'express';
import { PrismaClient } from '@prisma/client';
const app = express();
const prisma = new PrismaClient();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
const port = 8080;
app.get("/", (_req, res) => {
    res.send(`Server is running on port: ${port}`);
});
// Getting todos route
app.get('/api/users', async (req, res) => {
    try {
        const allUsers = await prisma.user.findMany();
        return res.json({
            success: true,
            data: allUsers
        });
    }
    catch (error) {
        return res.json({
            success: false,
            message: error
        });
    }
});
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
//# sourceMappingURL=index.js.map