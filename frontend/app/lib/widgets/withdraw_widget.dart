import 'package:flutter/material.dart';
import '../services/bitnob_api_services.dart';
import '../models/wallet_model.dart';
import '../models/transaction_model.dart';
// Add this import for UserAuth - replace with your actual auth service import
import '../services/user_auth.dart'; // Uncomment and adjust path as needed

class Withdraw extends StatefulWidget {
  final VoidCallback? onWithdrawComplete;
  final List<WalletModel>? availableWallets;
  
  const Withdraw({
    super.key,
    this.onWithdrawComplete,
    this.availableWallets,
  });

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedWalletId = '';
  String _selectedMethod = '';
  
  final BitnobApiService _apiService = BitnobApiService();
  bool _isProcessing = false;
  bool _showSuccessMessage = false;
  String? _currentUserId; // Declare the variable properly

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  List<WalletModel> get _wallets => widget.availableWallets ?? [];
  
  WalletModel? get _selectedWallet {
    try {
      return _wallets.firstWhere((wallet) => wallet.id == _selectedWalletId);
    } catch (e) {
      return null;
    }
  }

  Future<void> _loadUserId() async {
    try {
      // Replace this with your actual UserAuth implementation
      // final userId = await UserAuth.getCurrentUserId();
      final userId = "temp_user_id"; // Temporary placeholder
      setState(() {
        _currentUserId = userId;
      });
    } catch (e) {
      print('Error loading user ID: $e');
      // Handle error appropriately
    }
  }

  bool _canWithdraw(WalletModel wallet) {
    // Check if wallet is unlocked (withdrawal date has passed)
    if (wallet.withdrawalDate != null && DateTime.now().isBefore(wallet.withdrawalDate!)) {
      return false;
    }
    
    // Check if wallet has sufficient balance
    return wallet.balance > 0;
  }

  String _getWalletStatusText(WalletModel wallet) {
    if (wallet.withdrawalDate != null && DateTime.now().isBefore(wallet.withdrawalDate!)) {
      final daysLeft = wallet.withdrawalDate!.difference(DateTime.now()).inDays;
     return ' (Locked - $daysLeft days left)';
    }
    return ' (Available)';
  }

  Future<void> _makeWithdrawal() async {
    // Validation
    if (_selectedWalletId.isEmpty) {
      _showErrorDialog('Please select a wallet');
      return;
    }

    if (_amountController.text.trim().isEmpty) {
      _showErrorDialog('Please enter an amount');
      return;
    }

    if (_selectedMethod.isEmpty) {
      _showErrorDialog('Please select a withdrawal method');
      return;
    }

    if (_phoneController.text.trim().isEmpty) {
      _showErrorDialog('Please enter a phone number');
      return;
    }

    double amount;
    try {
      amount = double.parse(_amountController.text.trim());
      if (amount <= 0) {
        _showErrorDialog('Please enter a valid amount');
        return;
      }
    } catch (e) {
      _showErrorDialog('Please enter a valid amount');
      return;
    }

    final selectedWallet = _selectedWallet;
    if (selectedWallet == null) {
      _showErrorDialog('Selected wallet not found');
      return;
    }

    // Check if wallet is unlocked
    if (!_canWithdraw(selectedWallet)) {
      if (selectedWallet.withdrawalDate != null && DateTime.now().isBefore(selectedWallet.withdrawalDate!)) {
        final daysLeft = selectedWallet.withdrawalDate!.difference(DateTime.now()).inDays;
        _showErrorDialog('This wallet is locked. You can withdraw in $daysLeft days.');
        return;
      }
    }

    // Check sufficient balance
    if (amount > selectedWallet.balance) {
      _showErrorDialog('Insufficient balance. Available: \$${selectedWallet.balance.toStringAsFixed(2)}');
      return;
    }

    setState(() {
      _isProcessing = true;
      _showSuccessMessage = false;
    });

    try {
      // Create mobile money details
      final mobileMoneyDetails = MobileMoneyDetails(
        provider: _selectedMethod,
        phoneNumber: _phoneController.text.trim(),
        network: _selectedMethod,
      );

        await _apiService.createTransaction(
        walletId: _selectedWalletId,
        userId: _currentUserId ?? '', // Handle null case
        type: TransactionType.withdrawal,
        amount: amount,
        currency: 'USDT', // You can make this dynamic if needed
        mobileMoneyDetails: mobileMoneyDetails,
        // authToken: 'your-auth-token', // Add if you have authentication
      );

      // Success
      setState(() {
        _showSuccessMessage = true;
      });

      _clearForm();
      
      // Notify parent widget that withdrawal was completed
      widget.onWithdrawComplete?.call();

      // Auto-hide success message after 5 seconds
      Future.delayed(Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _showSuccessMessage = false;
          });
        }
      });

    } catch (e) {
      _showErrorDialog('Failed to process withdrawal: ${e.toString()}');
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _clearForm() {
    _amountController.clear();
    _phoneController.clear();
    setState(() {
      _selectedWalletId = '';
      _selectedMethod = '';
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Center(
            child: Text(
              'WITHDRAW FROM WALLET',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                letterSpacing: 1.0,
              ),
            ),
          ),
          SizedBox(height: 30),
          
          // Select wallet
          Text(
            'Select wallet:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedWalletId.isEmpty ? null : _selectedWalletId,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              hint: Text(
                _wallets.isEmpty ? 'No wallets available' : 'Choose wallet',
                style: TextStyle(color: Colors.grey[500]),
              ),
              items: _wallets.map((WalletModel wallet) {
                final canWithdraw = _canWithdraw(wallet);
                return DropdownMenuItem<String>(
                  value: wallet.id,
                  child: Text(
                    '${wallet.name} (\$${wallet.balance.toStringAsFixed(2)})${_getWalletStatusText(wallet)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: canWithdraw ? Colors.black : Colors.grey,
                    ),
                  ),
                );
              }).toList(),
              onChanged: _isProcessing ? null : (String? newValue) {
                setState(() {
                  _selectedWalletId = newValue ?? '';
                });
              },
            ),
          ),
          SizedBox(height: 25),
          
          // Amount
          Text(
            'Amount:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: _amountController,
              enabled: !_isProcessing,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                hintText: _selectedWallet != null 
                    ? 'Max: \$${_selectedWallet!.balance.toStringAsFixed(2)}'
                    : 'Enter amount (USDT)',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ),
          SizedBox(height: 25),
          
          // Select method
          Text(
            'Select method:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedMethod.isEmpty ? null : _selectedMethod,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              hint: Text(
                'Select withdrawal method',
                style: TextStyle(color: Colors.grey[500]),
              ),
              items: [
                'Mobile Money',
                'Bank Transfer',
                'Cash Pickup',
                'Crypto',
              ].map((String method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              onChanged: _isProcessing ? null : (String? newValue) {
                setState(() {
                  _selectedMethod = newValue ?? '';
                });
              },
            ),
          ),
          SizedBox(height: 25),
          
          // Phone Number
          Text(
            'Phone Number:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: _phoneController,
              enabled: !_isProcessing,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                hintText: 'Enter phone number',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ),
          SizedBox(height: 30),

          // Withdraw button
          Center(
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isProcessing || _wallets.isEmpty || 
                          (_selectedWallet != null && !_canWithdraw(_selectedWallet!))
                    ? null 
                    : _makeWithdrawal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                ),
                child: _isProcessing
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text('Processing...'),
                        ],
                      )
                    : Text(
                        'WITHDRAW',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(height: 20),
          
          // Status message
          if (_isProcessing)
            Text(
              'Processing your withdrawal request...',
              style: TextStyle(
                fontSize: 14,
                color: Colors.orange,
                fontStyle: FontStyle.italic,
              ),
            )
          else if (_showSuccessMessage)
            Text(
              'Success! Your withdrawal is being processed. Check your balance for confirmation.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.green,
                fontStyle: FontStyle.italic,
              ),
            )
          else if (_wallets.isEmpty)
            Text(
              'Please create a wallet first before making a withdrawal.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.red,
                fontStyle: FontStyle.italic,
              ),
            )
          else if (_selectedWallet != null && !_canWithdraw(_selectedWallet!))
            Text(
              'Selected wallet is locked or has insufficient balance.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.red,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            Text(
              'Success! Check your balance for notification.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.teal,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }
}


