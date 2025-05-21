import 'package:flutter/material.dart';
import 'package:hypersensifit/pages/dashboard.dart';
import 'package:hypersensifit/pages/full_health_data.dart';
import 'package:hypersensifit/shared/prediction_card.dart';
import '../model/health_data_model.dart';
import '../services/database_service.dart';

class HealthDataRecord extends StatefulWidget {
  const HealthDataRecord({super.key});

  @override
  State<HealthDataRecord> createState() => _HealthDataRecordState();
}

class _HealthDataRecordState extends State<HealthDataRecord> {
  List<HealthData> healthDataList = []; // List to hold health data

  @override
  void initState() {
    super.initState();
    _loadHealthData(); // Load health data on initialization
  }

  Future<void> _loadHealthData() async {
    // Fetch data from the database
    healthDataList = await DatabaseHelper.instance.getAllHealthData();

    // Ensure the UI is updated after data is loaded
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
          'Health Data History',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 163, 108),
      ),
      body: healthDataList.isEmpty // Check if data is empty
          ? const Center(
              child: Text(
                "No health data available",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400),
              ),
            )
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                    maxWidth: 600), // Center content on large screens
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        screenWidth * 0.03, // Responsive horizontal padding
                    vertical: 15.0,
                  ),
                  itemCount: healthDataList
                      .length, // Set the item count based on list length
                  itemBuilder: (context, index) {
                    final healthData =
                        healthDataList[index]; // Access data by index
                    // Parse the existing formatted date and reformat it
                    String formattedDate = healthData.date;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PredictionCard(
                        date:
                            formattedDate, // Use the actual date from health data
                        prediction: healthData.predictionResult == 1
                            ? "High Risk of Hypertension"
                            : "Low Risk of Hypertension",
                        isHighRisk: healthData.predictionResult == 1,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullHealthData(
                                healthDataId:
                                    healthData.id, // Pass the health data ID
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
