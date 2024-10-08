import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_wave/core/static/app_styles.dart';

class AuthStyles {
 static final Color textColor = const Color(0xFF4E4B66);
 static final Color errorColor = const Color(0xFFC20052);
 static final Color buttonTokenColor = const Color(0xFFEEF1F4);
 static final Color textTokenColor = const Color(0xFF667080);
 static final Color decorationFieldColor = const Color(0xFF4E4B66);
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
