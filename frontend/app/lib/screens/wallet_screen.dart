// import 'package:flutter/material.dart';
// import 'package:hugeicons/hugeicons.dart';
// import '../widgets/wallet_widget.dart';
// import '../widgets/back_widget.dart';
// import '../screens/home_screen.dart';

// class WalletScreen extends StatelessWidget {
//   const WalletScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFE5E5E5),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               color: Colors.black,
//               child: Row(
//                 children: [
//                   HugeIcon(
//                     icon: HugeIcons.strokeRoundedMenu01,
//                     color: Colors.white,
//                     size: 24.0,
//                   ),
//                   SizedBox(width: 20),
//                   Text(
//                     'WALLETS',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                       letterSpacing: 1.2,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             // Action buttons
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
//               color: Color(0xFFE5E5E5),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Create wallet button
//                   Column(
//                     children: [
//                       Container(
//                         width: 60,
//                         height: 60,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.2),
//                               blurRadius: 8,
//                               offset: Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Icon(
//                           Icons.add,
//                           color: Colors.black,
//                           size: 28,
//                         ),
//                       ),
//                       SizedBox(height: 12),
//                       Text(
//                         'Create\na\nwallet',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.black,
//                           height: 1.2,
//                         ),
//                       ),
//                     ],
//                   ),
                  
//                   // Deposit button
//                   Column(
//                     children: [
//                       Container(
//                         width: 60,
//                         height: 60,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.2),
//                               blurRadius: 8,
//                               offset: Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Icon(
//                           Icons.keyboard_double_arrow_right,
//                           color: Colors.black,
//                           size: 24,
//                         ),
//                       ),
//                       SizedBox(height: 12),
//                       Text(
//                         'Deposit\nto\nwallet',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.black,
//                           height: 1.2,
//                         ),
//                       ),
//                     ],
//                   ),
                  
//                   // Withdraw button
//                   Column(
//                     children: [
//                       Container(
//                         width: 60,
//                         height: 60,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.2),
//                               blurRadius: 8,
//                               offset: Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Icon(
//                           Icons.keyboard_double_arrow_left,
//                           color: Colors.black,
//                           size: 24,
//                         ),
//                       ),
//                       SizedBox(height: 12),
//                       Text(
//                         'Withdraw\nfrom\nwallet',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.black,
//                           height: 1.2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
            
//             // Create wallet widget
//             Expanded(
//               child: Wallet(),
//             ),
            
//             // Back widget with navigation
//             GestureDetector(
//   onTap: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => Home()),
//     );
//   },
//   child: BackWidget(),
// ),

//           ],
//         ),
//       ),
//     );
//   }
// }











// import 'package:flutter/material.dart';
// import 'package:hugeicons/hugeicons.dart';
// import '../widgets/wallet_widget.dart';
// import '../widgets/back_widget.dart';
// import '../widgets/deposit_widget.dart';
// import '../widgets/withdraw_widget.dart';
// import '../screens/home_screen.dart';

// class WalletScreen extends StatefulWidget {
//   const WalletScreen({super.key});

//   @override
//   State<WalletScreen> createState() => _WalletScreenState();
// }

// class _WalletScreenState extends State<WalletScreen> {
//   Widget? _currentWidget;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFE5E5E5),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               color: Colors.black,
              
//               child: Row(
//                 children: [
//                   HugeIcon(
//                     icon: HugeIcons.strokeRoundedMenu01,
//                     color: Colors.white,
//                     size: 24.0,
//                   ),
//                   SizedBox(width: 20),
//                   Text(
//                     'WALLETS',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                       letterSpacing: 1.2,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             // Action buttons
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
//               color: Color(0xFFE5E5E5),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Create wallet button
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _currentWidget = Wallet();
//                       });
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.2),
//                                 blurRadius: 8,
//                                 offset: Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             Icons.add,
//                             color: Colors.black,
//                             size: 28,
//                           ),
//                         ),
//                         SizedBox(height: 12),
//                         Text(
//                           'Create\na\nwallet',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.black,
//                             height: 1.2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
                  
