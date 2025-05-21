import 'package:flutter/material.dart';
import 'package:hypersensifit/pages/about_page.dart';
import 'package:hypersensifit/pages/dashboard.dart';
import 'package:hypersensifit/shared/auth_image.dart';
import 'package:hypersensifit/shared/custom_elevated_button.dart';
import 'package:hypersensifit/shared/developer_info.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve screen height and width
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info_outline,
              color: Colors.black,
            ),
            iconSize: screenWidth * 0.09, // Responsive icon size
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.00),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.05), // Adjust top padding
              const AuthImage(),
              SizedBox(height: screenHeight * 0.03), // Space below AuthImage
              Image.asset(
                'assets/images/hyper_green.png',
                width: screenWidth * 3.00,
                height: screenHeight * 0.22, // 100% of screen width
                fit: BoxFit.cover, // Responsive height
              ),
              SizedBox(height: screenHeight * 0.14), // Space above button
              CustomElevatedButton(
                text: 'Predict Risk of Hypertension',
                backgroundColor: const Color.fromARGB(255, 0, 163, 108),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Dashboard()),
                  );
                },
              ),
              SizedBox(height: screenHeight * 0.05), // Space below button

              // Copyright text row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '© 2024 HyperSensiFit. All rights reserved.',
                    style: TextStyle(
                      fontSize: screenWidth * 0.03, // Responsive text size
                      color: Colors.black54,
                    ),
                  ),
                  // Icon button for developers info
                  IconButton(
                    icon: const Icon(Icons.people,
                        color: Color.fromARGB(255, 0, 163, 108)),
                    iconSize: screenWidth * 0.06, // Responsive icon size
                    onPressed: () => showDeveloperInfo(context),
                    tooltip: 'Developers Info',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
