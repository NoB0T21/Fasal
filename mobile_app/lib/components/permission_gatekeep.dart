import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_app/components/auth_wrapper.dart';
import 'package:mobile_app/widget/custom_snakeBar.dart';

class PermissionGatekeeper extends StatefulWidget {
  const PermissionGatekeeper({super.key});

  @override
  State<PermissionGatekeeper> createState() => _PermissionGatekeeperState();
}

class _PermissionGatekeeperState extends State<PermissionGatekeeper> {
  bool _isGranted = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      CustomSnakebar.show(context, "Location permission is permanently denied. Please enable it from settings.", Type.error);
      return;
    }

    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      setState(() => _isGranted = false);
      return;
    }
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      setState(() => _isGranted = true);
    }else {
      setState(() => _isGranted = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // If permission is granted, show the real app
    if (_isGranted) {
      return const AuthWrapper(); 
    }

    // Otherwise, show a screen that blocks the app
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_off, size: 100, color: Colors.red),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "setup.locationDenied".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Text(
              "setup.locationDesc".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
            ElevatedButton(
              onPressed: _checkPermission,
              child: const Text("Retry / Grant Permission"),
            ),
          ],
        ),
      ),
    );
  }
}