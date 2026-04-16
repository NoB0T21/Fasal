import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_app/provider/auth_provider.dart';
import 'package:mobile_app/screen/home_screen.dart';
import 'package:mobile_app/screen/info_screen.dart';
import 'package:mobile_app/screen/login_screen.dart';
import 'package:mobile_app/screen/main_screen.dart';
import 'package:lottie/lottie.dart';

class AuthWrapper extends ConsumerStatefulWidget {
  const AuthWrapper({super.key});

  @override
  ConsumerState<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> with TickerProviderStateMixin {
  final _storage = FlutterSecureStorage();
  late final AnimationController _controller;

  Future<Map<String, String?>> checkStorage() async {
    final rawSoilType = await _storage.read(key: 'soilType');
    final rawName = await _storage.read(key: 'name');
    return {'soilType': rawSoilType, 'name': rawName};
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return authState.when(
      loading: () => Scaffold(
        body: Center(child: Lottie.asset('assets/animations/Loading1.json', width: 150, height: 150, repeat: true, reverse: true)),
      ),
      error: (_, __) => const HomeScreen(),
      data: (status) {
        if (status == AuthStatus.authenticated) {
          return FutureBuilder<Map<String, String?>>(
            future: checkStorage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              }

              final data = snapshot.data;
              final rawSoilType = data?['soilType'];
              final rawName = data?['name'];

              if (rawSoilType != null && rawName != null) {
                try {
                  final Map<String, dynamic> value = jsonDecode(rawSoilType);
                  if (rawName.isNotEmpty && value['id'] != null) {
                    return const InfoScreen();
                  }
                } catch (e) {
                  debugPrint("JSON Error: $e");
                }
              }

              return const MainScreen();
            },
          );
        }
        return Scaffold(
        body: const LoginScreen(),
      );
      },
    );
  }
}