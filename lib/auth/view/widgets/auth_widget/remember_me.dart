import 'package:flutter/material.dart';
import 'package:news_wave/core/static/app_styles.dart';
import 'package:news_wave/core/static/app_texts.dart';

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
              AppTexts.auth.rememberMe,
              style: AppStyles.auth.titleTextStyle,
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
                  AppTexts.auth.forgotPassword,
                  style: AppStyles.auth.titleTextStyle.copyWith(
                    color: AppStyles.primaryColor,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
