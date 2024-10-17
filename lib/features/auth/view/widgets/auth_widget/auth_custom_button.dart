import 'package:flutter/material.dart';
import 'package:news_wave/core/static/app_styles.dart';

class AuthCustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const AuthCustomButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      focusColor: Colors.transparent,
      splashFactory: InkRipple.splashFactory, 
      child: Container(
        width: 380,
        height: 50,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColors.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
