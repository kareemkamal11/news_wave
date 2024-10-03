// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/auth_token_body_widget.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/login_body_widget.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/sign_up_body_widget.dart';
import 'package:news_wave/auth/viewmodel/login/authentication_cubit.dart';
import 'package:news_wave/auth/viewmodel/login/authentication_state.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_styles.dart';
import 'package:news_wave/core/static/app_texts.dart';

import 'auth_custom_button.dart';
import 'profile_screen.dart';
import 'remember_me.dart';

class AuthenticationDataWidget extends StatefulWidget {
  const AuthenticationDataWidget({
    super.key,
  });

  @override
  State<AuthenticationDataWidget> createState() =>
      _AuthenticationDataWidgetState();
}

class _AuthenticationDataWidgetState extends State<AuthenticationDataWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final loginEmailFocusNode = FocusNode();
  final loginPasswordFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<AuthenticationCubit>(context);
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          clipBehavior: Clip.antiAlias,
          decoration: AppStyles.auth.bodyDecoration,
          child: ListView(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                child: const Icon(Icons.thermostat_sharp),
              ),
              Image.asset(
                cubit.isSignup ? AppAssets.auth.signup : AppAssets.auth.login,
                width: 90,
                height: 40,
              ),
              Form(
                key: formKey,
                child: cubit.isSignup
                    ? SignUpBodyWidget(
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                        emailFocusNode: emailFocusNode,
                        passwordFocusNode: passwordFocusNode,
                        confirmPasswordFocusNode: confirmPasswordFocusNode,
                      )
                    : LoginBodyWidget(
                        emailController: loginEmailController,
                        passwordController: loginPasswordController,
                        emailFocusNode: loginEmailFocusNode,
                        passwordFocusNode: loginPasswordFocusNode,
                      ),
              ),
              RememberMe(
                isRemember: cubit.isRemember,
                isSignup: cubit.isSignup,
                onChanged: (value) => cubit.toggleRememberMe(value),
              ),
              const SizedBox(height: 15),
              AuthCustomButton(
                onPressed: () {
                  !cubit.isSignup
                      ? cubit.loginUser(
                          context,
                          emailController,
                          passwordController,
                          formKey,
                        )
                      : cubit.createNewUser(
                          context,
                          loginEmailController,
                          loginPasswordController,
                          formKey,
                        );
                },
                label:
                    cubit.isSignup ? AppTexts.auth.signup : AppTexts.auth.login,
              ),
              const SizedBox(height: 15),
              AuthTokenBodyWidget(
                gPressed: () => cubit.googleAuthentication(context),
                fPressed: () => cubit.facebookAuthentication(context),
                isSignup: cubit.isSignup,
                onPressed: () {
                  setState(() {
                    cubit.isSignup = !cubit.isSignup;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
