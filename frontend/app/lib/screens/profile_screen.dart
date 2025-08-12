
// // SCROLLABLE VIEW 

// import 'package:flutter/material.dart';
// import 'package:hugeicons/hugeicons.dart';
// import 'package:google_fonts/google_fonts.dart';   // Added for Google Fonts
// import '../widgets/bottom_nav_widget.dart';
// import '../widgets/chart_widget.dart';

// class ProfileScreen extends StatefulWidget {
//   final Widget? initialWidget;

//   const ProfileScreen({super.key, this.initialWidget});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final String userName = 'HANIFA MEY';
//   final String userEmail = 'hanifa@gmail.com';
//   final double totalDeposits = 5000;
//   final double totalWithdrawals = 2000;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFE5E5E5),
//       bottomNavigationBar: const Nav(),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // HEADER
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               color: Colors.black,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   HugeIcon(
//                     icon: HugeIcons.strokeRoundedUser,
//                     color: Colors.white,
//                     size: 28.0,
//                   ),
//                   SizedBox(width: 10),
//                   Text(
//                     'PROFILE',
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

//             // SCROLLABLE CONTENT
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20),

//                     // Profile picture + name/email in ROW but centered
//                     Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 color: Colors.white,
//                                 width: 6,
//                               ),
//                             ),
//                             child: const CircleAvatar(
//                               radius: 28,
//                               backgroundImage: AssetImage('assets/profile.jpg'),
//                               backgroundColor: Colors.white,
//                             ),
//                           ),
//                           const SizedBox(width: 15),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 userName,
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               Text(
//                                 userEmail,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // WHITE CONTAINER to bottom
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
//                       decoration: const BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           // Overview word CENTERED
//                           const Text(
//                             'Overview',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 30),

//                           // Total Deposits & Withdrawals
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Column(
//                                 children: [
//                                   const Text(
//                                     'Total Deposits',
//                                     style: TextStyle(
//                                       fontSize: 17,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                     '$totalDeposits USDT',
//                                     style: GoogleFonts.barlow(
//                                       color: Colors.blueGrey,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 children: [
//                                   const Text(
//                                     'Total Withdrawals',
//                                     style: TextStyle(
//                                       fontSize: 17,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                     '$totalWithdrawals USDT',
//                                     style: GoogleFonts.barlow(
//                                       color: Colors.blueGrey,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),

//                           const SizedBox(height: 30),

//                           // DOWNLOAD ICON
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: const [
//                               Icon(
//                                 HugeIcons.strokeRoundedDownload02,
//                                 color: Color(0xFF69535F),
//                                 size: 30,
//                               ),
//                               SizedBox(width: 10),
//                               Text(
//                                 "Download Transaction History",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Color(0xFF69535F),
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),

//                           const SizedBox(height: 30),

//                           // CHART WIDGET
//                           const Chart(),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// STATIC & RESPONSIVE VIEW


import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/bottom_nav_widget.dart';
import '../widgets/chart_widget.dart';

class ProfileScreen extends StatefulWidget {
  final Widget? initialWidget;

  const ProfileScreen({super.key, this.initialWidget});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String userName = 'HANIFA MEY';
  final String userEmail = 'hanifa@gmail.com';
  final double totalDeposits = 5000;
  final double totalWithdrawals = 2000;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      bottomNavigationBar: const Nav(),
      body: SafeArea(
        child: Column(
          children: [
            // // HEADER
            // Container(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
            //   color: const Color(0xFF403c3c),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: const [
            //       HugeIcon(
            //         icon: HugeIcons.strokeRoundedUser,
            //         color: Colors.white,
            //         size: 28.0,
            //       ),
            //       SizedBox(width: 10),
            //       Text(
            //         'PROFILE',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 18,
            //           fontWeight: FontWeight.w500,
            //           letterSpacing: 1.2,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),




            SizedBox(height: screenHeight * 0.03),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    // Profile Image
    Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 6),
      ),
      child: const CircleAvatar(
        radius: 28,
        backgroundImage: AssetImage('assets/profile.jpg'),
        backgroundColor: Colors.white,
      ),
    ),

    const SizedBox(width: 15),

    // Name and Email
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userName,
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
        Text(
          userEmail,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    ),

    const SizedBox(width: 25), // Space between info and button

    // Logout Button
    ElevatedButton(
      onPressed: () {
        // TODO: Add logout logic here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 0,
      ),
      child: const Text(
        "LOGOUT",
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  ],
),


            SizedBox(height: screenHeight * 0.02),

            // MAIN WHITE CONTAINER (fills remaining space)
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.05, screenHeight * 0.03, screenWidth * 0.05, screenHeight * 0.03),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Overview
                    Text(
                      'Overview',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Totals Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Total Deposits',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.008),
                            Text(
                              '$totalDeposits USDT',
                              style: GoogleFonts.barlow(
                                color: Colors.blueGrey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Total Withdrawals',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.008),
                            Text(
                              '$totalWithdrawals USDT',
                              style: GoogleFonts.barlow(
                                color: Colors.blueGrey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // Download Transaction Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          HugeIcons.strokeRoundedDownload02,
                          color: Color(0xFF69535F),
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Download Transaction History",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF69535F),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // CHART expands in remaining space
                    Expanded(
                      child: const Chart(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
