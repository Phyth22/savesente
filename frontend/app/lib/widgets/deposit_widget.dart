import 'package:flutter/material.dart';
import '../services/bitnob_api_services.dart';
import '../models/wallet_model.dart';
import '../models/transaction_model.dart';

import '../services/user_auth.dart'; 

class Deposit extends StatefulWidget {
  final VoidCallback? onDepositComplete;
  final List<WalletModel>? availableWallets;
  
  const Deposit({
    super.key, 
    this.onDepositComplete,
    this.availableWallets,
  });

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedMethod = '';
  String _selectedWalletId = '';
  
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

  Future<void> _makeDeposit() async {
    // Validation
    if (_amountController.text.trim().isEmpty) {
      _showErrorDialog('Please enter an amount');
      return;
    }

    if (_selectedWalletId.isEmpty) {
      _showErrorDialog('Please select a wallet');
      return;
    }

    if (_selectedMethod.isEmpty) {
      _showErrorDialog('Please select a payment method');
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
        type: TransactionType.deposit,
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
      
      // Notify parent widget that deposit was completed
      widget.onDepositComplete?.call();

      // Auto-hide success message after 5 seconds
      Future.delayed(Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _showSuccessMessage = false;
          });
        }
      });

    } catch (e) {
      _showErrorDialog('Failed to process deposit: ${e.toString()}');
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
      _selectedMethod = '';
      _selectedWalletId = '';
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
              'DEPOSIT TO WALLET',
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
                return DropdownMenuItem<String>(
                  value: wallet.id,
                  child: Text(
                    '${wallet.name} (\$${wallet.balance.toStringAsFixed(2)})',
                    style: TextStyle(fontSize: 14),
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
                hintText: 'Enter amount (USDT)',
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
                'Select payment method',
                style: TextStyle(color: Colors.grey[500]),
              ),
              items: [
                'Mobile Money',
                'Bank Transfer',
                'Credit Card',
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

          // Deposit button
          Center(
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isProcessing || _wallets.isEmpty ? null : _makeDeposit,
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
                        'DEPOSIT',
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
              'Processing your deposit request...',
              style: TextStyle(
                fontSize: 14,
                color: Colors.orange,
                fontStyle: FontStyle.italic,
              ),
            )
          else if (_showSuccessMessage)
            Text(
              'Success! Your deposit is being processed. Check your wallet balance.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.green,
                fontStyle: FontStyle.italic,
              ),
            )
          else if (_wallets.isEmpty)
            Text(
              'Please create a wallet first before making a deposit.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.red,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            Text(
              'A prompt will be sent to your phone — enter your PIN to complete the transaction.',
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

// class Deposit extends StatefulWidget {
//   const Deposit({super.key});

//   @override
//   State<Deposit> createState() => _DepositState();
// }

// class _DepositState extends State<Deposit> {
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
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
//               'DEPOSIT TO WALLET',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black,
//                 letterSpacing: 1.0,
//               ),
//             ),
//           ),
//           SizedBox(height: 30),
          
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
//                 'Select payment method',
//                 style: TextStyle(color: Colors.grey[500]),
//               ),
//               items: [
//                 'Mobile Money',
//                 'Bank Transfer',
//                 'Credit Card',
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
          
//           // Info message
//           Text(
//             'A prompt has been sent to your phone — enter your PIN to complete the transaction.',
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