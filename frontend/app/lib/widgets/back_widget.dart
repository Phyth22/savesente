import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class BackWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  const BackWidget({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: const Color(0xFFD0D0D0),
      child: Row(
        children: [
          IconButton(
            onPressed: onPressed ?? () => Navigator.pop(context),
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedArrowTurnBackward,
              size: 24.0,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onPressed ?? () => Navigator.pop(context),
            child: const Text(
              'Back to home screen',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
