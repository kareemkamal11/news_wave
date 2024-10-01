import 'package:flutter/material.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/custom_token_button.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_texts.dart';

class AuthToken extends StatelessWidget {
  const AuthToken({
    super.key,
    required this.gPressed,
    required this.fPressed,
  });
  final Function() gPressed;
  final Function() fPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTokenButton(
          icon: AppAssets.auth.facebook,
          label: AppTexts.auth.facebook,
          onPressed: fPressed,
        ),
        const SizedBox(width: 20),
        CustomTokenButton(
          icon: AppAssets.auth.google,
          label: AppTexts.auth.google,
          onPressed: gPressed,
        ),
      ],
    );
  }
}
