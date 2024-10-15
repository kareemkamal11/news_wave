import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static final Color primaryColor = const Color(0xFF0F8ACF);
  static final Color textColor = const Color(0xFF4E4B66);
  static final Color errorColor = const Color(0xFFC20052);
  static final Color buttonTokenColor = const Color(0xFFEEF1F4);
  static final Color textTokenColor = const Color(0xFF667080);

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

  static final bodyDecoration = const ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
    ),
  );
  

  static final errorFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.red,
      width: 3,
    ),
  );

  static final searchFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: primaryColor,
      width: 1.5,
    ),
  );

  static TextStyle get titleTextStyle => GoogleFonts.poppins(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );



  static TextStyle get clickTextStyle => GoogleFonts.poppins(
        color: AppStyles.primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get tokenTextStyle => GoogleFonts.poppins(
        color: textTokenColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );
}
