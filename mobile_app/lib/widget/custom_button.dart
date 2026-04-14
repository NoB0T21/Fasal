import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const CustomButton({
    required this.onTap,
    required this.text,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onTap, 
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        minimumSize: Size(
          width,
          50,
        )
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}