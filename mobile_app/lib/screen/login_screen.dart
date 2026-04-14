import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/screen/otp_screen.dart';
import 'package:mobile_app/utils/graphic.dart';
import 'package:mobile_app/widget/custom_button.dart';
import 'package:mobile_app/widget/custom_snakeBar.dart';
import 'package:mobile_app/widget/custome_textField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                Text("login.title".tr(), style: Theme.of(context).textTheme.headlineMedium),
                SizedBox(height: size.height * 0.02),
                Text("login.subtitle".tr(), style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: size.height * 0.02),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("login.phoneLabel".tr(), style: Theme.of(context).textTheme.bodyMedium),
                      CustomeTextfield(
                        controller: _phoneNumberController,
                        hintText: "login.phonePlaceholder".tr(),
                        icon: Icons.phone_android_rounded,
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                      ),
                      CustomButton(
                        onTap: () {
                            String phoneNumber = _phoneNumberController.text.trim();
                            if (phoneNumber.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
                              CustomSnakebar.show(context, "login.error.invalidPhone".tr(), Type.error);
                              return;
                            }
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return OtpScreen(phoneNumber: phoneNumber,);
                            }));
                        }, 
                        text: "login.sendOtp".tr()
                      )
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  "login.terms".tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}