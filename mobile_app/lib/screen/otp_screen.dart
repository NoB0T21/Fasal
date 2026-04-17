import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_app/backend_notifier/auth_notifier.dart';
import 'package:mobile_app/screen/info_screen.dart';
import 'package:mobile_app/screen/main_screen.dart';
import 'package:mobile_app/utils/graphic.dart';
import 'package:mobile_app/widget/custom_button.dart';
import 'package:mobile_app/widget/custom_snakeBar.dart';
import 'package:mobile_app/widget/custome_textField.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final _storage = FlutterSecureStorage();
  final TextEditingController _OTPController = TextEditingController();

  @override
  void dispose() {
    _OTPController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final phoneNumber = widget.phoneNumber;
    ref.listen(authNotifierProvider, (prev, next) {
      if (next.isLoading || next.isRefreshing) return;
      if (prev == next) return;

      next.whenOrNull(
        error: (error, _) {
          final message = error is Exception
            ? error.toString().replaceFirst('Exception: ', '')
            : 'Something went wrong';
          CustomSnakebar.show(context, message, Type.error);
        },
        data: (data) async {
          if (data != null && data['success'] == true) {
            CustomSnakebar.show(context, "Login successfully", Type.success);
            _OTPController.clear();
            final rawSoilType = await _storage.read(key: 'soilType');
            final rawName = await _storage.read(key: 'name');
            print(rawSoilType);
            if(rawSoilType != null && rawName != null){
              final Map<String, dynamic> value = jsonDecode(rawSoilType);
              if (rawName.isNotEmpty && value['id'] != null) {
                Navigator.pushNamedAndRemoveUntil(
                    context, 
                    InfoScreen.routename, 
                    (route) => false,
                );
                return;
              }
              Navigator.pushNamedAndRemoveUntil(context, MainScreen.routename, (Route<dynamic> route) => false,);
            }
            Navigator.pushNamedAndRemoveUntil(context, MainScreen.routename, (Route<dynamic> route) => false,);
          } else {
            CustomSnakebar.show(context, "Not a Valid OTP", Type.error);
          }
        }
      );
    });
    ref.watch(authNotifierProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Graphic(wanted: false),
                SizedBox(height: size.height * 0.05),
                Text("login.otpLabel".tr(), style: Theme.of(context).textTheme.headlineMedium),
                SizedBox(height: size.height * 0.02),
                Text('OTP Send on +91 $phoneNumber', style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: size.height * 0.02),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("login.otpLabel".tr(), style: Theme.of(context).textTheme.bodyMedium),
                      CustomeTextfield(
                        controller: _OTPController,
                        hintText: "login.otpPlaceholder".tr(),
                        icon: Icons.phone_android_rounded,
                        maxLength: 6,
                        keyboardType: TextInputType.phone,
                      ),
                      CustomButton(
                        onTap: () {
                            String otp = _OTPController.text.trim();
                            if (otp.length != 6 || !RegExp(r'^[0-9]+$').hasMatch(otp)) {
                              CustomSnakebar.show(context, "login.error.invalidOtp".tr(), Type.error);
                              return;
                            }
                            ref.read(authNotifierProvider.notifier).verifyOTP(phoneNumber, otp);
                        }, 
                        text: "login.verify".tr()
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}