import 'package:flutter/material.dart';
import 'package:hypersensifit/pages/dashboard.dart';
import 'package:hypersensifit/pages/health_data_record.dart';
import 'package:hypersensifit/shared/dietary_widget.dart';
import 'package:hypersensifit/shared/small_button.dart';

class HighRisk extends StatelessWidget {
  const HighRisk({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'High Risk of Hypertension',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 330,
              padding: const EdgeInsets.all(14.0), // Space inside the box
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 3.0), // Red border
                borderRadius:
                    BorderRadius.circular(10.0), // Optional rounded corners
              ),
              child: const Text(
                'You are at Risk of Hypertension!',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // Text styling
              ),
            ),
            const SizedBox(height: 10.0),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(
                    'Below is a Dietary Approaches to Stop Hypertension (DASH) Diet. The foods emphasize Fruits, Vegetables, Whole Grains, Lean Proteins, and Low-Fat Dairy, and keep sodium intake low.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: 345,
                  height: 40, // Make the box fill the width of the screen
                  color: const Color.fromARGB(
                      255, 0, 163, 108), // Background color for the box
                  padding: const EdgeInsets.all(8.0), // Padding inside the box
                  child: const Text(
                    'Food List',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      dietSection(
                        sectionTitle: "VEGETABLES",
                        items: [
                          "Bell Peppers",
                          "Tomatoes",
                          "Carrots",
                          "Celery",
                          "Cucumber",
                          "Broccoli",
                          "Spinach"
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      dietSection(
                        sectionTitle: "FRUITS",
                        items: [
                          "Bananas",
                          "Melons",
                          "Peaches",
                          "Raisins",
                          "Grapes",
                          "Mandarin Oranges",
                          "Apple"
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      dietSection(
                        sectionTitle: "GRAINS",
                        items: [
                          "Brown Rice",
                          "Oatmeal",
                          "Whole Wheat Breads",
                          "Pasta",
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      dietSection(
                        sectionTitle: "DRIED BEANS LEGUMES",
                        items: [
                          "Peanut Butter",
                          "Almonds",
                          "Walnuts",
                          "Green Peas",
                          "Cashews",
                          "Lima Beans",
                          "Kidney Beans",
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      dietSection(
                        sectionTitle: "FISH",
                        items: [
                          "Salmon",
                          "Cod",
                          "Tuna (Canned)",
                          "Sardines",
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Add the buttons here
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallButton(
                    label: 'Back',
                    icon: Icons.arrow_back,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Dashboard(),
                        ),
                      );
                    },
                    isLeftButton: true,
                  ),
                  SmallButton(
                    label: 'View Health Data',
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HealthDataRecord(),
                        ),
                      );
                    },
                    icon: null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
