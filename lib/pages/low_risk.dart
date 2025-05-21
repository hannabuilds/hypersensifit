import 'package:flutter/material.dart';
import 'package:hypersensifit/pages/dashboard.dart';
import 'package:hypersensifit/pages/health_data_record.dart';
import 'package:hypersensifit/shared/small_button.dart';

class LowRisk extends StatelessWidget {
  const LowRisk({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to the dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Dashboard(),
              ),
            );
          },
        ),
        title: const Text(
          'Prediction Result',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 163, 108),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Low Risk of Hypertension',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: screenWidth * 0.9, // 90% of screen width
                  padding: EdgeInsets.all(isSmallScreen ? 10.0 : 14.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 0, 163, 108),
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
                    'Great news! You are currently at a low risk of hypertension.',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 25.0),
                Container(
                  width: screenWidth * 0.9, // 90% of screen width
                  padding: EdgeInsets.all(isSmallScreen ? 10.0 : 14.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Text(
                    'Keep up the good work by maintaining a healthy lifestyle. Remember to eat a balanced diet, stay active, and get regular check-ups to ensure you remain healthy. Your health is your wealth!',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(
                    height: 100), // Add space for the button at the bottom
              ],
            ),
          ),
          Positioned(
            left: 16.0,
            bottom: 16.0,
            child: SmallButton(
              label: 'Back',
              icon: Icons.arrow_back,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Dashboard(),
                  ),
                );
              },
              isLeftButton: true, // Specify that this is the left button
            ),
          ),
          Positioned(
            right: 16.0,
            bottom: 16.0,
            child: SmallButton(
              label: 'View Health Data',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HealthDataRecord(),
                  ),
                );
              },
              icon: null,
            ),
          ),
        ],
      ),
    );
  }
}
