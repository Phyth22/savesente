import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 35, right: 35, top: 20, bottom: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile Section
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey[200]!,
                    width: 6,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Hello,',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'HANIFA MEY',
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                    
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Exchange Rate Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5,
                  spreadRadius: 0.5,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'XΔ/',
                  style: GoogleFonts.raleway(
                    fontSize: 18,
                    color: Colors.cyan,
                  ),
                ),
                Text(
                  '1 USDT ≡ 3,700 UGX',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: Colors.cyan,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
