import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/provider/riverpod_api.dart';

class AuthNotifier extends AsyncNotifier<Map<String, dynamic>?> {
  @override
  Future<Map<String, dynamic>?> build() async {
    return null;
  }

  Future<void> getOTP(String phoneNumber) async {
    final api = ref.read(backendApiProvider);
    state = await AsyncValue.guard(() async {
      final result = await api.getOTP(phoneNumber);
      print(result);
      return result;
    });
  }

  Future<void> verifyOTP(String phoneNumber,  String otp) async {
    final api = ref.read(backendApiProvider);
    state = await AsyncValue.guard(() async {
      final result = await api.verifyOTP(phoneNumber, otp);
      return result;
    });
  }

  Future<void> verifyUser() async {
    final api = ref.read(backendApiProvider);
    state = await AsyncValue.guard(() async {
      final result = await api.verifyUser();
      return result;
    });
  }

  Future<void> logoutUser() async {
    final api = ref.read(backendApiProvider);
    state = await AsyncValue.guard(() async {
      final result = await api.logoutUser();
      return result;
    });
  }
}

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier,Map<String, dynamic>?>(AuthNotifier.new);