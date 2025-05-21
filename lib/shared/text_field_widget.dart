import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextInputType inputType;
  final TextEditingController? controller;
  final double? height;
  final String? Function(String?)? validator; // Validator added
  final FocusNode? focusNode;
  final bool enabled; // Add enabled field
  final String? infoText; // Add infoText parameter

  const CustomTextField({
    super.key,
    required this.label,
    required this.inputType,
    this.controller,
    this.height,
    this.validator, // Initialize validator
    this.enabled = true, // Initialize enabled, default to true
    this.focusNode,
    this.infoText, // Initialize infoText
  });

  void _showInfoDialog(BuildContext context) {
    if (infoText != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              label,
              style: const TextStyle(fontSize: 20, fontFamily: 'Poppins'),
            ),
            content: Text(
              infoText!,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.justify,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              ),
            ),
            if (infoText != null)
              IconButton(
                icon: const Icon(
                  Icons.help_outline,
                  color: Colors.grey,
                  size: 22,
                ),
                onPressed: () => _showInfoDialog(context),
              ),
          ],
        ),
        const SizedBox(height: 5),
        SizedBox(
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: inputType,
            validator: validator, // Add validator
            enabled: enabled, // Enable or disable the field
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 0, 163, 108),
                  width: 2.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
              errorStyle: const TextStyle(
                  height: 0), // Prevents resizing due to error message
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            ),
          ),
        ),
      ],
    );
  }
}
