import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  static String routename = '/info';
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dashboard.title'.tr()),
      ),
      body: Center(
        child: Text('Info Screen'),
      ),
    );
  }
}