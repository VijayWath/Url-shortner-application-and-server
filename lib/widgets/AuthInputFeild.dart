import 'package:flutter/material.dart';

class AuthInputFeild extends StatelessWidget {
  const AuthInputFeild({
    super.key,
    required this.controller,
    required this.label,
  });
  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            label: Text(label),
          ),
        ),
      ),
    );
  }
}
