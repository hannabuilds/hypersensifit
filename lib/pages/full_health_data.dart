import 'package:flutter/material.dart';
import 'package:hypersensifit/model/health_data_model.dart';
import 'package:hypersensifit/services/database_service.dart';

class FullHealthData extends StatefulWidget {
  final String healthDataId;
  const FullHealthData({super.key, required this.healthDataId});

  @override
  State<FullHealthData> createState() => _FullHealthDataState();
}

class _FullHealthDataState extends State<FullHealthData> {
  HealthData? healthData;

  @override
  void initState() {
    super.initState();
    _loadFullHealthData();
  }

  Future<void> _loadFullHealthData() async {
    healthData =
        await DatabaseHelper.instance.getHealthDataById(widget.healthDataId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (healthData == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Health Data Details',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 163, 108),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    String formattedDate = healthData!.date;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Health Data Details',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 161, 108),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, // Responsive horizontal padding
          vertical: 16.0,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
                maxWidth: 600), // Limit max width for larger screens
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date: $formattedDate',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'AGE: ${healthData!.age}\n'
                    'SEX: ${healthData!.sex}\n'
                    'CURRENT SMOKER: ${healthData!.currentSmoker ? 'Yes' : 'No'}\n'
                    'CIGARETTES PER DAY: ${healthData!.cigsPerDay}\n'
                    'ON BP MEDICATION: ${healthData!.BPMeds ? 'Yes' : 'No'}\n'
                    'DIAGNOSED WITH DIABETES: ${healthData!.diabetes ? 'Yes' : 'No'}\n'
                    'TOTAL CHOLESTEROL: ${healthData!.totChol}\n'
                    'SYSTOLIC BLOOD PRESSURE: ${healthData!.sysBP}\n'
                    'DIASTOLIC BLOOD PRESSURE: ${healthData!.diaBP}\n'
                    'BMI: ${healthData!.BMI}\n'
                    'HEART RATE: ${healthData!.heartRate}\n'
                    'GLUCOSE: ${healthData!.glucose}\n',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Text(
                    'PREDICTION RESULT: ${healthData!.predictionResult == 1 ? 'HIGH RISK OF HYPERTENSION' : 'LOW RISK OF HYPERTENSION'}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: healthData!.predictionResult == 1
                          ? Colors.red // Red for high risk
                          : Colors.black, // Green for low risk
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
