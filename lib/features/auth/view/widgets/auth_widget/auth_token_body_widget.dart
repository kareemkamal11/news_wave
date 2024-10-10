import 'package:flutter/material.dart';
import 'package:news_wave/features/auth/core/static/auth_style.dart';
import 'package:news_wave/features/auth/core/static/auth_texts.dart';
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
            AuthTexts.continueWith,
            style: AuthStyles.titleTextStyle,
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
              isSignup
                  ? AuthTexts.haveAccount
                  : AuthTexts.createAccount,
              style: AuthStyles.titleTextStyle,
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                !isSignup ? AuthTexts.signup : AuthTexts.login,
                style: AuthStyles.clickTextStyle.copyWith(
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
