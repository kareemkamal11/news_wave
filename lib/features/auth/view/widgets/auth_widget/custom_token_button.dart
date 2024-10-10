import 'package:flutter/material.dart';
import 'package:news_wave/features/auth/core/static/auth_style.dart';

class CustomTokenButton extends StatelessWidget {
  final String icon;
  final String label;
  final Function() onPressed;

  const CustomTokenButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.transparent,
      child: Container(
        width: 175,
        height: 50,
        padding:
            const EdgeInsets.only(top: 12, left: 16, right: 24, bottom: 12),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AuthStyles.buttonTokenColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: AuthStyles.tokenTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
