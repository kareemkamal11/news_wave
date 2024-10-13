import 'package:flutter/material.dart';
import 'package:news_wave/core/static/app_styles.dart';
import 'package:news_wave/core/static/app_texts.dart';
import 'package:news_wave/features/auth/view/widgets/auth_widget/auth_token.dart';

class AuthTokenBodyWidget extends StatelessWidget {
  const AuthTokenBodyWidget({
    super.key,
    required this.gPressed,
    required this.fPressed,
    required this.isSignup,
    required this.onPressed,
  });

  final Function() gPressed;
  final Function() fPressed;

  final bool isSignup;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            AppTexts.continueWith,
            style: AppStyles.titleTextStyle,
          ),
        ),
        const SizedBox(height: 20),
        AuthToken(
          gPressed: gPressed,
          fPressed: fPressed,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isSignup ? AppTexts.haveAccount : AppTexts.createAccount,
              style: AppStyles.titleTextStyle,
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                !isSignup ? AppTexts.signup : AppTexts.login,
                style: AppStyles.clickTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
