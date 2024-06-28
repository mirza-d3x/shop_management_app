import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?>? imagePicker() async {
  final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery, preferredCameraDevice: CameraDevice.front);
  if (pickedImage != null) {
    return File(pickedImage.path);
  }
  return null;
}

void showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onConfirmed,
  VoidCallback? onCancelled,
}) {
  showDialog<bool?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
              if (onCancelled != null) {
                onCancelled();
              }
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop();
              onConfirmed();
            },
          ),
        ],
      );
    },
  );
}
