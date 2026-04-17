import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
final Map<String, dynamic> mockData = {
  "weather_graph": {
    "spots": [
      {
        "x": 0,
        "y": 30.5,
        "day": "Today"
      },
      {
        "x": 1,
        "y": 31.2,
        "day": "Tomorrow"
      },
      {
        "x": 2,
        "y": 32.0,
        "day": "Day 3"
      },
      {
        "x": 3,
        "y": 33.5,
        "day": "Day 4"
      },
      {
        "x": 4,
        "y": 34.1,
        "day": "Day 5"
      },
      {
        "x": 5,
        "y": 33.8,
        "day": "Day 6"
      },
      {
        "x": 6,
        "y": 33.0,
        "day": "Day 7"
      },
      {
        "x": 7,
        "y": 32.5,
        "day": "Day 8"
      }
    ]
  },
  "yield_graph": {
    "data": [
      {
        "month": "Month 1",
        "yield": 150
      },
      {
        "month": "Month 2",
        "yield": 220
      },
      {
        "month": "Month 3",
        "yield": 350
      },
      {
        "month": "Month 4",
        "yield": 480
      },
      {
        "month": "Month 5",
        "yield": 550
      },
      {
        "month": "Month 6",
        "yield": 600
      }
    ]
  },
  "today_advisories": [
    {
      "type": "Irrigation",
      "message": "**WATER DEEPLY IN THE EARLY MORNING OR LATE EVENING.**",
      "subtext": "Clay soil has high water retention but poor drainage. Water deeply to ensure moisture reaches root zones, and irrigate during cooler parts of the day to minimize evaporation and prevent surface crusting in these high temperatures."
    },
    {
      "type": "Soil Management",
      "message": "**APPLY MULCH IMMEDIATELY.**",
      "subtext": "With temperatures exceeding 33°C, mulching will significantly reduce soil surface evaporation, prevent crust formation, and keep the clay soil cooler and more workable."
    },
    {
      "type": "Fertilization",
      "message": "**HOLD OFF ON NITROGEN FERTILIZERS.**",
      "subtext": "High temperatures can lead to volatilization losses of nitrogen. It's better to apply nitrogen when temperatures are moderate to ensure efficient uptake by the crop."
    }
  ],
  "today_weather": {
    "temperature": "33°C",
    "condition": "Sunny",
    "Humidity": "65%",
    "Wind": "15 km/h"
  },
  "metadata": {
    "soil_type": "Clay Soil",
    "location": "San Francisco, CA (Lat: 37.7749, Lon: -122.4194)"
  }
};

class WeatherCard extends StatelessWidget {
  final List<dynamic>? weeklyData;
  final List<dynamic>? yieldData;
  final Map<String, dynamic>? todaysWeather;
  const WeatherCard({
    super.key,
    this.weeklyData,
    this.yieldData,
    this.todaysWeather,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('dashboard.todayWeather'.tr(), style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildHeader(todaysWeather),
            const SizedBox(height: 30),
            _buildChart(weeklyData),
            const SizedBox(height: 40),
            Text('dashboard.cropPerformance'.tr(), style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(children: [
              Icon(Icons.trending_up_rounded, color: Colors.green,),
              const SizedBox(width: 8),
              Text('dashboard.yieldTrends'.tr(), style: TextStyle(fontWeight: FontWeight.bold)),
            ],),
            const SizedBox(height: 10),
            _buildBarChart(yieldData)
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic>? todaysWeather) {
    if (todaysWeather == null) {
      return const Text('No data available');
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.wb_sunny_outlined, color: Colors.orange, size: 40),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${todaysWeather["temperature"] != null ? todaysWeather["temperature"].toString() : todaysWeather["temp"].toString()}°C', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                Text(todaysWeather["condition"], style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('${todaysWeather["humidity"].toString()}%', style: TextStyle(color: Colors.grey, fontSize: 12)),
            Text('${todaysWeather["wind"].toString()} km/h', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildChart(List<dynamic>? weeklyData) {
    if (weeklyData == null) {
      return const Text('No data available');
    }
    return SizedBox(
      height: 130,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false), // No background grid lines
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < weeklyData.length) {
                    return Text(weeklyData[value.toInt()]["day"], style: const TextStyle(fontSize: 12, color: Colors.grey));
                  }
                  return const Text('');
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: List<FlSpot>.generate(
                weeklyData.length,
                (i) => FlSpot(i.toDouble(), weeklyData[i]["y"].toDouble()),
              ),
              isCurved: true,          // Makes the line wavy/smooth
              color: Colors.green,
              barWidth: 2,
              dotData: FlDotData(  
                show: true,
                getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                  radius: 4,
                  color: Colors.green,
                  strokeWidth: 0,
                ),
              ),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart(List<dynamic>? yieldData) {
    if (yieldData == null) {
      return const Text('No data available');
    }

    return SizedBox(
      height: 180,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: yieldData.map((data) => (data["yield"] as num).toDouble()).reduce(max) + 5,
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < yieldData.length) {
                    return Text(yieldData[value.toInt()]["month"], style: const TextStyle(fontSize: 12, color: Colors.grey));
                  }
                  return const Text('');
                },
              ),
            ),
          ),
          barGroups: List<BarChartGroupData>.generate(
            yieldData.length,
            (i) {
              final data = yieldData[i];
              return BarChartGroupData(
                x: i, 
                barRods: [
                  BarChartRodData(
                    toY: data["yield"].toDouble(), 
                    color: Colors.green, 
                    width: 18,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )
                  )
                ]
              );
            }
          )
        ),
      ),
    );
  }
}