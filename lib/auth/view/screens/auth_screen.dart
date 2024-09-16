import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_styles.dart';
import 'package:news_wave/core/static/app_texts.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyles.primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Image.asset(
                  AppAssets.logo,
                  width: 200,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Expanded(
              flex: 2,
              child: AuthenticationDataWidget(),
            )
          ],
        ),
      ),
    );
  }
}

class AuthenticationDataWidget extends StatefulWidget {
  const AuthenticationDataWidget({
    super.key,
  });

  @override
  State<AuthenticationDataWidget> createState() =>
      _AuthenticationDataWidgetState();
}

class _AuthenticationDataWidgetState extends State<AuthenticationDataWidget> {
  bool obscureText = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late FocusNode usernameFocusNode;
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    usernameFocusNode.addListener(() {
      setState(() {});
      if (usernameFocusNode.hasFocus) {
        log('Username field is focused');
      } else {
        log('Username field is not focused');
      }
      if (passwordFocusNode.hasFocus) {
        log('Password field is focused');
      }
    });
    passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAlias,
      decoration: AppStyles.auth.bodyDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            AppAssets.auth.login,
            width: 90,
            height: 40,
          ),
          Form(
            child: Column(
              children: [
                AuthenticationField(
                  labelText: AppTexts.auth.username,
                  focusNode: usernameFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppTexts.auth.usernameError;
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  clearText: () {
                    log('Clear email');
                  },
                  controller: emailController,
                ),
                const SizedBox(height: 20),
                AuthenticationField(
                  labelText: AppTexts.auth.password,
                  focusNode: passwordFocusNode,
                  obscureText: obscureText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppTexts.auth.passwordError;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    log('Password: $value');
                  },
                  clearText: () {
                    log('Clear password');
                  },
                  controller: passwordController,
                  visibleTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (usernameFocusNode.hasFocus) {
                      log('Username field is focused');
                    } else {
                      log('Username field is not focused');
                    }
                    if (passwordFocusNode.hasFocus) {
                      log('Password field is focused');
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AuthenticationField extends StatelessWidget {
  final String? hintText;
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? visibleTap;
  final void Function() clearText;
  final TextEditingController controller;
  final FocusNode focusNode;

  const AuthenticationField({
    super.key,
    required this.validator,
    required this.clearText,
    this.hintText,
    this.obscureText = false,
    this.onChanged,
    required this.controller,
    this.visibleTap,
    required this.labelText,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: labelText,
              ),
              const TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppStyles.auth.decorationFieldColor,
                width: 3,
              ),
            ),
            errorStyle: TextStyle(color: Colors.red.withOpacity(0.7)),
            suffixIcon: focusNode.hasFocus
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.red),
                    onPressed: clearText,
                  )
                : labelText == AppTexts.auth.password
                    ? IconButton(
                        icon: Image.asset(
                          obscureText
                              ? AppAssets.auth.invisiblePassword
                              : AppAssets.auth.visiblePassword,
                          width: 20,
                          height: 20,
                        ),
                        onPressed: visibleTap,
                      )
                    : const SizedBox(),
            errorBorder: AppStyles.auth.errorFieldBorder,
            focusedErrorBorder: AppStyles.auth.errorFieldBorder,
          ),
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
