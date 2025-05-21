import 'package:flutter/material.dart';

class AuthImage extends StatelessWidget {
  const AuthImage({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate width and height as a percentage of screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Image.asset(
        'assets/images/green_heart.png',
        width: screenWidth * 0.4, // 40% of screen width
        height: screenHeight * 0.2, // 20% of screen height
      ),
    );
  }
}
