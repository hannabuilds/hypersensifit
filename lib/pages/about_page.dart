import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About HyperSensiFit',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 163, 108),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Text(
                'HyperSensiFit is a mobile health application designed to help users predict their risk of developing hypertension and provide a dietary aligned with the Dietary Approaches to Stop Hypertension (DASH) diet. By using the K-Nearest Neighbor (KNN) algorithm, the app analyzes health metrics such as age, blood pressure, cholesterol levels, and smoking habits to determine whether a user is at risk of hypertension.',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Container(
              width: double.infinity,
              color: const Color(0xFF00A36C),
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Text(
                'App Features:',
                style: TextStyle(
                  fontSize: screenWidth * 0.040,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.00),
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• Health Data Input: Users can easily input health parameters such as age, systolic and diastolic blood pressure, cholesterol levels, and smoking status.',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'Poppins',  
                    ),
                    textAlign: TextAlign.justify,
                  ) ,
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    '• Hypertension Risk Prediction: Based on the inputted health data, the app predicts whether a user is at risk of hypertension.',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.justify,
                  ), 
                  SizedBox(height: screenHeight * 0.01),  
                  Text(
                    '• DASH diet: For users at risk, the app provides a dietary aimed at managing blood pressure and reducing hypertension risk.',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.justify, 
                  ), 
                  SizedBox(height: screenHeight * 0.01),   
                  Text(
                    '• Health Data History: Users can track their health data over time, review previous entries, and monitor any changes in their health status.',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.justify,
                  ),  
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Container(
              width: double.infinity,
              color: const Color(0xFF00A36C),
              padding: EdgeInsets.all(screenWidth * 0.02), 
              child: Text(
                'Please note:',
                style: TextStyle(
                  fontSize: screenWidth * 0.040,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.00),
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• The app does not monitor or diagnose health conditions in real-time.',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    '• Dietary plans offered in the app are pre-programmed and are not customized to individual medical needs.',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,       
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    '• Users should not rely on the app as a substitute for consultation with qualified healthcare providers.',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    '• If you have any questions about a medical condition, you should always consult a doctor or other qualified health provider.',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    '• To ensure accurate input of cholesterol levels, heart rate, and glucose levels, it is advisable to undergo a lab test or consult with a healthcare professional.',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Text(
                'HyperSensiFit is not a medical device but serves as an informational tool for early detection and prevention of hypertension. Always consult a healthcare professional for formal diagnosis and treatment recommendations.',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
