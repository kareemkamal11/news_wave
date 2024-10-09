import 'package:flutter/material.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/authentication_field.dart';
import 'package:news_wave/core/static/app_texts.dart';

class SignUpBodyWidget extends StatelessWidget {
  const SignUpBodyWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.confirmPasswordFocusNode,
    required this.emailValidator,
    required this.passwordValidator,
    required this.confirmPasswordValidator,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;
  final Function(String?) emailValidator;
  final Function(String?) passwordValidator;
  final Function(String?) confirmPasswordValidator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthenticationField(
          labelText: AppTexts.auth.email,
          validator: (value) => emailValidator(value),
          onChanged: (value) {},
          controller: emailController,
          focusNode: emailFocusNode,
        ),
        const SizedBox(height: 10),
        AuthenticationField(
          labelText: AppTexts.auth.password,
          focusNode: passwordFocusNode,
          validator: (value) => passwordValidator(value),
          onChanged: (value) {},
          controller: passwordController,
          isPassword: true,
        ),
        const SizedBox(height: 10),
        AuthenticationField(
          labelText: AppTexts.auth.confirmPassword,
          focusNode: confirmPasswordFocusNode,
          validator: (value) => confirmPasswordValidator(value),
          onChanged: (value) {},
          controller: confirmPasswordController,
          isPassword: true,
        ),
      ],
    );
  }
}
