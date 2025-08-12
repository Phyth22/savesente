// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class Terms extends StatefulWidget {
  const Terms({super.key});

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Custom AppBar with tight shadow
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4), // shadow color
                blurRadius: 12, // tighter blur
                offset: const Offset(5, 12), // small downward shadow
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: const Color(0xFF403c3c),
            centerTitle: true,
            title: Text(
              'TERMS OF SERVICE',
              style: GoogleFonts.raleway(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
            leading: IconButton(
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowTurnBackward,
                size: 24.0,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            elevation: 0, // remove default elevation
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Terms of Service Content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '''

Welcome! By accessing or using SAVE SENTE app, you agree to be bound by the following Terms of Service:

1. Eligibility
You must be at least 18 years old and legally permitted to use cryptocurrency services in your jurisdiction.

2. Account Registration
Users must create an account with accurate personal information. Each account can manage multiple USDT wallets. You are responsible for maintaining the confidentiality of your credentials.

3. Wallets & Savings
You may create and manage multiple crypto wallets under your account. Each wallet operates independently for saving USDT.

4. Lock-in Feature
Users can opt to lock their accounts or individual wallets for up to 10 months. During the lock period:

No withdrawals or transfers are permitted.

Lock duration cannot be shortened once set.

5. Security
Save Sente takes reasonable measures to secure user data and funds. However, we are not liable for losses due to unauthorized access resulting from user negligence.

6. No Financial Advice
Save Sente does not provide investment advice. Use of the app is at your own risk.

7. Fees
Save Sente may apply service fees. Any applicable fees will be disclosed prior to confirmation of a transaction or service.

8. Prohibited Use
You agree not to use the app for illegal purposes, including money laundering or fraud. Violations may result in account suspension or reporting to authorities.

9. Termination
We reserve the right to suspend or terminate accounts at our discretion, including for violations of these terms.

10. Changes to Terms
We may update these Terms of Service at any time. Continued use of the app constitutes your acceptance of any changes.

11. Contact
For questions, contact us at: sentesave@gmail.com

By clicking "I AGREE" below, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service and consent to our data collection and processing practices as described above.

Thank you for using our services!
                ''',
                style: GoogleFonts.raleway(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),
            ),

            const SizedBox(height: 30),

            // I AGREE button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                height: 50,
                width: 130,
                child: GestureDetector(
                  onTapDown: (_) => setState(() => isPressed = true),
                  onTapUp: (_) => setState(() => isPressed = false),
                  onTapCancel: () => setState(() => isPressed = false),
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isPressed
                          ? const Color(0xFF403c3c)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: const Color(0xFF403c3c)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'I AGREE',
                      style: GoogleFonts.raleway(
                        fontSize: 18,
                        color: isPressed
                            ? Colors.white
                            : const Color(0xFF403c3c),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
