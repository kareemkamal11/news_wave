// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/profile_screen.dart';
import 'package:news_wave/core/static/app_styles.dart';
import 'package:news_wave/core/static/app_texts.dart';

import 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super((AuthenticationInitial()));

  bool isRemember = false;

  bool isSignup = false;

  void toggleRememberMe(value) {
    isRemember = value;
    emit(AuthenticationRememberMe());
  }

  void toggleSignUp() {
    isSignup = !isSignup;
    emit(AuthenticationChangeFormType());
  }

  Future<void> facebookAuthentication(
    BuildContext context,
  ) async {
    emit(AuthenticationLoading());
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.cancelled) {
        AppStyles.auth.errorToastr(context, 'Facebook login canceled');
        emit(AuthenticationWithTokenField());
        return;
      }

      if (result.status == LoginStatus.failed) {
        AppStyles.auth.errorToastr(context, 'Facebook login failed');
        emit(AuthenticationField());
        return;
      }

      final AccessToken accessToken = result.accessToken!;
      FacebookAuthProvider.credential(accessToken.tokenString);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );
      emit(AuthenticationWithToken());
    } catch (e) {
      AppStyles.auth.errorToastr(context, e.toString());
      emit(AuthenticationWithTokenField());
    }
  }

  Future<void> googleAuthentication(
    BuildContext context,
  ) async {
    emit(AuthenticationLoading());

    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn().signIn(); // تعني
      if (googleUser == null) {
        AppStyles.auth.errorToastr(context, 'Sign in canceled by user');
        emit(AuthenticationWithTokenField());
        return;
      }

      log(googleUser.email);
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );
      emit(AuthenticationWithToken());
    } catch (e) {
      log(e.toString());
      AppStyles.auth.errorToastr(context, e.toString());
      emit(AuthenticationWithTokenField());
    }
  }

  Future<void> loginUser(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    GlobalKey<FormState> formKey,
  ) async {
    emit(AuthenticationLoading());

    if (formKey.currentState?.validate() == false) {
      emit(AuthenticationField());

      return;
    } else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
        emit(AuthenticationWithEmail());
      } on FirebaseAuthException catch (e) {
        log(e.code);
        if (e.code == 'Invalid-Credentials') {
          AppTexts.auth.errorMessages =
              'Email or Password is incorrect!, please enter a valid email and password';
        } else if (e.code == 'Network-Request-Failed') {
          AppTexts.auth.errorMessages =
              'Network error, please check your internet connection';
        } else if (e.code == 'Too-Many-Requests') {
          AppTexts.auth.errorMessages =
              'Too many requests, please try again later';
        } else {
          AppTexts.auth.errorMessages =
              'An error occurred, please try again later';
        }
        AppStyles.auth.errorToastr(context, AppTexts.auth.errorMessages!);
        emit(AuthenticationField());
      }
    }
  }

  Future<void> createNewUser(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    GlobalKey<FormState> formKey,
  ) async {
    emit(AuthenticationLoading());
    if (formKey.currentState?.validate() == false) {
      emit(AuthenticationSignUpError());
      return;
    } else {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
        emit(AuthenticationSignUp());
      } on FirebaseAuthException  catch (e) {
        log(e.code);
        if (e.code == 'invalid-email') {
          AppTexts.auth.errorMessages = 'The email address is not valid.';
        } else if (e.code == 'user-disabled') {
          AppTexts.auth.errorMessages = 'The user account has been disabled.';
        } else if (e.code == 'user-not-found') {
          AppTexts.auth.errorMessages = 'The user account does not exist.';
        } else if (e.code == 'wrong-password') {
          AppTexts.auth.errorMessages = 'The password is invalid.';
        } else if (e.code == 'email-already-in-use') {
          AppTexts.auth.errorMessages = 'The email is already in use, please add different email';
        } else if (e.code == 'operation-not-allowed') {
          AppTexts.auth.errorMessages = 'Operation is not allowed.';
        } else {
          AppTexts.auth.errorMessages = 'An undefined Error happened.';
        }
        AppStyles.auth.errorToastr(context, AppTexts.auth.errorMessages!);
        emit(AuthenticationSignUpError());
      }
    }
  }
}
