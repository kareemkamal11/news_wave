import 'package:flutter/material.dart';
import 'package:news_wave/features/auth/core/static/auth_style.dart';
import 'package:news_wave/features/auth/core/static/auth_texts.dart';
import 'package:news_wave/core/static/app_styles.dart';

import '../../screens/forgot_password_screen.dart';

class RememberMe extends StatelessWidget {
  const RememberMe({
    super.key,
    required this.isRemember,
    required this.isSignup,
    required this.onChanged,
  });

  final bool isRemember;
  final bool isSignup;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: Checkbox(
                activeColor: AppStyles.primaryColor,
                value: isRemember,
                onChanged: onChanged,
              ),
            ),
            Text(
              AuthTexts.rememberMe,
              style: AuthStyles.titleTextStyle,
            ),
          ],
        ),
        !isSignup
            ? TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ),
                  );
                },
                child: Text(
                  AuthTexts.forgotPassword,
                  style: AuthStyles.titleTextStyle.copyWith(
                    color: AppStyles.primaryColor,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
