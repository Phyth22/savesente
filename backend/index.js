import 'dotenv/config'
import express from 'express';
import cors from 'cors';
import userRoutes from './routes/user.js';
import walletRoutes from './routes/wallet.js'
import transactionRoutes from './routes/transactions.js';

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.use('/api/customers', userRoutes);
app.use('/api/wallets', walletRoutes);
app.use('/api/transactions', transactionRoutes);

app.listen(PORT,()=>{
    console.log(`App listening on port ${PORT}`)
})