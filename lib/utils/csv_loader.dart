import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import '../services/database_service.dart';

Future<void> loadCSVDataToDatasetTable() async {
  final dbHelper = DatabaseHelper.instance;

  // Load the CSV data from assets
  String rawData =
      await rootBundle.loadString('assets/Hypertension-risk-model.csv');
  List<List<dynamic>> csvData = const CsvToListConverter().convert(rawData);

  // Insert each row into the datasetTable
  for (var row in csvData.skip(1)) {
    // Skip header row
    await dbHelper.insertDataset({
      'sex': row[0],
      'age': row[1],
      'currentSmoker': row[2],
      'cigsPerDay': row[3],
      'BPMeds': row[4],
      'diabetes': row[5],
      'totChol': row[6],
      'sysBP': row[7],
      'diaBP': row[8],
      'BMI': row[9],
      'heartRate': row[10],
      'glucose': row[11],
      'predictionResult': row[12]
    });
  }

  print('CSV data loaded successfully into datasetTable.');
}
