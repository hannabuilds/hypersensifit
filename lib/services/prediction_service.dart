import 'dart:math';
import 'package:hypersensifit/services/database_service.dart';

class KNNService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Fetch all dataset records from datasetTable
  Future<List<Map<String, dynamic>>> _fetchDataset() async {
    return await _dbHelper.getDataset();
  }

  // Calculate Euclidean distance between two data points
  double _calculateDistance(List<double> a, List<double> b) {
    double sum = 0;
    for (int i = 0; i < a.length; i++) {
      sum += pow(a[i] - b[i], 2);
    }
    return sqrt(sum);
  }

  // Predict hypertension risk using KNN
  Future<int> predict(List<double> input, {int k = 13}) async {
    final dataset = await _fetchDataset();
    List<Map<String, dynamic>> distances = [];

    // Calculate the distance between input and each row in the dataset
    for (var row in dataset) {
      List<double> dataPoint = [
        row['sex'] * 1.0,
        row['age'] * 1.0,
        row['currentSmoker'] * 1.0,
        row['cigsPerDay'] * 1.0,
        row['BPMeds'] * 1.0,
        row['diabetes'] * 1.0,
        row['totChol'] * 1.0,
        row['sysBP'] * 1.0,
        row['diaBP'] * 1.0,
        row['BMI'] * 1.0,
        row['heartRate'] * 1.0,
        row['glucose'] * 1.0
      ];

      double distance = _calculateDistance(input, dataPoint);
      distances.add({'distance': distance, 'result': row['predictionResult']});
    }

    // Sort by distance and select the top k neighbors
    distances.sort((a, b) => a['distance'].compareTo(b['distance']));
    List<Map<String, dynamic>> kNearest = distances.take(k).toList();

    // Debugging: Print the k-nearest neighbors and their distances
    for (var neighbor in kNearest) {
      print(
          'Neighbor: ${neighbor['result']}, Distance: ${neighbor['distance']}');
    }

    // Count the number of high and low-risk predictions among k neighbors
    int highRiskCount = kNearest.where((e) => e['result'] == 1).length;
    int lowRiskCount = k - highRiskCount;

    // Return 1 for high risk if highRiskCount is greater, otherwise 0 for low risk
    return highRiskCount > lowRiskCount ? 1 : 0;
  }
}
