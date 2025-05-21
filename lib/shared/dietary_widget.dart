import 'package:flutter/material.dart';

// Function to build a section of dietary plan
Widget dietSection(
    {required String sectionTitle, required List<String> items}) {
  int halfLength = (items.length / 2).ceil();
  return Container(
    width: 350,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black, width: 1.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 350,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: const Color.fromARGB(255, 0, 163, 108),
          ),
          child: Text(
            sectionTitle,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: items
                        .sublist(0, halfLength)
                        .map((item) => dietItem(item))
                        .toList(),
                  ),
                ),
                const SizedBox(width: 0.0), // Space between columns
                // Second column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: items
                        .sublist(halfLength)
                        .map((item) => dietItem(item))
                        .toList(),
                  ),
                ),
              ],
            )),
      ],
    ),
  );
}

Widget dietItem(String item) {
  return Text(
    '• $item',
    style: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
    ),
  );
}
