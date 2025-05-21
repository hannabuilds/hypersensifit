import 'package:flutter/material.dart';

class PredictionCard extends StatelessWidget {
  final String date;
  final String prediction;
  final bool isHighRisk; // New parameter to indicate high risk
  final VoidCallback onPressed;

  const PredictionCard({
    super.key,
    required this.date,
    required this.prediction,
    required this.isHighRisk, // Initialize the new parameter
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: isHighRisk ? Colors.red : Colors.black, // Red for high risk
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date: $date',
            style: TextStyle(
              fontSize: isSmallScreen ? 14.0 : 16.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: isSmallScreen ? 6.0 : 8.0),
          Text(
            'Prediction Result: ',
            style: TextStyle(
              fontSize: isSmallScreen ? 14.0 : 16.0,
            ),
          ),
          Text(
            prediction,
            style: TextStyle(
              fontSize: isSmallScreen ? 14.0 : 16.0,
              color: isHighRisk
                  ? Colors.red
                  : Colors.black, // Text color red for high risk
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: isSmallScreen ? 6.0 : 8.0),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: isHighRisk
                    ? Colors.red
                    : const Color.fromARGB(
                        255, 0, 163, 108), // Red button for high risk
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 14.0 : 16.0,
                  vertical: isSmallScreen ? 8.0 : 12.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'View Full Data',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 12.0 : 14.0,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
