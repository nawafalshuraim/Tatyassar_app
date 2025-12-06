import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Base64Helper {
  static Future<String> pickImageAndConvert() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return '';

    final bytes = await File(image.path).readAsBytes();
    return base64Encode(bytes);
  }

  static Image imageFromBase64(String base64) {
    return Image.memory(
      base64Decode(base64),
      fit: BoxFit.cover,
    );
  }
}
