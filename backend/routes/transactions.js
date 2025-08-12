import { Router } from "express";
import * as transactionController from "../controllers/transactions.js";


const router = Router();

router.post('/deposit', transactionController.deposit);
router.post('/withdraw', transactionController.withdraw);

export default router;