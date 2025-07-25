class WalletModel {
  final String id;
  final String userId;
  final String name;
  final String? bitnobWalletId;
  final DateTime? withdrawalDate;
  final double balance;
  final WalletStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final AddressDetails? addressDetails;

  WalletModel({
    required this.id,
    required this.userId,
    required this.name,
    this.bitnobWalletId,
    this.withdrawalDate,
    required this.balance,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.addressDetails,
  });

  // Factory constructor to create WalletModel from JSON
  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      bitnobWalletId: json['bitnob_wallet_id'] as String?,
      withdrawalDate: json['withdrawal_date'] != null 
          ? DateTime.parse(json['withdrawal_date'] as String)
          : null,
      balance: double.parse(json['balance'].toString()),
      status: WalletStatus.fromString(json['status'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      addressDetails: json['address_details'] != null
          ? AddressDetails.fromJson(json['address_details'] as Map<String, dynamic>)
          : null,
    );
  }

  // Convert WalletModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'bitnob_wallet_id': bitnobWalletId,
      'withdrawal_date': withdrawalDate?.toIso8601String(),
      'balance': balance,
      'status': status.value,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'address_details': addressDetails?.toJson(),
    };
  }

  // Create a copy of the wallet with updated fields
  WalletModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? bitnobWalletId,
    DateTime? withdrawalDate,
    double? balance,
    WalletStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    AddressDetails? addressDetails,
  }) {
    return WalletModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      bitnobWalletId: bitnobWalletId ?? this.bitnobWalletId,
      withdrawalDate: withdrawalDate ?? this.withdrawalDate,
      balance: balance ?? this.balance,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      addressDetails: addressDetails ?? this.addressDetails,
    );
  }

  @override
  String toString() {
    return 'WalletModel(id: $id, name: $name, balance: $balance, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WalletModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Enum for wallet status
enum WalletStatus {
  active('active'),
  locked('locked'),
  withdrawn('withdrawn');

  const WalletStatus(this.value);
  final String value;

  static WalletStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return WalletStatus.active;
      case 'locked':
        return WalletStatus.locked;
      case 'withdrawn':
        return WalletStatus.withdrawn;
      default:
        throw ArgumentError('Unknown wallet status: $status');
    }
  }

  @override
  String toString() => value;
}

// Model for address details from Bitnob API
class AddressDetails {
  final String? id;
  final String? address;
  final String? label;
  final String? customerEmail;
  final String? network;
  final String? currency;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AddressDetails({
    this.id,
    this.address,
    this.label,
    this.customerEmail,
    this.network,
    this.currency,
    this.createdAt,
    this.updatedAt,
  });

  factory AddressDetails.fromJson(Map<String, dynamic> json) {
    return AddressDetails(
      id: json['id'] as String?,
      address: json['address'] as String?,
      label: json['label'] as String?,
      customerEmail: json['customerEmail'] as String?,
      network: json['network'] as String?,
      currency: json['currency'] as String?,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'label': label,
      'customerEmail': customerEmail,
      'network': network,
      'currency': currency,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'AddressDetails(id: $id, address: $address, network: $network)';
  }
}

// Request model for creating a wallet
class CreateWalletRequest {
  final String name;
  final DateTime withdrawalDate;
  final String customerId;

  CreateWalletRequest({
    required this.name,
    required this.withdrawalDate,
    required this.customerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'withdrawal_date': withdrawalDate.toIso8601String(),
      'customer_id': customerId,
    };
  }
}

// Response model for wallet creation
class CreateWalletResponse {
  final String message;
  final WalletModel wallet;

  CreateWalletResponse({
    required this.message,
    required this.wallet,
  });

  factory CreateWalletResponse.fromJson(Map<String, dynamic> json) {
    return CreateWalletResponse(
      message: json['message'] as String,
      wallet: WalletModel.fromJson(json['wallet'] as Map<String, dynamic>),
    );
  }
}