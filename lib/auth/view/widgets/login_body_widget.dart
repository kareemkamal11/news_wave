import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_wave/auth/view/widgets/auth_custom_button.dart';
import 'package:news_wave/auth/view/widgets/authentication_field.dart';
import 'package:news_wave/auth/view/widgets/remember_me.dart';
import 'package:news_wave/core/static/app_texts.dart';

class LoginBodyWidget extends StatefulWidget {
  const LoginBodyWidget({
    super.key,
    required this.isSignup,
    required this.formKey,
  });

  final bool isSignup;
  final GlobalKey<FormState> formKey;

  @override
  State<LoginBodyWidget> createState() => _LoginBodyWidgetState();
}

class _LoginBodyWidgetState extends State<LoginBodyWidget> {
  bool obscureText = true;
  bool isRemember = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Simple regex for email validation
    final emailRegex = RegExp(
        r'^[^@]+@[^@]+\.[^@]+'); // ???? ??????? ??? ???? ?? ???? ???? ????? ??? @ ?????? ?? ?????? ???? ?????? ??
    if (!emailRegex.hasMatch(value)) {
      // ??? ????? ??? ??? ???? ???? ????? ???????? ????? ??? ????? ???? ???? ??? ???????
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

  void submitForm() {
    if (widget.formKey.currentState?.validate() ?? false) {
      // ??? ????? ??? ???? ?????? ????? ?? ??
      // Form is valid, proceed with the login
      log('Form is valid');
    } else {
      // Form is invalid, show errors
      log('Form is invalid');
    }
  }

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
        const SizedBox(height: 20),
        AuthenticationField(
          labelText: AppTexts.auth.password,
          focusNode: passwordFocusNode,
          validator: (value) => passwordValidator(value),
          onChanged: (value) {},
          controller: passwordController,
        ),
        RememberMe(
          isRemember: isRemember,
          isSignup: widget.isSignup,
          onChanged: (value) {
            setState(() {
              isRemember = value!;
            });
          },
        ),
        const SizedBox(height: 25),
        AuthCustomButton(
          onPressed: submitForm,
          label: AppTexts.auth.login,
        ),
      ],
    );
  }
}
