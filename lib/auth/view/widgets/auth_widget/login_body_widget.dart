import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/auth_custom_button.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/authentication_field.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/remember_me.dart';
import 'package:news_wave/core/static/app_texts.dart';
import 'dart:developer';

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
  bool firebaseError = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (firebaseError) {
      return AppTexts.auth.emailError;
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (firebaseError) {
      return AppTexts.auth.passwordError;
    }
    return null;
  }

  Future<void> submitForm() async {
    if (widget.formKey.currentState?.validate() == false) {
      return;
    } else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        log('login successful');
      } on FirebaseAuthException catch (e) {
        setState(() {
          firebaseError = true;
          log(e.message.toString());

          // switch (e.code) {
          //   case 'user-not-found':
          //     AppTexts.auth.emailError = 'Email is incorrect, enter a valid email or sign up';
          //     break;
          //   case 'wrong-password':
          //     AppTexts.auth.passwordError = 'Password is incorrect, enter a valid password';
          //     break;
          //   default:
          //     AppTexts.auth.emailError = 'An error occurred, please try again';
          //     break;
          // }
          widget.formKey.currentState?.validate();
        });
      }
    }
    log('login done');
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
        const SizedBox(height: 20),
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
