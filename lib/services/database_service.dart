import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
import '../model/health_data_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  static const Uuid _uuid = Uuid();

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('healthData.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE healthData (
        id TEXT PRIMARY KEY,
        date TEXT,
        sex TEXT,
        age INTEGER,
        currentSmoker INTEGER,
        cigsPerDay INTEGER,
        BPMeds INTEGER,
        diabetes INTEGER,
        totChol REAL,
        sysBP REAL, 
        diaBP REAL,
        height REAL,
        weight REAL, 
        BMI REAL,
        heartRate REAL,
        glucose REAL,
        predictionResult INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE datasetTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sex INTEGER,
        age INTEGER,
        currentSmoker INTEGER,
        cigsPerDay INTEGER,
        BPMeds INTEGER,
        diabetes INTEGER,
        totChol REAL,
        sysBP REAL,
        diaBP REAL,
        BMI REAL,
        heartRate REAL,
        glucose REAL,
        predictionResult INTEGER
      )
    ''');
    print('Database created with two tables.'); 
  }

  Future<int> insertDataset(Map<String, dynamic> row) async {
    final db = await database;
    return await db.insert('datasetTable', row);
  }

  Future<List<Map<String, dynamic>>> getDataset() async {
    final db = await database;
    return await db.query('datasetTable');
  }

  String generateUniqueId() {
    return _uuid.v4(); // Generates a version 4 (random) UUID
  }

  // Check if health data exists in the database
  Future<bool> checkHealthDataExists(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'healthData',
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.isNotEmpty; // Returns true if any data exists
  }

  Future<int> insertHealthData(HealthData healthData) async {
    final db = await instance.database;
    return await db.insert('healthData', healthData.toMap());
  }

  Future<HealthData?> getHealthDataById(String id) async {
    final db = await instance.database;

    final result = await db.query(
      'healthData',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return HealthData.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<List<HealthData>> getAllHealthData() async {
    final db = await instance.database;

    final result = await db.query('healthData', orderBy: 'date DESC');

    return result.map((json) => HealthData.fromMap(json)).toList();
  }

  Future<bool> hasHighRiskPrediction() async {
    final db = await instance.database;
    final result = await db.rawQuery(
        'SELECT 1 FROM healthData WHERE predictionResult = 1 LIMIT 1');
    return result.isNotEmpty; // True if at least one high-risk record exists
  }

  /* Future<int> deleteHealthData(String id) async {
    final db = await instance.database;

    return await db.delete(
      'healthData',
      where: 'id = ?',
      whereArgs: [id],
    );
  } */

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
