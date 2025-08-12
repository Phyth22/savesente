import user from "../models/user.js";
import bitnobApi from "../utils/bitnobConfig.js";



export const create_customer = async (req, res, next) => {
  try {
    const { firstName, lastName, email, phone, countryCode } = req.body;

    // Validate required fields
    if (!firstName || !lastName || !email || !phone || !countryCode) {
      return res.status(400).json({ error: 'All fields are required' });
    }

     const existingUser = await user.findOne({ where: { email } });
    if (existingUser) {
      return res.status(409).json({ error: 'User with this email already exists' });
    }

    // Create user in the database
    const newUser = await user.create({
      firstName,
      lastName,
      email,
      phone,
      countryCode
    });

    //create customer in Bitnob
    try{
        const response = await bitnobApi.post('/customers', {
            firstName: firstName,
            lastName: lastName,
            email,
            phone,
            countryCode: countryCode,
        });

        if (response?.data?.status !== true) {
        return res.status(response.status).json({ error: 'Failed to create customer in Bitnob' });
        }
        const bitnobCustomerId = response?.data?.data?.id;
        // Update user with Bitnob customer ID
        await newUser.update({ bitnob_customer_id: bitnobCustomerId });
    }catch (error) {
      console.error('Error creating user in Bitnob:', error);
      return res.status(500).json({ error: 'Failed to create customer in Bitnob' });
    } 

    return res.status(201).json({
        message: 'User created successfully',
        user: {
          id: newUser.id,
            firstName: newUser.firstName,
            lastName: newUser.lastName,
            email: newUser.email,
            phone: newUser.phone,
            countryCode: newUser.countryCode,
            bitnob_customer_id: newUser.bitnob_customer_id,
        }
    });
  } catch (error) {
    console.error('Error creating user:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
}

export const get_customer = async (req, res, next) => {
  try {
    const userId = req.params.id;

    // Validate user ID
    if (!userId) {
      return res.status(400).json({ error: 'User ID is required' });
    }

    // Find user by ID
    const foundUser = await user.findByPk(userId);
    if (!foundUser) {
      return res.status(404).json({ error: 'User not found' });
    }

    return res.status(200).json({
      id: foundUser.id,
      firstName: foundUser.firstName,
      lastName: foundUser.lastName,
      email: foundUser.email,
      phone: foundUser.phone,
      countryCode: foundUser.countryCode,
      bitnob_customer_id: foundUser.bitnob_customer_id,
    });
  } catch (error) {
    console.error('Error fetching user:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
}