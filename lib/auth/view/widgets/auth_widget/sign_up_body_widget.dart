import 'package:flutter/material.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/authentication_field.dart';
import 'package:news_wave/core/static/app_texts.dart';

class SignUpBodyWidget extends StatefulWidget {
  const SignUpBodyWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.confirmPasswordFocusNode,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;

  @override
  State<SignUpBodyWidget> createState() => _SignUpBodyWidgetState();
}

class _SignUpBodyWidgetState extends State<SignUpBodyWidget> {
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? confirmPasswordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != widget.passwordController.text) {
      return AppTexts.auth.confirmPasswordError;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthenticationField(
          labelText: AppTexts.auth.email,
          validator: (value) => emailValidator(value),
          onChanged: (value) {},
          controller: widget.emailController,
          focusNode: widget.emailFocusNode,
        ),
        const SizedBox(height: 10),
        AuthenticationField(
          labelText: AppTexts.auth.password,
          focusNode: widget.passwordFocusNode,
          validator: (value) => passwordValidator(value),
          onChanged: (value) {},
          controller: widget.passwordController,
          isPassword: true,
        ),
        const SizedBox(height: 10),
        AuthenticationField(
          labelText: AppTexts.auth.confirmPassword,
          focusNode: widget.confirmPasswordFocusNode,
          validator: (value) => confirmPasswordValidator(value),
          onChanged: (value) {},
          controller: widget.confirmPasswordController,
          isPassword: true,
        ),
      ],
    );
  }
}
