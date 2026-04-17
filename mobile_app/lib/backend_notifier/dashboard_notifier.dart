import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_app/provider/riverpod_api.dart';
import 'package:mobile_app/utils/location.dart';

class DashboardNotifier extends AsyncNotifier<Map<String, dynamic>?> {
  @override
  Future<Map<String, dynamic>?> build() async {
    final _storage = FlutterSecureStorage();
    final location = await determinePostion();
    if (location == null) {
      return null;
    }
    final soil = await _storage.read(key: "soilType");
    final name = await _storage.read(key: "name");
    final api = ref.read(backendApiProvider);
    final resultState = await AsyncValue.guard(() async {
      final result = await api.getDashboardData(
        '${jsonDecode(soil!)["id"]} soil', 
        location.latitude.toString(), 
        location.longitude.toString(),
      );
      result['data'].addAll({'name': name});
      return result['data'] as Map<String, dynamic>?;
    });

    return resultState.value;
  }
}

final dashboardNotifierProvider = AsyncNotifierProvider<DashboardNotifier,Map<String, dynamic>?>(DashboardNotifier.new);