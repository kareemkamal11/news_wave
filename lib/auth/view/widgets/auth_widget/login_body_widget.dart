
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/auth_custom_button.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/authentication_field.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/remember_me.dart';
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

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return AppTexts.auth.emailError;
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return AppTexts.auth.passwordError;
    }
    return null;
  }

  Future<void> submitForm() async {
    if (widget.formKey.currentState?.validate() ?? false) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          if (e.code == 'user-not-found') {
            AppTexts.auth.emailError = 'No user found for that email.';
          } else if (e.code == 'wrong-password') {
            AppTexts.auth.passwordError = 'Wrong password provided.';
          } else {
            AppTexts.auth.emailError = 'Authentication failed. Please try again.';
          }
        });
        widget.formKey.currentState?.validate();
      }
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
          isPassword: true,
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
