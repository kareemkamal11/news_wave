import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/auth_custom_button.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/authentication_field.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/remember_me.dart';
import 'package:news_wave/core/static/app_texts.dart';

class SignUpBodyWidget extends StatefulWidget {
  const SignUpBodyWidget({
    super.key,
    required this.isSignup,
    required this.formKey,
  });

  final bool isSignup;
  final GlobalKey<FormState> formKey;

  @override
  State<SignUpBodyWidget> createState() => _SignUpBodyWidgetState();
}

class _SignUpBodyWidgetState extends State<SignUpBodyWidget> {
  bool obscureText = true;
  bool isRemember = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

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

  String? confirmPasswordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return AppTexts.auth.confirmPasswordError;
    }
    return null;
  }

  Future<void> submitForm() async {
    if (widget.formKey.currentState?.validate() ?? false) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          log(e.code);
          // switch (e.code) {
          //   case 'invalid-email':
          //     AppTexts.auth.emailError = 'The email address is not valid.';
          //     break;
          //   case 'user-disabled':
          //     AppTexts.auth.emailError = 'The user account has been disabled.';
          //     break;
          //   case 'user-not-found':
          //     AppTexts.auth.emailError = 'The user account does not exist.';
          //     break;
          //   case 'wrong-password':
          //     AppTexts.auth.passwordError = 'The password is invalid.';
          //     break;
          //   case 'email-already-in-use':
          //     AppTexts.auth.emailError = 'The email is already in use.';
          //     break;
          //   case 'operation-not-allowed':
          //     AppTexts.auth.emailError = 'Operation is not allowed.';
          //     break;
          //   default:
          //     AppTexts.auth.emailError = 'An undefined Error happened.';
          // }
        });
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
        RememberMe(
          isRemember: isRemember,
          isSignup: widget.isSignup,
          onChanged: (value) {
            setState(() {
              isRemember = value!;
            });
          },
        ),
        const SizedBox(height: 15),
        AuthCustomButton(
          onPressed: submitForm,
          label: AppTexts.auth.signup,
        ),
      ],
    );
  }
}
