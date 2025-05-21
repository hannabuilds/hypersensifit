import 'package:flutter/material.dart';
import 'package:hypersensifit/pages/diet_plan.dart';
import 'package:hypersensifit/pages/health_data_input.dart';
import 'package:hypersensifit/pages/health_data_record.dart';
import 'package:hypersensifit/shared/header_widget.dart';
import 'package:hypersensifit/shared/home_background.dart';
import 'package:hypersensifit/shared/custom_elevated_button.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Screen size properties for responsive layout
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: HomeBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.0), // Responsive horizontal padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.03), // Responsive top margin
                const HeaderWidget(),
                SizedBox(
                    height:
                        screenHeight * 0.05), // Responsive space below header
                Text(
                  'Welcome to HyperSensiFit!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.10, // Responsive font size
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(
                    height: screenHeight * 0.2), // Responsive space below title
                Column(
                  children: [
                    CustomElevatedButton(
                      text: 'Hypertension Prediction',
                      backgroundColor: const Color.fromARGB(255, 0, 163, 108),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HealthDataInput(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                        height: screenHeight *
                            0.06), // Responsive spacing between buttons
                    CustomElevatedButton(
                      text: 'Dietary Plan',
                      backgroundColor: const Color.fromARGB(255, 0, 163, 108),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DietPlan(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                        height: screenHeight *
                            0.06), // Responsive spacing between buttons
                    CustomElevatedButton(
                      text: 'Health Data Record',
                      backgroundColor: const Color.fromARGB(255, 0, 163, 108),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HealthDataRecord(),
                          ),
                        );
                      },
                    ),

                    SizedBox(
                      height: screenHeight * 0.15,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
