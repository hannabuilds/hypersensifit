// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hypersensifit/shared/custom_elevated_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermsAndServices extends StatefulWidget {
  const TermsAndServices({super.key});

  @override
  State<TermsAndServices> createState() => _TermsAndServices();
}

class _TermsAndServices extends State<TermsAndServices> {
  Future<void> _acceptTerms(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('acceptedTerms', true);
    Navigator.of(context)
        .pushReplacementNamed('/home'); // Redirect to home page
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms and Services',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 163, 108),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
            horizontal: screenWidth * 0.04,
          ),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                width: double.infinity,
                color: const Color(0xFF00A36C),
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: Text(
                  'Terms and Services',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "This mobile app is not a medical device and is designed for informational purposes only. The app provides users with general guidance based on the inputted health data and predictions. However, the app's features and predictions are limited and do not replace professional medical advice, diagnosis, or treatment.",
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      'You understand and agree that any health-related information provided by this app is for general informational purposes only and should not be used in place of professional medical advice.',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              CustomElevatedButton(
                text: 'I Agree',
                backgroundColor: const Color.fromARGB(255, 0, 163, 108),
                textColor: Colors.white,
                onPressed: () => _acceptTerms(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
