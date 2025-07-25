import axios from 'axios';

const BITNOB_BASE_URL = process.env.BITNOB_BASE_URL || 'https://sandboxapi.bitnob.co/api/v1';
const BITNOB_API_KEY = process.env.BITNOB_API_KEY;

const bitnobApi = axios.create({
  baseURL: BITNOB_BASE_URL,
  headers: {
    'Authorization': `Bearer ${BITNOB_API_KEY}`,
    'Content-Type': 'application/json',
  },
});

export default bitnobApi;