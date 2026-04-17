class ReportDataModel {
  final String pestName;
  final double confidence;
  final String severity;
  final List<dynamic> treatments;
  final String affectedArea;
  final String spreadRisk;
  final String bestTreatmentTime;

  const ReportDataModel({
    required this.pestName,
    required this.confidence,
    required this.severity,
    required this.treatments,
    required this.affectedArea,
    required this.spreadRisk,
    required this.bestTreatmentTime
  });

  factory ReportDataModel.fromJson(Map<String, dynamic> json) {
    return ReportDataModel(
      pestName: json['pest_name']?.toString() ?? '',
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      severity: json['severity']?.toString() ?? '',
      treatments: (json['treatments'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      affectedArea: json['affected_area']?.toString() ?? '',
      spreadRisk: json['spread_risk']?.toString() ?? '',
      bestTreatmentTime:
          json['best_treatment_time']?.toString() ?? '',
    );
  }
}