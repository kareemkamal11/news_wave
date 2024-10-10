import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

class AppStyles {
  static Color primaryColor = const Color(0xFF0F8ACF);

  static errorToastr(BuildContext context, String? errorMessages) {
    FlutterToastr.show(
      errorMessages!,
      context,
      duration: 3,
      backgroundColor: Colors.red,
      textStyle: const TextStyle(fontSize: 15, color: Colors.white),
    );
  }

  static successToastr(BuildContext context, String? successMessages) {
    FlutterToastr.show(
      successMessages!,
      context,
      duration: 3,
      backgroundColor: Colors.green,
      textStyle: const TextStyle(fontSize: 15, color: Colors.white),
    );
  }
}

