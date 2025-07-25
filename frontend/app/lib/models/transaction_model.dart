class TransactionModel {
  final String id;
  final String walletId;
  final String userId;
  final TransactionType type;
  final double amount;
  final String currency;
  final TransactionStatus status;
  final String? bitnobTransactionId;
  final MobileMoneyDetails? mobileMoneyDetails;
  final DateTime createdAt;
  final DateTime updatedAt;

  TransactionModel({
    required this.id,
    required this.walletId,
    required this.userId,
    required this.type,
    required this.amount,
    required this.currency,
    required this.status,
    this.bitnobTransactionId,
    this.mobileMoneyDetails,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create TransactionModel from JSON
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      walletId: json['wallet_id'] as String,
      userId: json['user_id'] as String,
      type: TransactionType.fromString(json['type'] as String),
      amount: double.parse(json['amount'].toString()),
      currency: json['currency'] as String,
      status: TransactionStatus.fromString(json['status'] as String),
      bitnobTransactionId: json['bitnob_transaction_id'] as String?,
      mobileMoneyDetails: json['mobile_money_details'] != null
          ? MobileMoneyDetails.fromJson(json['mobile_money_details'] as Map<String, dynamic>)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // Convert TransactionModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'wallet_id': walletId,
      'user_id': userId,
      'type': type.value,
      'amount': amount,
      'currency': currency,
      'status': status.value,
      'bitnob_transaction_id': bitnobTransactionId,
      'mobile_money_details': mobileMoneyDetails?.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create a copy of the transaction with updated fields
  TransactionModel copyWith({
    String? id,
    String? walletId,
    String? userId,
    TransactionType? type,
    double? amount,
    String? currency,
    TransactionStatus? status,
    String? bitnobTransactionId,
    MobileMoneyDetails? mobileMoneyDetails,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      walletId: walletId ?? this.walletId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      bitnobTransactionId: bitnobTransactionId ?? this.bitnobTransactionId,
      mobileMoneyDetails: mobileMoneyDetails ?? this.mobileMoneyDetails,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper method to check if transaction is successful
  bool get isCompleted => status == TransactionStatus.completed;
  
  // Helper method to check if transaction is pending
  bool get isPending => status == TransactionStatus.pending;
  
  // Helper method to check if transaction failed
  bool get isFailed => status == TransactionStatus.failed;
  
  // Helper method to check if it's a deposit
  bool get isDeposit => type == TransactionType.deposit;
  
  // Helper method to check if it's a withdrawal
  bool get isWithdrawal => type == TransactionType.withdrawal;

  @override
  String toString() {
    return 'TransactionModel(id: $id, type: $type, amount: $amount, currency: $currency, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TransactionModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Enum for transaction type
enum TransactionType {
  deposit('deposit'),
  withdrawal('withdrawal');

  const TransactionType(this.value);
  final String value;

  static TransactionType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'deposit':
        return TransactionType.deposit;
      case 'withdrawal':
        return TransactionType.withdrawal;
      default:
        throw ArgumentError('Unknown transaction type: $type');
    }
  }

  @override
  String toString() => value;
}

// Enum for transaction status
enum TransactionStatus {
  pending('pending'),
  completed('completed'),
  failed('failed');

  const TransactionStatus(this.value);
  final String value;

  static TransactionStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return TransactionStatus.pending;
      case 'completed':
        return TransactionStatus.completed;
      case 'failed':
        return TransactionStatus.failed;
      default:
        throw ArgumentError('Unknown transaction status: $status');
    }
  }

  @override
  String toString() => value;
}

// Model for mobile money details
class MobileMoneyDetails {
  final String? provider;
  final String? phoneNumber;
  final String? network;
  final String? transactionId;
  final String? reference;
  final String? customerName;
  final Map<String, dynamic>? additionalData;

  MobileMoneyDetails({
    this.provider,
    this.phoneNumber,
    this.network,
    this.transactionId,
    this.reference,
    this.customerName,
    this.additionalData,
  });

  factory MobileMoneyDetails.fromJson(Map<String, dynamic> json) {
    // Extract known fields and put the rest in additionalData
    final knownFields = {
      'provider',
      'phoneNumber',
      'phone_number',
      'network',
      'transactionId',
      'transaction_id',
      'reference',
      'customerName',
      'customer_name'
    };
    
    final additional = <String, dynamic>{};
    for (final entry in json.entries) {
      if (!knownFields.contains(entry.key)) {
        additional[entry.key] = entry.value;
      }
    }

    return MobileMoneyDetails(
      provider: json['provider'] as String?,
      phoneNumber: (json['phoneNumber'] ?? json['phone_number']) as String?,
      network: json['network'] as String?,
      transactionId: (json['transactionId'] ?? json['transaction_id']) as String?,
      reference: json['reference'] as String?,
      customerName: (json['customerName'] ?? json['customer_name']) as String?,
      additionalData: additional.isNotEmpty ? additional : null,
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    
    if (provider != null) json['provider'] = provider;
    if (phoneNumber != null) json['phoneNumber'] = phoneNumber;
    if (network != null) json['network'] = network;
    if (transactionId != null) json['transactionId'] = transactionId;
    if (reference != null) json['reference'] = reference;
    if (customerName != null) json['customerName'] = customerName;
    
    // Add additional data
    if (additionalData != null) {
      json.addAll(additionalData!);
    }
    
    return json;
  }

  @override
  String toString() {
    return 'MobileMoneyDetails(provider: $provider, phoneNumber: $phoneNumber, network: $network)';
  }
}

// Request model for creating a transaction
class CreateTransactionRequest {
  final String walletId;
  final String userId;
  final TransactionType type;
  final double amount;
  final String currency;
  final MobileMoneyDetails? mobileMoneyDetails;

  CreateTransactionRequest({
    required this.walletId,
    required this.userId,
    required this.type,
    required this.amount,
    required this.currency,
    this.mobileMoneyDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      'wallet_id': walletId,
      'user_id': userId,
      'type': type.value,
      'amount': amount,
      'currency': currency,
      'mobile_money_details': mobileMoneyDetails?.toJson(),
    };
  }
}

// Response model for transaction operations
class TransactionResponse {
  final String message;
  final TransactionModel? transaction;
  final List<TransactionModel>? transactions;

  TransactionResponse({
    required this.message,
    this.transaction,
    this.transactions,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      message: json['message'] as String,
      transaction: json['transaction'] != null 
          ? TransactionModel.fromJson(json['transaction'] as Map<String, dynamic>)
          : null,
      transactions: json['transactions'] != null
          ? (json['transactions'] as List)
              .map((t) => TransactionModel.fromJson(t as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
}