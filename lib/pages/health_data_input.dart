import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hypersensifit/pages/high_risk.dart';
import 'package:hypersensifit/pages/low_risk.dart';
import 'package:hypersensifit/shared/text_field_widget.dart';
import 'package:hypersensifit/shared/dropdown_field.dart';
import 'package:intl/intl.dart';
import '../../services/prediction_service.dart';
import '../model/health_data_model.dart';
import '../services/database_service.dart';

class HealthDataInput extends StatefulWidget {
  const HealthDataInput({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HealthDataInputPageState createState() => _HealthDataInputPageState();
}

class _HealthDataInputPageState extends State<HealthDataInput> {
  final KNNService _knnService = KNNService();
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  final HealthData healthData = HealthData(
    sex: '',
    age: 0,
    currentSmoker: false,
    cigsPerDay: 0,
    BPMeds: false,
    diabetes: false,
    totChol: 0,
    sysBP: 0,
    diaBP: 0,
    height: 0,
    weight: 0,
    BMI: 0,
    heartRate: 0,
    glucose: 0,
    id: '',
    date: '',
    predictionResult: 0,
  );

  bool isLoading = false;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  double BMI = 0;
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final _formKeyFirstPage = GlobalKey<FormState>();
  final _formKeySecondPage = GlobalKey<FormState>();
  final TextEditingController cigarettesPerDayController =
      TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cholesterolController = TextEditingController();
  final TextEditingController systolicController = TextEditingController();
  final TextEditingController diastolicController = TextEditingController();
  final TextEditingController heartRateController = TextEditingController();
  final TextEditingController glucoseController = TextEditingController();

  String selectedSex = '';
  String selectedSmoker = '';
  String selectedBpMedication = '';
  String selectedDiabetes = '';
  String? currentSmoker;    
    
  @override
  void initState() {
    super.initState();

    healthData.id = _databaseHelper.generateUniqueId();
    healthData.date = DateTime.now().toIso8601String();

    heightController.addListener(() {
      healthData.height = double.tryParse(heightController.text) ?? 0;
      healthData.calculateBMI();
      setState(() {});
    });

    weightController.addListener(() {
      healthData.weight = double.tryParse(weightController.text) ?? 0;
      healthData.calculateBMI();
      setState(() {});
    });

  }
 

  void _nextPage() {
    if (_formKeyFirstPage.currentState!.validate()) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      setState(() {
        _currentPage++;
      });
    }
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    setState(() {
      _currentPage--;
    });
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _handlePrediction() async {
    if (_formKeySecondPage.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      double height = double.parse(heightController.text);
      double weight = double.parse(weightController.text);
      double calculateBMI = (height > 0 && weight > 0)
          ? double.parse(
              (weight / ((height / 100) * (height / 100))).toStringAsFixed(2))
          : 0;

      // Prepare health data input
      HealthData healthData = HealthData(
        id: _databaseHelper.generateUniqueId(), // Generate a unique ID
        date: DateFormat("MMMM dd, yyyy h:mm a").format(DateTime
            .now()), // Formatted date and time // Store the current date as a string
        sex: selectedSex,
        age: int.parse(ageController.text),
        currentSmoker: selectedSmoker == "Yes",
        cigsPerDay: int.parse(cigarettesPerDayController.text),
        BPMeds: selectedBpMedication == "Yes",
        diabetes: selectedDiabetes == "Yes",
        totChol: double.parse(cholesterolController.text),
        sysBP: double.parse(systolicController.text),
        diaBP: double.parse(diastolicController.text),
        height: double.parse(heightController.text),
        weight: double.parse(weightController.text),
        BMI: calculateBMI,
        heartRate: double.parse(heartRateController.text),
        glucose: double.parse(glucoseController.text),
        predictionResult: -1, // Placeholder for prediction result
      );

      List<double> input = [
        selectedSex == "Male" ? 1.0 : 0.0,
        double.parse(ageController.text),
        selectedSmoker == "Yes" ? 1.0 : 0.0,
        double.parse(cigarettesPerDayController.text),
        selectedBpMedication == "Yes" ? 1.0 : 0.0,
        selectedDiabetes == "Yes" ? 1.0 : 0.0,
        double.parse(cholesterolController.text),
        double.parse(systolicController.text),
        double.parse(diastolicController.text),
        calculateBMI, // BMI calculated from height and weight
        double.parse(heartRateController.text),
        double.parse(glucoseController.text)
      ];

      try {
        // Log input values for debugging
        print("Input data: $input");

        // Perform KNN
        int risk = await _knnService.predict(input);

        // Log the prediction result for debugging
        print("Prediction result: $risk");

        //Update the prediction result in the healthData object

        healthData = HealthData(
          id: healthData.id,
          date: healthData.date,
          sex: healthData.sex,
          age: healthData.age,
          currentSmoker: healthData.currentSmoker,
          cigsPerDay: healthData.cigsPerDay,
          BPMeds: healthData.BPMeds,
          diabetes: healthData.diabetes,
          totChol: healthData.totChol,
          sysBP: healthData.sysBP,
          diaBP: healthData.diaBP,
          BMI: calculateBMI,
          height: healthData.height,
          weight: healthData.weight,
          heartRate: healthData.heartRate,
          glucose: healthData.glucose,
          predictionResult: risk,
        );

        //check if health data exist
        bool dataExists =
            await _databaseHelper.checkHealthDataExists(healthData.id);

        if (dataExists) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Health data is already stored.'),
              duration: Duration(seconds: 4),
            ),
          );
        } else {
          await _databaseHelper.insertHealthData(healthData);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Health data saved successfully.'),
              duration: Duration(seconds: 5),
            ),
          );
        }

