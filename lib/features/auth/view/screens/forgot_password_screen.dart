// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:news_wave/core/static/app_texts.dart';
import 'package:news_wave/features/auth/view/widgets/auth_widget/auth_custom_button.dart';
import 'package:news_wave/features/auth/view/widgets/auth_widget/authentication_field.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_wave/core/static/app_styles.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController resetPasswordEmailController =
      TextEditingController();
  final FocusNode resetPasswordEmailFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      await _auth.sendPasswordResetEmail(
          email: resetPasswordEmailController.text);
      setState(() {
        AppTexts.authErrorMessages =
            'Password reset email sent. Please check your inbox.';
      });
    } on FirebaseAuthException catch (error) {
      log(error.code);
      setState(() {
        if (error.code == 'INVALID_EMAIL') {
          AppTexts.authErrorMessages =
              'Invalid email address, please enter a valid email.';
        } else {
          AppTexts.authErrorMessages =
              'Failed to send password reset email. Please try again.';
        }
      });
      AppStyles.errorToastr(context, AppTexts.authErrorMessages);
    }

    Navigator.of(context).pop();
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  void dispose() {
    resetPasswordEmailController.dispose();
    resetPasswordEmailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppTexts.forgotPassword),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppTexts.forgotPasswordMessage,
                style: AppStyles.tokenTextStyle,
                textAlign: TextAlign.center,
              ),
              Form(
                key: formKey,
                child: AuthenticationField(
                  controller: resetPasswordEmailController,
                  labelText: AppTexts.email,
                  validator: (value) => emailValidator(value),
                  focusNode: resetPasswordEmailFocusNode,
                ),
              ),
              AuthCustomButton(
                label: AppTexts.resetPassword,
                onPressed: resetPassword,
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
