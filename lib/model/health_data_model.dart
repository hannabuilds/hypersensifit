import 'package:uuid/uuid.dart';

class HealthData {
  String id;
  String sex;
  int age;
  bool currentSmoker;
  int cigsPerDay;
  bool BPMeds;
  bool diabetes;
  double totChol;
  double sysBP;
  double diaBP;
  double height;
  double weight;
  double BMI;
  double heartRate;
  double glucose;
  String date;
  int predictionResult;

  //UUID generator instance
  static const _uuid = Uuid();

  HealthData({
    String? id,
    required this.sex,
    required this.age,
    required this.currentSmoker,
    required this.cigsPerDay,
    required this.BPMeds,
    required this.diabetes,
    required this.totChol,
    required this.sysBP,
    required this.diaBP,
    required this.height,
    required this.weight,
    required this.BMI,
    required this.heartRate,
    required this.glucose,
    required this.date,
    required this.predictionResult,
  }) : id = id ?? _uuid.v4();

  void calculateBMI() {
    if (height > 0 && weight > 0) {
      BMI = weight / ((height / 100) * (height / 100));
    } else {
      BMI = 0;
    }
  }

  // Converts HealthData to a map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sex': sex,
      'age': age,
      'currentSmoker': currentSmoker ? 1 : 0,
      'cigsPerDay': cigsPerDay,
      'BPMeds': BPMeds ? 1 : 0,
      'diabetes': diabetes ? 1 : 0,
      'totChol': totChol,
      'sysBP': sysBP,
      'diaBP': diaBP,
      'height': height,
      'weight': weight,
      'BMI': BMI,
      'heartRate': heartRate,
      'glucose': glucose,
      'date': date,
      'predictionResult': predictionResult,
    };
  }

  // Creates a HealthData instance from a map
  factory HealthData.fromMap(Map<String, dynamic> map) {
    return HealthData(
      id: map['id'],
      sex: map['sex'],
      age: map['age'],
      currentSmoker: map['currentSmoker'] == 1,
      cigsPerDay: map['cigsPerDay'],
      BPMeds: map['BPMeds'] == 1,
      diabetes: map['diabetes'] == 1,
      totChol: (map['totChol'] as num).toDouble(),
      sysBP: map['sysBP'],
      diaBP: map['diaBP'],
      height: map['height'],
      weight: map['weight'],
      BMI: map['BMI'],
      heartRate: map['heartRate'],
      glucose: map['glucose'],
      date: map['date'],
      predictionResult: map['predictionResult'],
    );
  }
}
