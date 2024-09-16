import 'package:flutter/material.dart';

class AppStyles {
  static final auth = _AuthStyles();
  static Color primaryColor = const Color(0xFF0F8ACF);
}

class _AuthStyles {
  final Color textColor = const Color(0xFF4E4B66);
  final Color errorColor = const Color(0xFFC20052);
  final Color decorationFieldColor = const Color(0xFF4E4B66);
  final bodyDecoration = const ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
    ),
  );

  final errorFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.red,
      width: 3,
    ),
  );
}
