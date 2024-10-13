import 'package:flutter/material.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_texts.dart';
import 'package:news_wave/features/auth/view/widgets/auth_widget/custom_token_button.dart';

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
          icon: AppAssets.facebook,
          label: AppTexts.facebook,
          onPressed: fPressed,
        ),
        const SizedBox(width: 20),
        CustomTokenButton(
          icon: AppAssets.google,
          label: AppTexts.google,
          onPressed: gPressed,
        ),
      ],
    );
  }
}