//faeith code
// import 'package:flutter/material.dart';

// class Withdraw extends StatefulWidget {
//   const Withdraw({super.key});

//   @override
//   State<Withdraw> createState() => _WithdrawState();
// }

// class _WithdrawState extends State<Withdraw> {
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   String _selectedWallet = '';
//   String _selectedMethod = '';

//   @override
//   void dispose() {
//     _amountController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(30),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Title
//           Center(
//             child: Text(
//               'WITHDRAW FROM WALLET',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black,
//                 letterSpacing: 1.0,
//               ),
//             ),
//           ),
//           SizedBox(height: 30),
          
//           // Select wallet
//           Text(
//             'Select wallet:',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.black,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 12),
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey[400]!),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: DropdownButtonFormField<String>(
//               value: _selectedWallet.isEmpty ? null : _selectedWallet,
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//               ),
//               hint: Text(
//                 'Choose wallet',
//                 style: TextStyle(color: Colors.grey[500]),
//               ),
//               items: [
//                 'Savings Wallet',
//                 'Investment Wallet',
//                 'Emergency Wallet',
//                 'Main Wallet',
//               ].map((String wallet) {
//                 return DropdownMenuItem<String>(
//                   value: wallet,
//                   child: Text(wallet),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   _selectedWallet = newValue ?? '';
//                 });
//               },
//             ),
//           ),
//           SizedBox(height: 25),
          
//           // Amount
//           Text(
//             'Amount:',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.black,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 12),
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey[400]!),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: TextField(
//               controller: _amountController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                 hintStyle: TextStyle(color: Colors.grey[500]),
//               ),
//             ),
//           ),
//           SizedBox(height: 25),
          
//           // Select method
//           Text(
//             'Select method:',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.black,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 12),
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey[400]!),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: DropdownButtonFormField<String>(
//               value: _selectedMethod.isEmpty ? null : _selectedMethod,
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//               ),
//               hint: Text(
//                 'Select withdrawal method',
//                 style: TextStyle(color: Colors.grey[500]),
//               ),
//               items: [
//                 'Mobile Money',
//                 'Bank Transfer',
//                 'Cash Pickup',
//                 'Crypto',
//               ].map((String method) {
//                 return DropdownMenuItem<String>(
//                   value: method,
//                   child: Text(method),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   _selectedMethod = newValue ?? '';
//                 });
//               },
//             ),
//           ),
//           SizedBox(height: 25),
          
//           // Phone Number
//           Text(
//             'Phone Number:',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.black,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 12),
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey[400]!),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: TextField(
//               controller: _phoneController,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                 hintStyle: TextStyle(color: Colors.grey[500]),
//               ),
//             ),
//           ),
//           SizedBox(height: 20),
          
//           // Success message
//           Text(
//             'Success! Check your balance for notification.',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.teal,
//               fontStyle: FontStyle.italic,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }