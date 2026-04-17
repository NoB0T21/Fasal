import 'package:flutter/material.dart';

class Severity {
  final String type;
  final Color color;
  final double heatLevel;

  const Severity({
    required this.type,
    required this.color,
    required this.heatLevel,
  });
}

/// Static Data
const List<Severity> severData = [
  Severity(type: "Low", color: Colors.green, heatLevel: 0.2),
  Severity(type: "Moderate", color: Colors.orange, heatLevel: 0.4),
  Severity(type: "High", color: Colors.redAccent, heatLevel: 0.6),
  Severity(type: "Critical", color: Colors.red, heatLevel: 0.85),
];

/// ✅ Helper Function (Exported Automatically)
Severity? getSeverityData(String? severityType) {
  try {
    return severData.firstWhere(
      (e) => e.type == severityType,
    );
  } catch (e) {
    return null;
  }
}