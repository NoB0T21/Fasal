import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/utils/graphic.dart';
import 'package:mobile_app/widget/custom_button.dart';
import 'package:mobile_app/widget/custom_snakeBar.dart';
import 'package:mobile_app/widget/custome_textField.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
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
                            String phoneNumber = _OTPController.text.trim();
                            if (phoneNumber.length != 6 || !RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
                              CustomSnakebar.show(context, "login.error.invalidOtp".tr(), Type.error);
                              return;
                            }
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            //   return ;
                            // }));
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