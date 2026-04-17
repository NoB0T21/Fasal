import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/components/report_data.dart';
import 'package:mobile_app/widget/custom_button.dart';
import 'package:mobile_app/widget/custom_snakeBar.dart';
import 'package:mobile_app/widget/upload_image.dart';

class PestDetectionScreen extends ConsumerStatefulWidget {
  const PestDetectionScreen({super.key});

  @override
  ConsumerState<PestDetectionScreen> createState() => _PestDetectionScreenState();
}

class _PestDetectionScreenState extends ConsumerState<PestDetectionScreen> {
  File? _profileImage;
  int pageIndex = 0;
  bool datapresent = false;

  void _updatePageIndex(int newData) {
    setState(() {
      pageIndex = newData;
      datapresent = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pestDetect.title'.tr()),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                datapresent = false;
              });
            }, 
            icon: Icon(Icons.arrow_back_rounded)
          )
        ],
      ),
      body: Center(
        child: datapresent == false ?  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('pestDetect.subtitle'.tr()),
            UploadImage(
              onImageSelected: (image) {
                setState(() {
                  _profileImage = image;
                });
              },
            ),
            CustomButton(
              onTap: (){
                setState(() {
                  if(_profileImage == null) {
                    CustomSnakebar.show(context, "plese Select Image", Type.error);
                    return;
                  }
                  datapresent = true;
                });
              }, 
              text: "languageSelector.continue".tr()
            )
          ],
        ): ReportScreen(profileImage: _profileImage!, onChanged: _updatePageIndex,),
      )
    );
  }
}