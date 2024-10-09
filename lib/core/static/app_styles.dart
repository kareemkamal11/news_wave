import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static final auth = _AuthStyles();
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

class _AuthStyles {
  final Color textColor = const Color(0xFF4E4B66);
  final Color errorColor = const Color(0xFFC20052);
  final Color buttonTokenColor = const Color(0xFFEEF1F4);
  final Color textTokenColor = const Color(0xFF667080);
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

  TextStyle get titleTextStyle => GoogleFonts.poppins(
        color: _AuthStyles().textColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  TextStyle get clickTextStyle => GoogleFonts.poppins(
        color: AppStyles.primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  TextStyle get tokenTextStyle => GoogleFonts.poppins(
        color: _AuthStyles().textTokenColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );
}
