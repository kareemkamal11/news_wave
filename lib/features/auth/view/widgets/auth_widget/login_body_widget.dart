import 'package:flutter/material.dart';
import 'package:news_wave/features/auth/core/static/auth_texts.dart';
import 'package:news_wave/features/auth/view/widgets/auth_widget/authentication_field.dart';

class LoginBodyWidget extends StatelessWidget {
  const LoginBodyWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.emailValidator,
    required this.passwordValidator,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final Function(String?) emailValidator;
  final Function(String?) passwordValidator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthenticationField(
          labelText: AuthTexts.email,
          validator: (value) => emailValidator(value),
          onChanged: (value) {},
          controller: emailController,
          focusNode: emailFocusNode,
        ),
        const SizedBox(height: 20),
        AuthenticationField(
          labelText: AuthTexts.password,
          focusNode: passwordFocusNode,
          validator: (value) => passwordValidator(value),
          onChanged: (value) {},
          controller: passwordController,
          isPassword: true,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