//                   // Deposit button
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _currentWidget = Deposit();
//                       });
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.2),
//                                 blurRadius: 8,
//                                 offset: Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             Icons.keyboard_double_arrow_right,
//                             color: Colors.black,
//                             size: 24,
//                           ),
//                         ),
//                         SizedBox(height: 12),
//                         Text(
//                           'Deposit\nto\nwallet',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.black,
//                             height: 1.2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
                  
//                   // Withdraw button
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _currentWidget = Withdraw();
//                       });
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.2),
//                                 blurRadius: 8,
//                                 offset: Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             Icons.keyboard_double_arrow_left,
//                             color: Colors.black,
//                             size: 24,
//                           ),
//                         ),
//                         SizedBox(height: 12),
//                         Text(
//                           'Withdraw\nfrom\nwallet',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.black,
//                             height: 1.2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             // Dynamic widget area
//             Expanded(
//               child: SingleChildScrollView(
//                 child: _currentWidget ?? Container(
//                   width: double.infinity,
//                   constraints: BoxConstraints(
//                     minHeight: MediaQuery.of(context).size.height - 
//                              MediaQuery.of(context).padding.top - 
//                              200, // Approximate space for header + buttons + back widget
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
                  
//                   ),
//                 ),
//               ),
//             ),
            
//             // Back widget with navigation
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Home()),
//                 );
//               },
//               child: BackWidget(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }







//faeith code begins

// import 'package:flutter/material.dart';
// import 'package:hugeicons/hugeicons.dart';
// import '../widgets/wallet_widget.dart';
// import '../widgets/back_widget.dart';
// import '../widgets/deposit_widget.dart';
// import '../widgets/withdraw_widget.dart';
// import '../screens/home_screen.dart';

// class WalletScreen extends StatefulWidget {
//   final Widget? initialWidget;
  
//   const WalletScreen({super.key, this.initialWidget});

//   @override
//   State<WalletScreen> createState() => _WalletScreenState();
// }

// class _WalletScreenState extends State<WalletScreen> {
//   Widget? _currentWidget;

//   @override
//   void initState() {
//     super.initState();
//     // Set the initial widget if provided
//     _currentWidget = widget.initialWidget;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFE5E5E5),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               color: Colors.black,
              
//               child: Row(
//                 children: [
//                   HugeIcon(
//                     icon: HugeIcons.strokeRoundedMenu01,
//                     color: Colors.white,
//                     size: 24.0,
//                   ),
//                   SizedBox(width: 20),
//                   Text(
//                     'WALLETS',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                       letterSpacing: 1.2,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             // Action buttons
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
//               color: Color(0xFFE5E5E5),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Create wallet button
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _currentWidget = Wallet();
//                       });
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.2),
//                                 blurRadius: 8,
//                                 offset: Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             Icons.add,
//                             color: Colors.black,
//                             size: 28,
//                           ),
//                         ),
//                         SizedBox(height: 12),
//                         Text(
//                           'Create\na\nwallet',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.black,
//                             height: 1.2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
                  
//                   // Deposit button
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _currentWidget = Deposit();
//                       });
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.2),
//                                 blurRadius: 8,
//                                 offset: Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             Icons.keyboard_double_arrow_right,
//                             color: Colors.black,
//                             size: 24,
//                           ),
//                         ),
//                         SizedBox(height: 12),
//                         Text(
//                           'Deposit\nto\nwallet',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.black,
//                             height: 1.2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
                  
//                   // Withdraw button
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _currentWidget = Withdraw();
//                       });
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.2),
//                                 blurRadius: 8,
//                                 offset: Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             Icons.keyboard_double_arrow_left,
//                             color: Colors.black,
//                             size: 24,
//                           ),
//                         ),
//                         SizedBox(height: 12),
//                         Text(
//                           'Withdraw\nfrom\nwallet',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.black,
//                             height: 1.2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             // Dynamic widget area
//             Expanded(
//               child: SingleChildScrollView(
//                 child: _currentWidget ?? Container(
//                   width: double.infinity,
//                   constraints: BoxConstraints(
//                     minHeight: MediaQuery.of(context).size.height - 
//                              MediaQuery.of(context).padding.top - 
//                              200, // Approximate space for header + buttons + back widget
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
                  
