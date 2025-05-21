import 'package:flutter/material.dart';
import 'package:hypersensifit/services/database_service.dart';
import 'package:hypersensifit/shared/dietary_widget.dart';


class DietPlan extends StatefulWidget {
  const DietPlan({super.key});

  @override
  _DietPlanState createState() => _DietPlanState();
}

class _DietPlanState extends State<DietPlan> {
  bool? _hasHighRisk; // Stores whether high-risk prediction exists
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _checkHighRiskPrediction(); // Check for high-risk prediction on page load
  }

  Future<void> _checkHighRiskPrediction() async {
    final hasRisk = await _dbHelper.hasHighRiskPrediction();
    setState(() {
      _hasHighRisk = hasRisk; // Update state with the result
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (_hasHighRisk == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (_hasHighRisk == false) {
      // If no high-risk record exists
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dietary Plan',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 163, 108),
        ),
        body: const Center(
          child: Text(
            'Nothing to see here yet.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      );
    } else {
      // If a high-risk record exists, show the full diet plan
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dietary Plan',
            style: TextStyle(
              fontWeight: FontWeight.w500,
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
                Text(
                  'DASH DIET',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  '(Dietary Approach to Stop Hypertension)',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.02),
                ...[
                  '• Rich in potassium, calcium, and magnesium',
                  '• Focuses on vegetables, fruits, and whole grains',
                  '• Fat-free or low-fat dairy products',
                  '• Animal protein composed of lean meats (breast part w/o skin), fish, poultry, and eggs',
                  '• More servings of plant proteins like legumes, soy products, nuts, and seeds',
                  '• Limit foods high in salt (sodium) - 1 teaspoon table salt',
                  '• Limit added sugar and saturated fats (such as fatty meats and full-fat dairy products)',
                ].map(
                  (text) => Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.01),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                _buildFoodListHeader(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.03),
                _buildDietarySections(screenWidth, screenHeight),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _buildFoodListHeader(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.06,
      color: const Color.fromARGB(255, 0, 163, 108),
      padding: EdgeInsets.all(screenHeight * 0.01),
      child: Text(
        'Food List',
        style: TextStyle(
          fontSize: screenWidth * 0.045,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Poppins',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDietarySections(double screenWidth, double screenHeight) {
    return Column(
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
            "Spinach",
            "Green leafy & Yellow Vegetables",
          ],
        ),
        SizedBox(height: screenHeight * 0.03),
        dietSection(
          sectionTitle: "FRUITS",
          items: [
            "Bananas",
            "Melons",
            "Peaches",
            "Raisins",
            "Grapes",
            "Mandarin Oranges",
            "Apple",
          ],
        ),
        SizedBox(height: screenHeight * 0.03),
        dietSection(
          sectionTitle: "GRAINS",
          items: ["Brown Rice", "Oatmeal", "Whole Wheat Breads", "Pasta"],
        ),
        SizedBox(height: screenHeight * 0.03),
        dietSection(
          sectionTitle: "DRIED BEANS LEGUMES",
          items: [
            "Peanut Butter",
            "Dry Roasted Peanuts",
            "Almonds",
            "Walnuts",
            "Green Peas",
            "Cashews",
            "Lima Beans",
            "Kidney Beans",
          ],
        ),
        SizedBox(height: screenHeight * 0.03),
        dietSection(
          sectionTitle: "FISH",
          items: ["Salmon", "Cod", "Tuna (Canned)", "Sardines"],
        ),
      ],
    );
  }
}

