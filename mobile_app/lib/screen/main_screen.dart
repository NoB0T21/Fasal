import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_app/components/select_soil_type.dart';
import 'package:mobile_app/components/set_name.dart';
import 'package:mobile_app/screen/info_screen.dart';
import 'package:mobile_app/widget/custom_button.dart';
import 'package:mobile_app/widget/custom_snakeBar.dart';

class MainScreen extends StatefulWidget {
  static String routename = '/home';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _storage = FlutterSecureStorage();
  final TextEditingController _nameConotroller = TextEditingController();
  Map<String, dynamic> soilTypes = {
    "id": 'none',
    "name": 'none',
    "description": 'setup.soilTypes.clay.desc',
    "imageUrl": 'https://images.unsplash.com/photo-1757356881780-2eb078fcb472?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxjbGF5JTIwc29pbCUyMHRleHR1cmUlMjBhZ3JpY3VsdHVyZXxlbnwxfHx8fDE3NzU5NzM0Njl8MA&ixlib=rb-4.1.0&q=80&w=1080',
  };

  void _updateSoilType(Map<String, dynamic> newData) {
    setState(() {
      soilTypes = newData;
    });
  }
  
  @override
  void dispose() {
    _nameConotroller.dispose();
    super.dispose();
  }

  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<Widget> pages = [
      SetName(nameConotroller: _nameConotroller),
      SelectSoilType(onChanged: _updateSoilType),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('setup.welcome'.tr()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${'setup.setupProfile'.tr()}: ${_nameConotroller.text}', style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,),
              SizedBox(height: size.height * 0.02),
              Expanded(child: SingleChildScrollView(
                child: IndexedStack(
                  index: pageIndex,
                  children: pages
                ),
              )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        currentIndex: pageIndex,
        onTap: (value) async {
          if(_nameConotroller.text.isEmpty) {
            CustomSnakebar.show(context, "Please enter your name", Type.error);
            return;
          }
          setState(() {
            pageIndex = value;
          });
          if(value==1 && soilTypes['id'] == 'none') {
            CustomSnakebar.show(context, "Please select a soil type", Type.error);
            return;
          }

          if(value == 1 || soilTypes['id'] != 'none'){
            await _storage.write(key: 'name', value: _nameConotroller.text);
            await _storage.write(key: 'soilType', value: jsonEncode(soilTypes));
            Navigator.pushNamedAndRemoveUntil(context, InfoScreen.routename, (Route<dynamic> route) => false,);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
            ),
            label: '',
          ),
        ]
      ),
    );
  }
}