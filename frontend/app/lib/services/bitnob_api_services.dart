import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/wallet_model.dart';
import '../models/transaction_model.dart';

class BitnobApiService {
  // Replace with your actual backend URL
  static const String baseUrl = 'http://localhost:3000/api'; // Change for production
  
  // Singleton pattern to ensure one instance
  static final BitnobApiService _instance = BitnobApiService._internal();
  factory BitnobApiService() => _instance;
  BitnobApiService._internal();

  // Default headers for all requests
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Add authorization header when user is authenticated
  Map<String, String> _headersWithAuth(String? token) {
    final headers = Map<String, String>.from(_headers);
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // Generic error handler
  void _handleError(http.Response response) {
    if (response.statusCode >= 400) {
      final errorBody = json.decode(response.body);
      final errorMessage = errorBody['error'] ?? 'Unknown error occurred';
      throw Exception('API Error ${response.statusCode}: $errorMessage');
    }
  }

  // WALLET OPERATIONS

  /// Create a new wallet
  Future<CreateWalletResponse> createWallet({
    required String name,
    required DateTime withdrawalDate,
    required String customerId,
    String? authToken,
  }) async {
    try {
      final request = CreateWalletRequest(
        name: name,
        withdrawalDate: withdrawalDate,
        customerId: customerId,
      );

      final response = await http.post(
        Uri.parse('http://localhost:3000/api/wallets/create'),
        headers: _headersWithAuth(authToken),
        body: json.encode(request.toJson()),
      );

      _handleError(response);

      final responseData = json.decode(response.body);
      return CreateWalletResponse.fromJson(responseData);
    } catch (e) {
      throw Exception('Failed to create wallet: $e');
    }
  }

  /// Get all wallets for a user
  Future<List<WalletModel>> getUserWallets({
    required String userId,
    String? authToken,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/wallets/user/$userId'),
        headers: _headersWithAuth(authToken),
      );

      _handleError(response);

      final responseData = json.decode(response.body);
      final walletsData = responseData['wallets'] as List;
      
      return walletsData
          .map((wallet) => WalletModel.fromJson(wallet as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch wallets: $e');
    }
  }

  /// Get a specific wallet by ID
  Future<WalletModel> getWalletById({
    required String walletId,
    String? authToken,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/wallets/$walletId'),
        headers: _headersWithAuth(authToken),
      );

      _handleError(response);

      final responseData = json.decode(response.body);
      return WalletModel.fromJson(responseData['wallet']);
    } catch (e) {
      throw Exception('Failed to fetch wallet: $e');
    }
  }

  /// Update wallet details
  Future<WalletModel> updateWallet({
    required String walletId,
    String? name,
    DateTime? withdrawalDate,
    String? authToken,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (name != null) body['name'] = name;
      if (withdrawalDate != null) body['withdrawal_date'] = withdrawalDate.toIso8601String();

      final response = await http.put(
        Uri.parse('$baseUrl/wallets/$walletId'),
        headers: _headersWithAuth(authToken),
        body: json.encode(body),
      );

      _handleError(response);

      final responseData = json.decode(response.body);
      return WalletModel.fromJson(responseData['wallet']);
    } catch (e) {
      throw Exception('Failed to update wallet: $e');
    }
  }

  /// Delete a wallet
  Future<void> deleteWallet({
    required String walletId,
    String? authToken,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/wallets/$walletId'),
        headers: _headersWithAuth(authToken),
      );

      _handleError(response);
    } catch (e) {
      throw Exception('Failed to delete wallet: $e');
    }
  }

  // TRANSACTION OPERATIONS

  /// Create a new transaction
  Future<TransactionResponse> createTransaction({
    required String walletId,
    required String userId,
    required TransactionType type,
    required double amount,
    required String currency,
    MobileMoneyDetails? mobileMoneyDetails,
    String? authToken,
  }) async {
    try {
      final request = CreateTransactionRequest(
        walletId: walletId,
        userId: userId,
        type: type,
        amount: amount,
        currency: currency,
        mobileMoneyDetails: mobileMoneyDetails,
      );

      final response = await http.post(
        Uri.parse('$baseUrl/transactions/create'),
        headers: _headersWithAuth(authToken),
        body: json.encode(request.toJson()),
      );

      _handleError(response);

      final responseData = json.decode(response.body);
      return TransactionResponse.fromJson(responseData);
    } catch (e) {
      throw Exception('Failed to create transaction: $e');
    }
  }

  /// Get transactions for a wallet
  Future<List<TransactionModel>> getWalletTransactions({
    required String walletId,
    int? limit,
    int? offset,
    String? authToken,
  }) async {
    try {
      var url = '$baseUrl/transactions/wallet/$walletId';
      final queryParams = <String, String>{};
      
      if (limit != null) queryParams['limit'] = limit.toString();
      if (offset != null) queryParams['offset'] = offset.toString();
      
      if (queryParams.isNotEmpty) {
        url = '$url?${queryParams.entries.map((e) => '${e.key}=${e.value}').join('&')}';
      }

      final response = await http.get(
        Uri.parse(url),
        headers: _headersWithAuth(authToken),
      );

      _handleError(response);

      final responseData = json.decode(response.body);
      final transactionsData = responseData['transactions'] as List;
      
      return transactionsData
          .map((transaction) => TransactionModel.fromJson(transaction as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch transactions: $e');
    }
  }

  /// Get transactions for a user
  Future<List<TransactionModel>> getUserTransactions({
    required String userId,
    int? limit,
    int? offset,
    String? authToken,
  }) async {
    try {
      var url = '$baseUrl/transactions/user/$userId';
      final queryParams = <String, String>{};
      
      if (limit != null) queryParams['limit'] = limit.toString();
      if (offset != null) queryParams['offset'] = offset.toString();
      
      if (queryParams.isNotEmpty) {
        url = '$url?${queryParams.entries.map((e) => '${e.key}=${e.value}').join('&')}';
      }

      final response = await http.get(
        Uri.parse(url),
        headers: _headersWithAuth(authToken),
      );

      _handleError(response);

      final responseData = json.decode(response.body);
      final transactionsData = responseData['transactions'] as List;
      
      return transactionsData
          .map((transaction) => TransactionModel.fromJson(transaction as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch user transactions: $e');
    }
  }

  /// Get transaction by ID
  Future<TransactionModel> getTransactionById({
    required String transactionId,
    String? authToken,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/transactions/$transactionId'),
        headers: _headersWithAuth(authToken),
      );

      _handleError(response);

      final responseData = json.decode(response.body);
      return TransactionModel.fromJson(responseData['transaction']);
    } catch (e) {
      throw Exception('Failed to fetch transaction: $e');
    }
  }

  // UTILITY METHODS

  /// Check if the API is reachable
  Future<bool> checkApiHealth() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/health'),
        headers: _headers,
      ).timeout(const Duration(seconds: 5));

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Get wallet balance
  Future<double> getWalletBalance({
    required String walletId,
    String? authToken,
  }) async {
    try {
      final wallet = await getWalletById(walletId: walletId, authToken: authToken);
      return wallet.balance;
    } catch (e) {
      throw Exception('Failed to fetch wallet balance: $e');
    }
  }
}