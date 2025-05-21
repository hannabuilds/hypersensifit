import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isLeftButton; // To determine if it's the left button

  const SmallButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.isLeftButton = false, // Default is false (right button)
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 0, 163, 108),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: icon == null ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
           if (icon != null) ...[
          Icon(
            icon,
            color: Colors.white,
          ),
           const SizedBox(width: 8),
           ],
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
