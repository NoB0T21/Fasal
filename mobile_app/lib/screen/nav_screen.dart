import 'package:flutter/material.dart';
import 'package:mobile_app/screen/info_screen.dart';
import 'package:mobile_app/screen/message_screen.dart';
import 'package:mobile_app/screen/pest_detection_screen.dart';

class NavScreen extends StatefulWidget {
  static String routename = '/dashboard';
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int pageIndex = 0;
  // final size = MediaQuery.of(context).size;
  List<Widget> pages = [
    InfoScreen(),
    MessageScreen(),
    PestDetectionScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: pages
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
            ),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.messenger_outline_rounded,
            ),
            label: 'ask',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pest_control_outlined,
            ),
            label: 'detect',
          ),
        ]
      ),
    );
  }
}