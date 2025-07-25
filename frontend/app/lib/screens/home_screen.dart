// import 'package:flutter/material.dart';
// import 'package:hugeicons/hugeicons.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFE5E5E5),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header with profile
//             Container(
//               // CHANGED: SHIFTED HEADER PADDING MORE TO THE RIGHT
//               padding: EdgeInsets.only(left: 40, right: 20, top: 20, bottom: 20),
//               color: Colors.white,
//               child: Row(
//                 children: [
//                   // FIXED: PROFILE BORDER WITH PROPER STYLING
//                   Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Colors.grey[300]!,
//                         width: 2,
//                       ),
//                     ),
//                     child: CircleAvatar(
//                       radius: 25,
//                       backgroundImage: AssetImage('assets/profile.jpg'),
//                       backgroundColor: Colors.white,
//                     ),
//                   ),
//                   SizedBox(width: 15),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Hello,',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.black,
//                         ),
//                       ),
//                       Text(
//                         'HANIFA MEY',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // Main content
//             Expanded(
//               child: Column(
//                 children: [
//                   // Action buttons and balance card section
//                   Container(
//                     padding: EdgeInsets.only(left: 20, top: 40, bottom: 40),
//                     color: Color(0xFFE5E5E5),
//                     child: Row(
//                       children: [
//                         // Left side buttons - extend more to the right
//                         SizedBox(
//                           width: 160, // Extended width
//                           child: Column(
//                             children: [
//                               // Deposit button
//                               Container(
//                                 width: 60,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   shape: BoxShape.circle,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.3),
//                                       blurRadius: 10,
//                                       offset: Offset(0, 9),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Icon(
//                                   Icons.keyboard_double_arrow_right,
//                                   color: Colors.black,
//                                   size: 24,
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               Text(
//                                 'Deposit to\nwallet',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               SizedBox(height: 30),
//                               // Withdraw button
//                               Container(
//                                 width: 60,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   shape: BoxShape.circle,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.3),
//                                       blurRadius: 10,
//                                       offset: Offset(0, 9),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Icon(
//                                   Icons.keyboard_double_arrow_left,
//                                   color: Colors.black,
//                                   size: 24,
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               Text(
//                                 'Withdraw\nfrom\nwallet',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                          SizedBox(width: 50),
//                         // Balance card - extends to right edge
//                         Expanded(
//                           child: Stack(
//                             children: [

//                               // CHANGED: MAIN BALANCE CARD WITH MORE HEIGHT AND CUSTOM BORDER RADIUS + DARKER SHADOW
//                               Container(
//                                 height: 240,
//                                 decoration: BoxDecoration(
//                                   color: Colors.black,
//                                   // SPECIFIED: ONLY TOP-LEFT AND BOTTOM-LEFT ROUNDED
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(25),
//                                     bottomLeft: Radius.circular(25),
//                                     topRight: Radius.circular(0),
//                                     bottomRight: Radius.circular(0),
//                                   ),
//                                   // ADDED: DARKER BOX SHADOW
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.8),
//                                       blurRadius: 20,
//                                       offset: Offset(-3, 12),
//                                       spreadRadius: 2,
//                                     ),
//                                   ],
//                                 ),
//                                 child: Stack(
//                                   children: [
//                                     // Background shape
//                                     Positioned(
//                                       right: -50,
//                                       top: -50,
//                                       child: Container(
//                                         width: 150,
//                                         height: 150,
//                                         decoration: BoxDecoration(
//                                           color: Colors.grey[800],
//                                           shape: BoxShape.circle,
//                                         ),
//                                       ),
//                                     ),
//                                     // Content
//                                     Padding(
//                                       padding: EdgeInsets.all(25),
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'BALANCE',
//                                             style: GoogleFonts.barlow(
//                                               color: Colors.white,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w500,
//                                               letterSpacing: 1.5,
//                                             ),
//                                           ),
//                                           SizedBox(height: 10),

//                                           Row(
//                                             crossAxisAlignment: CrossAxisAlignment.baseline,
//                                             textBaseline: TextBaseline.alphabetic,
//                                             children: [
//                                               Text(
//                                                 '1000',
//                                                 style: GoogleFonts.barlow(
//                                                   color: Colors.white,
//                                                   fontSize: 32,
//                                                   // fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                               SizedBox(width: 8),
//                                               Text(
//                                                 'USDT',
//                                                 style: GoogleFonts.barlow(
//                                                   color: Colors.white,
//                                                   fontSize: 32, // SMALLER SIZE FOR CURRENCY

//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Spacer(),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 'Save Sente',
//                                                 style: GoogleFonts.barlow(
//                                                   color: Colors.white,
//                                                   fontSize: 14,
//                                                 ),
//                                               ),
//                                               SizedBox(width: 10),

//                                               // ignore: sized_box_for_whitespace
//                                               Container(
//                                                 width: 20,
//                                                 height: 20,
//                                                 child: SvgPicture.asset(
//                                                   'assets/icon_white.svg',
//                                                   colorFilter: ColorFilter.mode(
//                                                     Colors.white,
//                                                     BlendMode.srcIn
//                                                   ),
//                                                   placeholderBuilder: (context) => Icon(
//                                                     Icons.account_balance_wallet,
//                                                     color: Colors.white,
//                                                     size: 20,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Recent Transactions - touches both sides and extends to bottom nav
//                   Expanded(
//                     child: Container(
//                       width: double.infinity,
//                       // CHANGED: ADDED PADDING FOR TOP, LEFT, RIGHT
//                       padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Recent Transactions',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           SizedBox(height: 20),

//                           // Transaction items
//                           _buildTransactionItem('- 100,000 ugx', 'savings wallet'),
//                           _buildTransactionItem('+ 500,000 ugx', 'savings wallet'),
//                           _buildTransactionItem('+ 700,000 ugx', 'savings wallet'),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Bottom navigation
//             Container(
//               height: 80,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                 ),
//                 boxShadow: [
//                           BoxShadow(
//                             color: Colors.black,
//                             blurRadius: 30,
//                             offset: Offset(5, 7),
//                           ),
//                         ],
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [

//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       HugeIcon(
//                         icon: HugeIcons.strokeRoundedHome01,
//                         color: Colors.white,
//                         size: 28.0,
//                       ),
//                       SizedBox(width: 8),
//                       Text(
//                         'Home',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ],
//                   ),

//                   // Raised profile button
//                   Transform.translate(
//                     offset: Offset(0, -40), // Raised higher
//                     child: Container(
//                       width: 80,
//                       height: 80,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black,
//                             blurRadius: 8,
//                             offset: Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: HugeIcon(
//                         icon: HugeIcons.strokeRoundedUser,
//                         color: Colors.black,
//                         size: 28.0,
//                       ),
//                     ),
//                   ),

//                   // Wallets button with icon and label in same line
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       HugeIcon(
//                         icon: HugeIcons.strokeRoundedKeyframesDoubleRemove,
//                         color: Colors.white,
//                         size: 28.0,
//                       ),
//                       SizedBox(width: 8),
//                       Text(
//                         'Wallets',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTransactionItem(String amount, String type) {
//     bool isPositive = amount.startsWith('+');
//     return Padding(
//       padding: EdgeInsets.only(bottom: 15),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             amount,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//               color: isPositive ? Colors.green : Colors.red,
//             ),
//           ),
//           Text(
//             type,
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../widgets/bottom_nav_widget.dart';

// // import '../widgets/deposit_widget.dart';
// // import '../widgets/withdraw_widget.dart';

// // import '../screens/wallet_screen.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFE5E5E5),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header with profile
//             Container(
//               // CHANGED: SHIFTED HEADER PADDING MORE TO THE RIGHT
//               padding: EdgeInsets.only(left: 40, right: 20, top: 20, bottom: 20),
//               color: Colors.white,
//               child: Row(
//                 children: [

//                   Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Colors.grey[300]!,
//                         width: 2,
//                       ),
//                     ),
//                     child: CircleAvatar(
//                       radius: 25,
//                       backgroundImage: AssetImage('assets/profile.jpg'),
//                       backgroundColor: Colors.white,
//                     ),
//                   ),
//                   SizedBox(width: 15),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Hello,',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.black,
//                         ),
//                       ),
//                       Text(
//                         'HANIFA MEY',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // Main content
//             Expanded(
//               child: Column(
//                 children: [
//                   // Action buttons and balance card section
//                   Container(
//                     padding: EdgeInsets.only(left: 20, top: 40, bottom: 40),
//                     color: Color(0xFFE5E5E5),
//                     child: Row(
//                       children: [
//                         // Left side buttons - extend more to the right
//                         SizedBox(
//                           width: 160, // Extended width
//                           child: Column(
//                             children: [
//                               // Deposit button
//                               Container(
//                                 width: 60,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   shape: BoxShape.circle,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.3),
//                                       blurRadius: 10,
//                                       offset: Offset(0, 9),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Icon(
//                                   Icons.keyboard_double_arrow_right,
//                                   color: Colors.black,
//                                   size: 24,
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               Text(
//                                 'Deposit to\nwallet',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               SizedBox(height: 30),
//                               // Withdraw button
//                               Container(
//                                 width: 60,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   shape: BoxShape.circle,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.3),
//                                       blurRadius: 10,
//                                       offset: Offset(0, 9),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Icon(
//                                   Icons.keyboard_double_arrow_left,
//                                   color: Colors.black,
//                                   size: 24,
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               Text(
//                                 'Withdraw\nfrom\nwallet',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                          SizedBox(width: 50),
//                         // Balance card - extends to right edge
//                         Expanded(
//                           child: Stack(
//                             children: [

//                               // CHANGED: MAIN BALANCE CARD WITH MORE HEIGHT AND CUSTOM BORDER RADIUS + DARKER SHADOW
//                               Container(
//                                 height: 240,
//                                 decoration: BoxDecoration(
//                                   color: Colors.black,
//                                   // SPECIFIED: ONLY TOP-LEFT AND BOTTOM-LEFT ROUNDED
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(25),
//                                     bottomLeft: Radius.circular(25),
//                                     topRight: Radius.circular(0),
//                                     bottomRight: Radius.circular(0),
//                                   ),
//                                   // ADDED: DARKER BOX SHADOW
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.8),
//                                       blurRadius: 20,
//                                       offset: Offset(-3, 12),
//                                       spreadRadius: 2,
//                                     ),
//                                   ],
//                                 ),
//                                 child: Stack(
//                                   children: [
//                                     // Background shape
//                                     Positioned(
//                                       right: -50,
//                                       top: -50,
//                                       child: Container(
//                                         width: 150,
//                                         height: 150,
//                                         decoration: BoxDecoration(
//                                           color: Colors.grey[800],
//                                           shape: BoxShape.circle,
//                                         ),
//                                       ),
//                                     ),
//                                     // Content
//                                     Padding(
//                                       padding: EdgeInsets.all(25),
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'BALANCE',
//                                             style: GoogleFonts.barlow(
//                                               color: Colors.white,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w500,
//                                               letterSpacing: 1.5,
//                                             ),
//                                           ),
//                                           SizedBox(height: 10),

//                                           Row(
//                                             crossAxisAlignment: CrossAxisAlignment.baseline,
//                                             textBaseline: TextBaseline.alphabetic,
//                                             children: [
//                                               Text(
//                                                 '1000',
//                                                 style: GoogleFonts.barlow(
//                                                   color: Colors.white,
//                                                   fontSize: 32,
//                                                   // fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                               SizedBox(width: 8),
//                                               Text(
//                                                 'USDT',
//                                                 style: GoogleFonts.barlow(
//                                                   color: Colors.white,
//                                                   fontSize: 32, // SMALLER SIZE FOR CURRENCY

//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Spacer(),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 'Save Sente',
//                                                 style: GoogleFonts.barlow(
//                                                   color: Colors.white,
//                                                   fontSize: 14,
//                                                 ),
//                                               ),
//                                               SizedBox(width: 10),

//                                               // ignore: sized_box_for_whitespace
//                                               Container(
//                                                 width: 20,
//                                                 height: 20,
//                                                 child: SvgPicture.asset(
//                                                   'assets/icon_white.svg',
//                                                   colorFilter: ColorFilter.mode(
//                                                     Colors.white,
//                                                     BlendMode.srcIn
//                                                   ),
//                                                   placeholderBuilder: (context) => Icon(
//                                                     Icons.account_balance_wallet,
//                                                     color: Colors.white,
//                                                     size: 20,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Recent Transactions - touches both sides and extends to bottom nav
//                   Expanded(
//                     child: Container(
//                       width: double.infinity,
//                       // CHANGED: ADDED PADDING FOR TOP, LEFT, RIGHT
//                       padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Recent Transactions',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           SizedBox(height: 20),

//                           // Transaction items
//                           _buildTransactionItem('- 100,000 ugx', 'savings wallet'),
//                           _buildTransactionItem('+ 500,000 ugx', 'savings wallet'),
//                           _buildTransactionItem('+ 700,000 ugx', 'savings wallet'),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Bottom navigation - Now using the Nav widget
//             Nav(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTransactionItem(String amount, String type) {
//     bool isPositive = amount.startsWith('+');
//     return Padding(
//       padding: EdgeInsets.only(bottom: 15),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             amount,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//               color: isPositive ? Colors.green : Colors.red,
//             ),
//           ),
//           Text(
//             type,
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/bottom_nav_widget.dart';
import '../widgets/deposit_widget.dart';
import '../widgets/withdraw_widget.dart';
import '../screens/wallet_screen.dart';
// import '../screens/signup_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      body: SafeArea(
        child: Column(
          children: [
            // Header with profile
            Container(
              // CHANGED: SHIFTED HEADER PADDING MORE TO THE RIGHT
              padding: EdgeInsets.only(
                left: 40,
                right: 20,
                top: 20,
                bottom: 20,
              ),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[300]!, width: 2),
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/profile.jpg'),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello,',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Text(
                        'HANIFA MEY',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Main content
            Expanded(
              child: Column(
                children: [
                  // Action buttons and balance card section
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 40, bottom: 40),
                    color: Color(0xFFE5E5E5),
                    child: Row(
                      children: [
                        // Left side buttons - extend more to the right
                        SizedBox(
                          width: 160, // Extended width
                          child: Column(
                            children: [
                              // Deposit button
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => WalletScreen(
                                            initialWidget: Deposit(),
                                          ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 10,
                                        offset: Offset(0, 9),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.keyboard_double_arrow_right,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Deposit to\nwallet',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 30),
                              // Withdraw button
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => WalletScreen(
                                            initialWidget: Withdraw(),
                                          ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 10,
                                        offset: Offset(0, 9),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.keyboard_double_arrow_left,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Withdraw\nfrom\nwallet',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 50),
                        // Balance card - extends to right edge
                        Expanded(
                          child: Stack(
                            children: [
                              // CHANGED: MAIN BALANCE CARD WITH MORE HEIGHT AND CUSTOM BORDER RADIUS + DARKER SHADOW
                              Container(
                                height: 240,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  // SPECIFIED: ONLY TOP-LEFT AND BOTTOM-LEFT ROUNDED
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    bottomLeft: Radius.circular(25),
                                    topRight: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                  ),
                                  // ADDED: DARKER BOX SHADOW
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.8),
                                      blurRadius: 20,
                                      offset: Offset(-3, 12),
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    // Background shape
                                    Positioned(
                                      right: -50,
                                      top: -50,
                                      child: Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[800],
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    // Content
                                    Padding(
                                      padding: EdgeInsets.all(25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'BALANCE',
                                            style: GoogleFonts.barlow(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                          SizedBox(height: 10),

                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Text(
                                                '1000',
                                                style: GoogleFonts.barlow(
                                                  color: Colors.white,
                                                  fontSize: 32,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                'USDT',
                                                style: GoogleFonts.barlow(
                                                  color: Colors.white,
                                                  fontSize:
                                                      32, // SMALLER SIZE FOR CURRENCY
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              Text(
                                                'Save Sente',
                                                style: GoogleFonts.barlow(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(width: 10),

                                              // ignore: sized_box_for_whitespace
                                              Container(
                                                width: 20,
                                                height: 20,
                                                child: SvgPicture.asset(
                                                  'assets/icon_white.svg',
                                                  colorFilter: ColorFilter.mode(
                                                    Colors.white,
                                                    BlendMode.srcIn,
                                                  ),
                                                  placeholderBuilder:
                                                      (context) => Icon(
                                                        Icons
                                                            .account_balance_wallet,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Recent Transactions - touches both sides and extends to bottom nav
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      // CHANGED: ADDED PADDING FOR TOP, LEFT, RIGHT
                      padding: EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 30,
                        bottom: 20,
                      ),
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
                          Text(
                            'Recent Transactions',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),

                          // Transaction items
                          _buildTransactionItem(
                            '- 100,000 ugx',
                            'savings wallet',
                          ),
                          _buildTransactionItem(
                            '+ 500,000 ugx',
                            'savings wallet',
                          ),
                          _buildTransactionItem(
                            '+ 700,000 ugx',
                            'savings wallet',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom navigation - Now using the Nav widget
            Nav(),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(String amount, String type) {
    bool isPositive = amount.startsWith('+');
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isPositive ? Colors.green : Colors.red,
            ),
          ),
          Text(type, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
