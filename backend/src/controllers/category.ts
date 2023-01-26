import { Request, Response } from "express";
import { categoryService } from '../services/category.js';

const createCategory = (req: Request, res: Response) => {
    try {
        const {
            name,
        } = req.body;


    } catch (e) {
        res.send(e);
    }
}