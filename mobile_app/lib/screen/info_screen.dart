import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_app/backend_notifier/dashboard_notifier.dart';
import 'package:mobile_app/components/advisories_card.dart';
import 'package:mobile_app/components/weather_card.dart';
// import 'package:mobile_app/widget/custom_snakeBar.dart';

class InfoScreen extends ConsumerStatefulWidget {
  static String routename = '/info';
  const InfoScreen({super.key});

  @override
  ConsumerState<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends ConsumerState<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final dataState = ref.watch(dashboardNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('dashboard.title'.tr()),
        actions: [
          IconButton(
            onPressed: () {
              ref.invalidate(dashboardNotifierProvider);
            }, 
            icon: Icon(Icons.refresh_rounded)
          )
        ],
      ),
      body: dataState.when(
        loading: () => Scaffold(
          body: Center(child: Lottie.asset('assets/animations/Loading1.json', width: 150, height: 150, repeat: true, reverse: true)),
        ),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (data) {
          if (data == null) {
            return const Center(child: Text("Data is null"));
          }
          return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${'dashboard.welcome'.tr()} ${data['name']} ${data['metadata']['soil'].toString()}'),
                  WeatherCard(weeklyData:data['weather_graph'] , todaysWeather:data['today_weather'], yieldData: data['yield_graph'],),
                  SizedBox(height: height * 0.02),
                  Text('dashboard.todayWeather'.tr(), style: TextStyle(fontWeight: FontWeight.bold)),
                  AdvisoriesCard(advisoriesData: data['today_advisories'])
                ],
              ),
            ),
          ),
        ); }
      ),
    );
  }
}