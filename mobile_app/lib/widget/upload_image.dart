import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  final Function(File?) onImageSelected;
  const UploadImage({
    super.key,
    required this.onImageSelected,
  });

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded),
              title: const Text('Camera'),
              onTap: () async {
                final image =
                    await _picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  final file = File(image.path);
                  setState(() => _image = file);
                  widget.onImageSelected(file);
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () async {
                final image =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  final file = File(image.path);
                  setState(() => _image = file);
                  widget.onImageSelected(file);
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: size.width,
              height: size.width * 0.8,
              clipBehavior: Clip.antiAlias, // Keeps image inside rounded corners
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: _image == null
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.camera_alt, size: 30, color: Colors.black54),
                    Text('pestDetect.uploadImage'.tr())
                  ],
                )
                : Image.file(_image!, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Upload profile picture',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}