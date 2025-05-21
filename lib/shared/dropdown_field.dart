import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final String label;
  final List<String> options;
  final String? value;
  final Function(String?)? onChanged;
  final double? height;
  final String? Function(String?)? validator; // Add validator
  final bool enabled; // Add enabled field
  final FocusNode? focusNode;

  const DropdownField({
    super.key,
    required this.label,
    required this.options,
    this.value,
    this.onChanged,
    this.height,
    this.validator, // Initialize validator
    this.enabled = true, // Initialize enabled, default to true
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'Poppins'),
        ),
        const SizedBox(height: 5), // Space between the label and the dropdown
        SizedBox(
          child: DropdownButtonFormField<String>(
            value: value,
            onChanged: enabled ? onChanged : null, // Disable if not enabled
            validator: validator, // Add the validator
            focusNode: focusNode,
            items: options.map<DropdownMenuItem<String>>((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
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
            ),
          ),
        ),
      ],
    );
  }
}
