import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import '../widgets/bottom_nav_widget.dart';

class WalletDashboardScreen extends StatefulWidget {
  final Widget? initialWidget;

  const WalletDashboardScreen({super.key, this.initialWidget});

  @override
  State<WalletDashboardScreen> createState() => _WalletDashboardScreenState();
}

class _WalletDashboardScreenState extends State<WalletDashboardScreen> {
  final double infoTextSpacing = 20;

  // Example wallets
  final List<Map<String, dynamic>> wallets = [
    {'name': 'Main Wallet', 'balance': 1000, 'locked': false},
    {'name': 'Savings', 'balance': 0, 'locked': false},
    {'name': 'Emergency', 'balance': 5000, 'locked': true},
    {'name': 'Holiday Fund', 'balance': 0, 'locked': false},
    {'name': 'Investment', 'balance': 8000, 'locked': true},
  ];

  // Determine wallet status dynamically
  String getWalletStatus(Map<String, dynamic> wallet) {
    if (wallet['locked'] == true) {
      return 'LOCKED';
    }
    return wallet['balance'] > 0 ? 'ACTIVE' : 'INACTIVE';
  }

  // Prevent inactive wallets from being locked
  void sanitizeWallets() {
    for (var wallet in wallets) {
      if (wallet['balance'] == 0) {
        wallet['locked'] = false;
      }
    }
  }

  void _deleteWallet(int index) {
    if (wallets[index]['balance'] == 0) {
      setState(() {
        wallets.removeAt(index);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot delete a wallet with balance.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    sanitizeWallets();

    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),

      // Fixed bottom navigation
      bottomNavigationBar: const Nav(),

      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedKeyframesDoubleRemove,
                    color: Colors.white,
                    size: 28.0,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'WALLETS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            // SCROLLABLE CONTENT
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: infoTextSpacing),

                 // INFO TEXT
Text(
  "Manage your wallets here. Create up to a maximum of 10 wallets. You can only delete wallets with 0 balance."
  ,
  style: GoogleFonts.outfit(
    color: Colors.cyan,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
),

                      SizedBox(height: 15),

                      // Wallet list
                      ...wallets.map((wallet) {
                        final index = wallets.indexOf(wallet);
                        final status = getWalletStatus(wallet);

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Wallet name + status
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        wallet['name'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        status,
                                        style: TextStyle(
                                          fontSize: 12,
                                          // CHANGE COLORS HERE:
                                          // LOCKED → grey, ACTIVE → green, INACTIVE → red
                                          color: status == 'LOCKED'
                                              ? Colors.grey
                                              : (status == 'ACTIVE'
                                                  ? Colors.green
                                                  : Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${wallet['balance']} USDT',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),

                              // Delete icon (only for INACTIVE wallets)
                              status == 'INACTIVE'
                                  ? IconButton(
                                      icon: HugeIcon(
                                        icon: HugeIcons.strokeRoundedDelete01,
                                        color: const Color(0xFF69535F)
                                            .withOpacity(0.5), // transparency
                                        size: 23.0,
                                      ),
                                      onPressed: () => _deleteWallet(index),
                                    )
                                  : const SizedBox(width: 23),
                            ],
                          ),
                        );
                      }),

                      SizedBox(height: infoTextSpacing),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
