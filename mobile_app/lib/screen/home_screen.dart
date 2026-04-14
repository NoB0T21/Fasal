import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/screen/login_screen.dart';
import 'package:mobile_app/utils/graphic.dart';
import 'package:mobile_app/widget/custom_button.dart';

const lang = [
  {'en': 'English'},
  {'hi': 'हिंदी'},
  {'ta': 'தமிழ்'},
  {'ja': '日本語'},
  {'mr': 'मराठी'}
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showLanguageSheet();
    });
  }

  void _showLanguageSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) {
        final width = MediaQuery.of(context).size.width;

        int crossAxisCount;
        if (width < 600) {
          crossAxisCount = 1;
        } else if (width < 1000) {
          crossAxisCount = 2;
        } else if (width < 1400) {
          crossAxisCount = 3;
        } else {
          crossAxisCount = 4;
        }

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select Language",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 3,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                ), 
                itemCount: lang.length,
                itemBuilder: (_, index) {
                  final language = lang[index];
                  return ListTile(
                    title: Text(language.values.first),
                    onTap: () {
                      context.setLocale(Locale(language.keys.first));
                      Navigator.pop(context);
                    },
                  );
                },
              )),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.translate),
            onPressed: () {
              _showLanguageSheet();
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  children: [
                    Text(
                      "onboarding.title".tr(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "onboarding.subtitle".tr(),
                      style: const TextStyle(
                        fontSize: 15
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Graphic(wanted: true,)
                  ],
                )
              ),
              const SizedBox(height: 20),
              CustomButton(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                },
                text: "onboarding.getStarted".tr(),
              )
            ],
          ),
        ),
      ),
    );
  }
}