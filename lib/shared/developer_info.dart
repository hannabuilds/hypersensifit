import 'package:flutter/material.dart';

void showDeveloperInfo(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Developers',
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Reymon Santianez'),
            ),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Hannah Joy Hotricano'),
            ),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Drake Carcellar'),
            ),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Michelle Almen'),
            ),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Karen Gervacio'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 163, 108),
              ),
              onPressed: () {
                Navigator.pop(context); // Close the bottom sheet
              },
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    },
  );
}
