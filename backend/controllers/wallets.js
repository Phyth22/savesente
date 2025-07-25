import bitnobApi from "../utils/bitnobConfig.js";
import wallets from "../models/wallets.js";
import user from "../models/user.js";

export const create_wallet = async (req, res, next) => {
  try {
    const { name, withdrawal_date, customer_id } = req.body;

    if (!name) {
      return res.status(400).json({ error: 'Wallet name is required' });
    }

    // Validate withdrawal date is in the future
    const withdrawalDate = new Date(withdrawal_date);
    if (withdrawalDate && withdrawalDate <= new Date()) {
      return res.status(400).json({ error: 'Withdrawal date must be in the future' });
    }

    // Get user info
    const user_details = await user.findByPk(customer_id);
    if (!user_details) {
      return res.status(404).json({ error: 'User not found' });
    }

    let bitnoAddressDetails = {};

    // Create USDT address in Bitnob
    try {
      const bitnobAddress = await bitnobApi.post('/addresses/tron/generate', {
        customerEmail: user_details.email,
        label: name,
      });

      const data = bitnobAddress.data.data
      bitnoAddressDetails = {
        ...bitnoAddressDetails, 
        ...data
      };
    } catch (error) {
      console.error('Failed to create Bitnob address:', error);
      return res.status(500).json({ error: 'Failed to create address in Bitnob' });
    }

    // Create wallet in database
    const wallet = await wallets.create({
      user_id:customer_id,
      name,
      bitnob_wallet_id: bitnoAddressDetails.id,
      bitnob_address: bitnoAddressDetails.address,
      withdrawal_date: withdrawalDate,
    });

    res.status(201).json({
      message: 'Wallet created successfully',
      wallet: {
        id: wallet.id,
        name: wallet.name,
        withdrawal_date: wallet.withdrawal_date,
        total_amount: wallet.total_amount,
        balance: wallet.balance,
        status: wallet.status,
        address_details:bitnoAddressDetails
      },
    });
  } catch (error) {
    console.error('Wallet creation error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
}