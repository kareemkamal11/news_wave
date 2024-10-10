import 'package:flutter/material.dart';
import 'package:news_wave/features/auth/core/static/auth_assets.dart';
import 'package:news_wave/features/auth/core/static/auth_texts.dart';
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
          icon: AuthAssets.facebook,
          label: AuthTexts.facebook,
          onPressed: fPressed,
        ),
        const SizedBox(width: 20),
        CustomTokenButton(
          icon: AuthAssets.google,
          label: AuthTexts.google,
          onPressed: gPressed,
        ),
      ],
    );
  }
}
