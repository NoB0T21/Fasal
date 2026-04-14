import 'package:flutter/material.dart';

class CustomeTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final int maxLength;
  const CustomeTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.maxLength,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))
          ),
        ),
    );
  }
}