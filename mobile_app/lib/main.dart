import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/components/permission_gatekeep.dart';
import 'package:mobile_app/screen/home_screen.dart';
import 'package:mobile_app/screen/info_screen.dart';
import 'package:mobile_app/screen/login_screen.dart';
import 'package:mobile_app/screen/main_screen.dart';
import 'package:mobile_app/theme/main_app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('hi'),
        Locale('mr'),
        Locale('ta'),
        Locale('ja'),
      ],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: ProviderScope(
        child:MyApp()
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fasal',
      theme: MainAppTheme.lightTheme(),
      darkTheme: MainAppTheme.darkTheme(),
      themeMode: ThemeMode.system,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      routes: {
        LoginScreen.routename: (context) => const LoginScreen(),
        HomeScreen.routename: (context) => const HomeScreen(),
        MainScreen.routename: (context) => const MainScreen(),
        InfoScreen.routename: (context) => const InfoScreen(),
      },
      home: const PermissionGatekeeper(),
    );
  }
}
