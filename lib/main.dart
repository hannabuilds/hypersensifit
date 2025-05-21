import 'package:flutter/material.dart';
import 'package:hypersensifit/pages/terms_and_services.dart';
import 'package:hypersensifit/pages/welcome_screen.dart';
import 'package:hypersensifit/utils/csv_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the CSV data into the database on app start
await loadCSVDataToDatasetTable();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkIfTermsAccepted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('acceptedTerms') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HyperSensiFit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(255, 0, 163, 108)),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: _checkIfTermsAccepted(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data == true) {
              return const WelcomeScreen(); // User has accepted terms
            } else {
              return const TermsAndServices(); // Show terms page
            }
          }
        },
      ),
      routes: {
        '/home': (context) => const WelcomeScreen(),
      },
    );
  }
}
