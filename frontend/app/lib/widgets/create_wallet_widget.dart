import 'package:flutter/material.dart';
import '../services/bitnob_api_services.dart';
import '../models/wallet_model.dart';

class Wallet extends StatefulWidget {
  final VoidCallback? onWalletCreated;
  
  const Wallet({super.key, this.onWalletCreated});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final TextEditingController _walletNameController = TextEditingController();
  String _selectedWalletType = 'Locked';
  final TextEditingController _withdrawPeriodController = TextEditingController();
  
  final BitnobApiService _apiService = BitnobApiService();
  bool _isCreating = false;
  DateTime? _calculatedUnlockDate;

  @override
  void initState() {
    super.initState();
    // Listen to withdraw period changes to calculate unlock date
    _withdrawPeriodController.addListener(_calculateUnlockDate);
  }

  @override
  void dispose() {
    _walletNameController.dispose();
    _withdrawPeriodController.dispose();
    super.dispose();
  }

  void _calculateUnlockDate() {
    final daysText = _withdrawPeriodController.text;
    if (daysText.isNotEmpty) {
      try {
        final days = int.parse(daysText);
        setState(() {
          _calculatedUnlockDate = DateTime.now().add(Duration(days: days));
        });
      } catch (e) {
        setState(() {
          _calculatedUnlockDate = null;
        });
      }
    } else {
      setState(() {
        _calculatedUnlockDate = null;
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '01/01/2026';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _createWallet() async {
    // Validation
    if (_walletNameController.text.trim().isEmpty) {
      _showErrorDialog('Please enter a wallet name');
      return;
    }

    if (_selectedWalletType == 'Locked' && _withdrawPeriodController.text.trim().isEmpty) {
      _showErrorDialog('Please enter withdrawal period for locked wallet');
      return;
    }

    if (_selectedWalletType == 'Locked' && _calculatedUnlockDate == null) {
      _showErrorDialog('Please enter a valid number of days');
      return;
    }

    setState(() {
      _isCreating = true;
    });

    try {
      // For locked wallets, use calculated date. For direct access, use current date + 1 day (minimum)
      final withdrawalDate = _selectedWalletType == 'Locked' 
          ? _calculatedUnlockDate!
          : DateTime.now().add(Duration(days: 1));

      // TODO: Replace with actual user ID from your authentication system
      const String currentUserId = 'current-user-id-here'; // You'll need to get this from your auth system

      final response = await _apiService.createWallet(
        name: _walletNameController.text.trim(),
        withdrawalDate: withdrawalDate,
        customerId: currentUserId,
        // authToken: 'your-auth-token', // Add if you have authentication
      );

      // Success
      _showSuccessDialog(response);
      _clearForm();
      
      // Notify parent widget that wallet was created
      widget.onWalletCreated?.call();

    } catch (e) {
      _showErrorDialog('Failed to create wallet: ${e.toString()}');
    } finally {
      setState(() {
        _isCreating = false;
      });
    }
  }

  void _clearForm() {
    _walletNameController.clear();
    _withdrawPeriodController.clear();
    setState(() {
      _selectedWalletType = 'Locked';
      _calculatedUnlockDate = null;
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

  void _showSuccessDialog(CreateWalletResponse response) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Wallet created successfully!'),
              SizedBox(height: 10),
              Text('Name: ${response.wallet.name}'),
              Text('Balance: \$${response.wallet.balance.toStringAsFixed(2)}'),
              if (response.wallet.addressDetails?.address != null)
                Text('Address: ${response.wallet.addressDetails!.address}'),
            ],
          ),
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
              'CREATE WALLET',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                letterSpacing: 1.0,
              ),
            ),
          ),
          SizedBox(height: 30),
          
          // Wallet name
          Text(
            'Wallet name:',
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
              controller: _walletNameController,
              enabled: !_isCreating,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                hintText: 'Enter wallet name',
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ),
          SizedBox(height: 25),
          
          // Wallet type
          Text(
            'Wallet type:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: 'Locked',
                    groupValue: _selectedWalletType,
                    onChanged: _isCreating ? null : (String? value) {
                      setState(() {
                        _selectedWalletType = value!;
                      });
                    },
                    activeColor: Colors.black,
                  ),
                  Text(
                    'Locked',
                    style: TextStyle(
                      fontSize: 16,
                      color: _isCreating ? Colors.grey : Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 30),
              Row(
                children: [
                  Radio<String>(
                    value: 'Direct Access',
                    groupValue: _selectedWalletType,
                    onChanged: _isCreating ? null : (String? value) {
                      setState(() {
                        _selectedWalletType = value!;
                      });
                    },
                    activeColor: Colors.black,
                  ),
                  Text(
                    'Direct Access',
                    style: TextStyle(
                      fontSize: 16,
                      color: _isCreating ? Colors.grey : Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 25),
          
          // Withdraw period (show only for locked wallets)
          if (_selectedWalletType == 'Locked') ...[
            Text(
              'Withdraw period:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _withdrawPeriodController,
                    enabled: !_isCreating,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      hintText: 'Days',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wallet will be unlocked on:',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      _formatDate(_calculatedUnlockDate),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
          ] else ...[
            SizedBox(height: 30),
          ],

          // Create wallet button
          Center(
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isCreating ? null : _createWallet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                ),
                child: _isCreating
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
                          Text('Creating Wallet...'),
                        ],
                      )
                    : Text(
                        'CREATE WALLET',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}






//faeith code starts here
// import 'package:flutter/material.dart';

// class Wallet extends StatefulWidget {
//   const Wallet({super.key});

//   @override
//   State<Wallet> createState() => _WalletState();
// }

// class _WalletState extends State<Wallet> {
//   final TextEditingController _walletNameController = TextEditingController();
//   String _selectedWalletType = 'Locked';
//   final TextEditingController _withdrawPeriodController = TextEditingController();

//   @override
//   void dispose() {
//     _walletNameController.dispose();
//     _withdrawPeriodController.dispose();
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
//               'CREATE WALLET',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black,
//                 letterSpacing: 1.0,
//               ),
//             ),
//           ),
//           SizedBox(height: 30),
          
//           // Wallet name
//           Text(
//             'Wallet name:',
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
//               controller: _walletNameController,
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                 hintStyle: TextStyle(color: Colors.grey[500]),
//               ),
//             ),
//           ),
//           SizedBox(height: 25),
          
//           // Wallet type
//           Text(
//             'Wallet type:',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.black,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 15),
//           Row(
//             children: [
//               Row(
//                 children: [
//                   Radio<String>(
//                     value: 'Locked',
//                     groupValue: _selectedWalletType,
//                     onChanged: (String? value) {
//                       setState(() {
//                         _selectedWalletType = value!;
//                       });
//                     },
//                     activeColor: Colors.black,
//                   ),
//                   Text(
//                     'Locked',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(width: 30),
//               Row(
//                 children: [
//                   Radio<String>(
//                     value: 'Direct Access',
//                     groupValue: _selectedWalletType,
//                     onChanged: (String? value) {
//                       setState(() {
//                         _selectedWalletType = value!;
//                       });
//                     },
//                     activeColor: Colors.black,
//                   ),
//                   Text(
//                     'Direct Access',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 25),
          
//           // Withdraw period
//           Text(
//             'Withdraw period:',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.black,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 12),
//           Row(
//             children: [
//               Container(
//                 width: 80,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey[400]!),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: TextField(
//                   controller: _withdrawPeriodController,
//                   textAlign: TextAlign.center,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 15),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Wallet will be unlocked on:',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   Text(
//                     '01/01/2026',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }