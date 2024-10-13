// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_wave/core/static/app_styles.dart';
import 'package:news_wave/core/static/app_texts.dart';
import 'package:news_wave/features/auth/view/widgets/auth_widget/auth_token_body_widget.dart';
import 'package:news_wave/features/auth/view/widgets/auth_widget/login_body_widget.dart';
import 'package:news_wave/features/auth/view/widgets/auth_widget/sign_up_body_widget.dart';
import 'package:news_wave/features/auth/viewmodel/login/authentication_cubit.dart';
import 'package:news_wave/features/auth/viewmodel/login/authentication_state.dart';

import 'auth_custom_button.dart';
import 'remember_me.dart';

class AuthenticationDataWidget extends StatelessWidget {
  const AuthenticationDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<AuthenticationCubit>(context);
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          clipBehavior: Clip.antiAlias,
          decoration: AppStyles.bodyDecoration,
          child: ListView(
            children: [
              Image.asset(
                cubit.isSignup ? AppTexts.signup : AppTexts.login,
                width: 90,
                height: 40,
              ),
              Form(
                key: cubit.formKey,
                child: cubit.isSignup
                    ? SignUpBodyWidget(
                        emailController: cubit.emailController,
                        passwordController: cubit.passwordController,
                        confirmPasswordController:
                            cubit.confirmPasswordController,
                        emailFocusNode: cubit.emailFocusNode,
                        passwordFocusNode: cubit.passwordFocusNode,
                        confirmPasswordFocusNode:
                            cubit.confirmPasswordFocusNode,
                        emailValidator: cubit.emailValidator,
                        passwordValidator: cubit.passwordValidator,
                        confirmPasswordValidator:
                            cubit.confirmPasswordValidator,
                      )
                    : LoginBodyWidget(
                        emailController: cubit.loginEmailController,
                        passwordController: cubit.loginPasswordController,
                        emailFocusNode: cubit.loginEmailFocusNode,
                        passwordFocusNode: cubit.loginPasswordFocusNode,
                        emailValidator: cubit.emailValidator,
                        passwordValidator: cubit.passwordValidator,
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
                      ? cubit.loginUser(context)
                      : cubit.createNewUser(context);
                },
                label: cubit.isSignup ? AppTexts.signup : AppTexts.login,
              ),
              const SizedBox(height: 15),
              AuthTokenBodyWidget(
                gPressed: () => cubit.googleAuthentication(context),
                fPressed: () => cubit.facebookAuthentication(context),
                isSignup: cubit.isSignup,
                onPressed: () => cubit.toggleSignUp(),
              ),
            ],
          ),
        );
      },
    );
  }
}
