import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:app/screens/home_screen.dart';
import 'package:app/screens/wallet_dashboard_screen.dart';
import 'package:app/screens/profile_screen.dart';

class Nav extends StatelessWidget {
  const Nav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 30,
            offset: Offset(5, 7),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Home button
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedHome01,
                  color: Colors.white,
                  size: 28.0,
                ),
                SizedBox(width: 8),
                Text(
                  'Home',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),

          // Raised Profile button
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: Transform.translate(
              offset: const Offset(0, -40), // Raise profile button
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedUser,
                    color: Colors.black,
                    size: 28.0,
                  ),
                ),
              ),
            ),
          ),

          // Wallets button
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WalletDashboardScreen()),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedKeyframesDoubleRemove,
                  color: Colors.white,
                  size: 28.0,
                ),
                SizedBox(width: 8),
                Text(
                  'Wallets',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
