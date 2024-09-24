import 'package:flutter/material.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/auth_token.dart';
import 'package:news_wave/core/static/app_styles.dart';
import 'package:news_wave/core/static/app_texts.dart';

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
            AppTexts.auth.continueWith,
            style: AppStyles.auth.titleTextStyle,
          ),
        ),
        const SizedBox(height: 20),
        AuthToken(
          gPressed: () {},
          fPressed: () {},
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isSignup
                  ? AppTexts.auth.haveAccount
                  : AppTexts.auth.createAccount,
              style: AppStyles.auth.titleTextStyle,
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                !isSignup ? AppTexts.auth.signup : AppTexts.auth.login,
                style: AppStyles.auth.clickTextStyle.copyWith(
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
