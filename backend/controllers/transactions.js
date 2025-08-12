import wallets from "../models/wallets.js";
import transactions from "../models/transactions.js";
import bitnobApi from "../utils/bitnobConfig.js";
import user from "../models/user.js";

export const deposit = async (req, res) => {
  try {
    const { wallet_id, amount, mobile_money_provider, phone_number, customer_id } = req.body;

    if (!wallet_id || !amount || !mobile_money_provider || !phone_number) {
      return res.status(400).json({ 
        error: 'Wallet ID, amount, mobile money provider, and phone number are required' 
      });
    }

    if (amount <= 0) {
      return res.status(400).json({ error: 'Amount must be greater than 0' });
    }

    const wallet = await wallets.findOne({
      where: { id: wallet_id, user_id: customer_id },
    });

    if (!wallet) {
      return res.status(404).json({ error: 'Wallet not found' });
    }

    if (wallet.status !== 'active') {
      return res.status(400).json({ error: 'Cannot deposit to inactive wallet' });
    }

    const transaction = await transactions.create({
      wallet_id,
      user_id: customer_id,
      type: 'deposit',
      amount,
      currency: 'UGX',
      status: 'pending',
      mobile_money_details: {
        provider: mobile_money_provider,
        phone_number,
      },
    });

    try {
      const paymentRequest = await bitnobApi.post('/payouts/simulate-address-deposit', {
        address: wallet.bitnob_address,
        amount: amount
      });

      const total_amount = wallet.total_amount + parseFloat(amount);
      await wallet.update({
        total_amount,
        balance: total_amount,
      });

      await transaction.update({
        bitnob_transaction_id: paymentRequest.data.data.id,
        status: 'completed',
      });

      res.status(201).json({
        message: 'Deposit initiated successfully',
        transaction: {
          id: transaction.id,
          amount: parseFloat(amount),
          status: 'completed',
        },
      });
    } catch (error) {

      await transaction.update({ status: 'failed' });
      console.error('Mobile money payment failed:', error);
      return res.status(500).json({message: 'Failed to initiate deposit', error: error.message});
    }
  } catch (error) {
    console.error('Deposit error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
}

export const withdraw = async (req, res) => {
  try {
    const { wallet_id, amount, mobile_money_provider, phone_number, customer_id, account_name } = req.body;

    if (!wallet_id || !amount || !mobile_money_provider || !phone_number) {
      return res.status(400).json({ 
        error: 'Wallet ID, amount, mobile money provider, and phone number are required' 
      });
    }

    if (amount <= 0) {
      return res.status(400).json({ error: 'Amount must be greater than 0' });
    }

    const wallet = await wallets.findOne({
      where: { id: wallet_id, user_id: customer_id },
    });

    if (!wallet) {
      return res.status(404).json({ error: 'Wallet not found' });
    }

    if (wallet.status !== 'active') {
      return res.status(400).json({ error: 'Cannot withdraw from inactive wallet' });
    }

    // if (wallet.balance < amount) {
    //   return res.status(400).json({ error: 'Insufficient balance for withdrawal' });
    // }

    const foundUser = await user.findByPk(customer_id);
    if (!foundUser) {
      return res.status(404).json({ error: 'User not found' });
    }

    const transaction = await transactions.create({
      wallet_id,
      user_id: customer_id,
      type: 'withdrawal',
      amount,
      currency: 'UGX',
      status: 'pending',
      mobile_money_details: {
        provider: mobile_money_provider,
        phone_number,
      },
    });

    try {

       const createQuote = await bitnobApi.post('payouts/quotes', {
        source: 'offchain',
        fromAsset: 'usdt',
        toCurrency: 'ugx',
        amount: amount,
      });

      const initializeQuote = await bitnobApi.post('payouts/initialize', {
        quoteId: createQuote.data.data.quoteId,
        customerId: foundUser.bitnob_customer_id,
        country: 'UG',
        reference:'withdrawal-' + createQuote.data.data.quoteId,
        paymentReason: 'Withdrawal from wallet',
        beneficiary: {
        type: "MOBILEMONEY",
        accountName: account_name,
        network: "AIRTEL",
        accountNumber: `256${phone_number}`,
      }
      });

      const finalizeQuote = await bitnobApi.post('payouts/finalize', {
        quoteId: initializeQuote.data.data.quoteId,
      })

      const total_amount = wallet.total_amount - parseFloat(amount);
      await wallet.update({
        total_amount,
        balance: total_amount,
        status: total_amount > 0 ? 'active' : 'withdrawn',
      });

      await transaction.update({
        bitnob_transaction_id: finalizeQuote.data.data.quoteId,
        status: 'completed',
      });

      res.status(201).json({
        message: 'Withdrawal initiated successfully',
        transaction: {
          id: transaction.id,
          amount: parseFloat(amount),
          status: 'completed',
        },
      });
    } catch (error) {
      await transaction.update({ status: 'failed' });
      console.error('Mobile money withdrawal failed:', error);
      return res.status(500).json({message: 'Failed to initiate withdrawal', error: error.message});
    }
  } catch (error) {
    console.error('Withdrawal error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
}