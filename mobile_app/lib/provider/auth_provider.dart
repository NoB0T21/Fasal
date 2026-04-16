import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/provider/riverpod_api.dart';

enum AuthStatus { loading, authenticated, unauthenticated }

final authProvider = FutureProvider<AuthStatus>((ref) async {
  final api = ref.read(backendApiProvider);
  final status = await api.verifyUser();
  print(status);
  if (status['success']) {
    return AuthStatus.authenticated;
  }
  return AuthStatus.unauthenticated;
});