        if (risk == 1) {
          Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => const HighRisk(),
            ),
          );
        } else {
          Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => const LowRisk()),
          );
        }
      } on PlatformException catch (e) {
        // Catch TensorFlow Lite errors
        print('TensorFlow Lite Error: $e');

        _showErrorMessage(
            "Prediction failed due to model error. Please try again.");
      } catch (e) {
        // Catch any other errors
        print('Error during prediction: $e');

        _showErrorMessage("Prediction failed. Please try again.");
      } finally {
        setState(() {
          isLoading = false; // Reset loading state
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hypertension Prediction',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_currentPage == 0) {
              Navigator.pop(context);
            } else {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
        backgroundColor: const Color.fromARGB(255, 0, 163, 108),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                _buildFirstPage(),
                _buildSecondPage(),
              ],
            ),
    );
  }

  Widget _buildFirstPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKeyFirstPage,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Please fill out the form below and do not leave any blank to have an accurate prediction.',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 7.0,
              ),
              const Text(
                'Please Note:',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const Text(
                'To ensure accurate input of cholesterol levels, heart rate, and glucose levels, it is advisable to undergo a lab test or consult with a healthcare professional.',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 15),
              DropdownField(
                label: 'Sex',
                options: const ['Male', 'Female'],
                onChanged: (value) {
                  setState(() {
                    selectedSex = value!;
                    healthData.sex = value; // Update healthData
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Sex is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              CustomTextField(
                label: 'Age',
                inputType: TextInputType.number,
                controller: ageController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Age is required';
                  }
                  healthData.age = int.tryParse(value) ?? 0;
                  return null;
                },
              ),
              const SizedBox(height: 15),
              DropdownField(
                label: 'Are you a current smoker?',
                options: const ['Yes', 'No'],
                onChanged: (value) {
                  setState(() {
                    selectedSmoker = value!;
                    healthData.currentSmoker =
                        (selectedSmoker == 'Yes'); // Update healthData

                    // If 'No' is selected, set cigarettes per day to 0 and disable the field
                    if (selectedSmoker == 'No') {
                      cigarettesPerDayController.text = '0';
                    }
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Smoking status is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'If yes, how many cigarettes per day do you consume?',
                inputType: TextInputType.number,
                controller: cigarettesPerDayController,
                enabled:
                    selectedSmoker != 'No', // Disable only if 'No' is selected
                validator: (value) {
                  if (selectedSmoker == 'Yes' &&
                      (value == null || value.isEmpty)) {
                    return 'Cigarettes per day is required';
                  }
                  healthData.cigsPerDay = int.tryParse(value!) ?? 0;
                  return null;
                },
              ),
              const SizedBox(height: 15),
              DropdownField(
                label: 'Are you on medication for hypertension (BP meds)?',
                options: const ['Yes', 'No'],
                onChanged: (value) {
                  setState(() {
                    selectedBpMedication = value!;
                    healthData.BPMeds = (value == 'Yes'); // Update healthData
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'BP medication status is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              DropdownField(
                label: 'Are you diagnosed with diabetes?',
                options: const ['Yes', 'No'],
                onChanged: (value) {
                  setState(() {
                    selectedDiabetes = value!;
                    healthData.diabetes = (value == 'Yes'); // Update healthData
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Diabetes status is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 163, 108),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Poppins'),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecondPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKeySecondPage,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Please fill out the form below and do not leave any blank to have an accurate prediction.',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 7.0,
              ),
              const Text(
                'Please Note:',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const Text(
                'To ensure accurate input of cholesterol levels, heart rate, and glucose levels, it is advisable to undergo a lab test or consult with a healthcare professional.',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                label: 'Total Cholesterol level (mg/dL)',
                inputType: TextInputType.number,
                controller: cholesterolController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Cholesterol level is required';
                  }
                  healthData.totChol = double.tryParse(value) ?? 0;
                  return null;
                },
                infoText:
                    "This is the total amount of cholesterol that’s circulating in your blood. Recommended total cholesterol levels are under 200 milligrams per deciliter (mg/dL) for adults and under 170 mg/dL for children.",
              ),
              const SizedBox(height: 15),
              CustomTextField(
                label: 'Systolic Blood Pressure',
                inputType: TextInputType.number,
                controller: systolicController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Systolic Blood Pressure is required';
                  }
                  healthData.sysBP = double.tryParse(value) ?? 0;
                  return null;
                },
                infoText:
                    'The first number is your  systolic pressure — that’s the force of the blood flow when blood is pumped out of the heart. Your blood pressure changes throughout the day based on your activities. A healthy systolic blood pressure is less than 120.',
              ),
              const SizedBox(height: 15),
              CustomTextField(
                label: 'Diastolic Blood Pressure',
                inputType: TextInputType.number,
                controller: diastolicController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Diastolic Blood Pressure is required';
                  }
                  healthData.diaBP = double.tryParse(value) ?? 0;
                  return null;
                },
                infoText:
                    'The second number is your  diastolic pressure, which is measured between heartbeats when the heart is filling with blood. A healthy diastolic pressure is less than 80.',
              ),
              const SizedBox(height: 15),
              CustomTextField(
                label: 'Height (cm)',
                inputType: TextInputType.number,
                controller: heightController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Height is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              CustomTextField(
                label: 'Weight (kg)',
                inputType: TextInputType.number,
                controller: weightController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Weight is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              Text('Calculated BMI: ${healthData.BMI.toStringAsFixed(2)}'),
              const SizedBox(height: 15),
              CustomTextField(
                label: 'Heart Rate (bpm)',
                inputType: TextInputType.number,
                controller: heartRateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Heart rate is required';
                  }
                  healthData.heartRate = double.tryParse(value) ?? 0;
                  return null;
                },
                infoText:
                    "Your pulse rate, also known as your heart rate, is the number of times your heart beats per minute. A normal resting heart rate should be between 60 to 100 beats per minute, but it can vary from minute to minute. Your age and general health can also affect your pulse rate, so it’s important to remember that a ‘normal’ pulse can vary from person to person.",
              ),
              const SizedBox(height: 15),
              CustomTextField(
                label: 'Glucose Level (mg/dL)',
                inputType: TextInputType.number,
                controller: glucoseController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Glucose level is required';
                  }
                  healthData.glucose = double.tryParse(value) ?? 0;
                  return null;
                },
                infoText:
                    'Glucose level, also known as blood sugar level, is the amount of glucose in the blood. It comes from the food we eat and is also produced and stored in the body. The expected values for normal fasting blood glucose concentration are between 70 mg/dL and 100 mg/dL.',
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _previousPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 163, 108),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Back',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _handlePrediction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 163, 108),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'Predict',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Poppins'),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ],
                    ),
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
