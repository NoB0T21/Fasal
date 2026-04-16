import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/provider/auth_provider.dart';
import 'package:mobile_app/screen/home_screen.dart';
import 'package:mobile_app/screen/login_screen.dart';
import 'package:mobile_app/screen/main_screen.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return authState.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const HomeScreen(),
      data: (status) {
        if (status == AuthStatus.authenticated) {
          return const MainScreen();
        }
        return const LoginScreen();
      },
    );
  }
}