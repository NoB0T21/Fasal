import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_app/models/report_data_model.dart';
import 'package:mobile_app/provider/riverpod_api.dart';

class ReportNotifier extends AsyncNotifier<ReportDataModel?> {
  final File image;

  ReportNotifier(this.image);

  @override
  Future<ReportDataModel?> build() async {
    const storage = FlutterSecureStorage();
    final soil = await storage.read(key: "soilType");
    if (soil == null) throw Exception("Soil type not found in secure storage");

    final api = ref.read(backendApiProvider);
    return api.getReportData('${jsonDecode(soil!)["id"]} soil', image);
  }
}

final reportNotifierProvider =
    AsyncNotifierProvider.autoDispose.family<ReportNotifier, ReportDataModel?, File>(
  (file) => ReportNotifier(file),
);