//                   ),
//                 ),
//               ),
//             ),
            
//             // Back widget with navigation
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Home()),
//                 );
//               },
//               child: BackWidget(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../widgets/wallet_widget.dart';
import '../widgets/back_widget.dart';
import '../widgets/deposit_widget.dart';
import '../widgets/withdraw_widget.dart';
import '../screens/home_screen.dart';
import '../services/bitnob_api_services.dart';
import '../models/wallet_model.dart';

class WalletScreen extends StatefulWidget {
  final Widget? initialWidget;
  
  const WalletScreen({super.key, this.initialWidget});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  Widget? _currentWidget;
  final BitnobApiService _apiService = BitnobApiService();
  List<WalletModel> _userWallets = [];
  bool _isLoadingWallets = false;

  @override
  void initState() {
    super.initState();
    // Set the initial widget if provided
    _currentWidget = widget.initialWidget;
    // Load user wallets when screen initializes
    _loadUserWallets();
  }

  // Load user wallets (you'll need to implement this method in your API service)
  Future<void> _loadUserWallets() async {
    setState(() {
      _isLoadingWallets = true;
    });

    try {
      // TODO: Replace with actual user ID from your authentication system
      const String currentUserId = 'current-user-id-here';
      
      final wallets = await _apiService.getUserWallets(
        userId: currentUserId,
        // authToken: 'your-auth-token', // Add if you have authentication
      );
      
      setState(() {
        _userWallets = wallets;
      });
    } catch (e) {
      // Handle error silently or show a snackbar
      // print('Error loading wallets: $e');
    } finally {
      setState(() {
        _isLoadingWallets = false;
      });
    }
  }

  // Callback function when wallet is created
  void _onWalletCreated() {
    // Refresh the wallet list
    _loadUserWallets();
    
    // You can also show a success message or navigate somewhere
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Wallet created successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Callback function when deposit is completed
  void _onDepositComplete() {
    // Refresh the wallet list to update balances
    _loadUserWallets();
  }

  // Callback function when withdrawal is completed
  void _onWithdrawComplete() {
    // Refresh the wallet list to update balances
    _loadUserWallets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: Colors.black,
              
              child: Row(
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedMenu01,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'WALLETS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Spacer(),
                  // Show wallet count
                  if (_userWallets.isNotEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${_userWallets.length} wallet${_userWallets.length != 1 ? 's' : ''}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // Action buttons
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              color: Color(0xFFE5E5E5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Create wallet button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentWidget = Wallet(
                          onWalletCreated: _onWalletCreated,
                        );
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 28,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Create\na\nwallet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Deposit button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentWidget = Deposit(
                          onDepositComplete: _onDepositComplete,
                          availableWallets: _userWallets,
                        );
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.keyboard_double_arrow_right,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Deposit\nto\nwallet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Withdraw button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentWidget = Withdraw(
                          onWithdrawComplete: _onWithdrawComplete,
                          availableWallets: _userWallets,
                        );
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.keyboard_double_arrow_left,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Withdraw\nfrom\nwallet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Dynamic widget area
            Expanded(
              child: SingleChildScrollView(
                child: _currentWidget ?? Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 
                             MediaQuery.of(context).padding.top - 
                             200, // Approximate space for header + buttons + back widget
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: _isLoadingWallets
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.all(50),
                            child: Column(
                              children: [
                                CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Loading wallets...',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Center(
                          child: Padding(
                            padding: EdgeInsets.all(50),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_outlined,
                                  size: 80,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Select an action to get started',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                ),
                                if (_userWallets.isNotEmpty) ...[
                                  SizedBox(height: 10),
                                  Text(
                                    'You have ${_userWallets.length} wallet${_userWallets.length != 1 ? 's' : ''}',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ),
            
            // Back widget with navigation
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              child: BackWidget(),
            ),
          ],
        ),
      ),
    );
  }
}