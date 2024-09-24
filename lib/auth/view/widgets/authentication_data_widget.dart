
import 'package:flutter/material.dart';
import 'package:news_wave/auth/view/widgets/auth_token_body_widget.dart';
import 'package:news_wave/auth/view/widgets/login_body_widget.dart';
import 'package:news_wave/auth/view/widgets/sign_up_body_widget.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_styles.dart';


class AuthenticationDataWidget extends StatefulWidget {
  const AuthenticationDataWidget({
    super.key,
  });

  @override
  State<AuthenticationDataWidget> createState() =>
      _AuthenticationDataWidgetState();
}

class _AuthenticationDataWidgetState extends State<AuthenticationDataWidget> {
  bool isSignup = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      clipBehavior: Clip.antiAlias,
      decoration: AppStyles.auth.bodyDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            isSignup ? AppAssets.auth.signup : AppAssets.auth.login,
            width: 90,
            height: 40,
          ),
          Form(
            key: formKey,
            child: isSignup
                ? SignUpBodyWidget(
                    isSignup: isSignup,
                    formKey: formKey,
                  )
                : LoginBodyWidget(
                    isSignup: isSignup,
                    formKey: formKey,
                  ),
          ),
          const SizedBox(height: 20),
          AuthTokenBodyWidget(
            gPressed: () {},
            fPressed: () {},
            isSignup: isSignup,
            onPressed: () {
              setState(() {
                isSignup = !isSignup;
              });
            },
          ),
        ],
      ),
    );
  }
}
