// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_wave/core/static/app_texts.dart';
import 'package:news_wave/core/token/email_token.dart';
import 'package:news_wave/features/auth/view/screens/profile_screen.dart';
import 'package:news_wave/core/static/app_styles.dart';
import 'package:news_wave/database_helper.dart';
import 'package:news_wave/features/home/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super((AuthenticationInitial()));

  bool isRemember = false;

  bool isSignup = false;

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

  void toggleRememberMe(value) {
    isRemember = value;
    emit(AuthenticationRememberMe());
  }

  void toggleSignUp() {
    isSignup = !isSignup;
    emit(AuthenticationChangeFormType());
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

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  completeProfile(context, email) {
    EmailToken.saveEmail(email);
    DatabaseHelper.instance.emailFound(email).then((value) {
      if (!value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(email: email),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    });
  }

  Future<void> googleAuthentication(
    BuildContext context,
  ) async {
    emit(AuthenticationLoading());

    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        AppStyles.errorToastr(context, 'Sign in canceled by user');
        emit(AuthenticationWithTokenField());
        return;
      }

      log(googleUser.email);
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(googleCredential);
      final String email = userCredential.user!.email ?? '';

      completeProfile(context, email);

      if (userCredential.user != null) {}
      emit(AuthenticationWithToken());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        AppTexts.authErrorMessages =
            'Network error, please check your internet connection';
      } else if (e.code == 'too-many-requests') {
        AppTexts.authErrorMessages =
            'Too many requests, please try again later';
      } else {
        AppTexts.authErrorMessages =
            'An error occurred, please try again later';
      }
      AppStyles.errorToastr(context, AppTexts.authErrorMessages);
      emit(AuthenticationWithTokenField());
    }
  }

  Future<void> facebookAuthentication(
    BuildContext context,
  ) async {
    emit(AuthenticationLoading());
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.cancelled) {
        AppStyles.errorToastr(context, 'Facebook login canceled');
        emit(AuthenticationWithTokenField());
        return;
      }

      if (result.status == LoginStatus.failed) {
        AppStyles.errorToastr(context, 'Facebook login failed');
        emit(AuthenticationError());
        return;
      }

      final AccessToken accessToken = result.accessToken!;
      final OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.tokenString);

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final String email = userCredential.user!.email ?? '';

      if (userCredential.user != null) {
        completeProfile(context, email);

        emit(AuthenticationWithToken());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        AppTexts.authErrorMessages =
            'Network error, please check your internet connection';
      } else if (e.code == 'too-many-requests') {
        AppTexts.authErrorMessages =
            'Too many requests, please try again later';
      } else {
        AppTexts.authErrorMessages =
            'An error occurred, please try again later';
      }
      AppStyles.errorToastr(context, AppTexts.authErrorMessages);
      emit(AuthenticationWithTokenField());
    }
  }

  Future<void> loginUser(BuildContext context) async {
    emit(AuthenticationLoading());

    if (formKey.currentState?.validate() == false) {
      emit(AuthenticationError());

      return;
    } else {
      try {
        final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginEmailController.text,
          password: loginPasswordController.text,
        );

        final email = user.user!.email.toString();
        completeProfile(context, email);

        emit(AuthenticationWithEmail());
      } on FirebaseAuthException catch (e) {
        log(e.code);
        log(e.toString());
        log(e.message.toString());

        if (e.code == 'invalid-credential') {
          AppTexts.authErrorMessages =
              'Email or Password is incorrect!, please enter a valid email and password';
        } else if (e.code == 'network-request-failed') {
          AppTexts.authErrorMessages =
              'Network error, please check your internet connection';
        } else if (e.code == 'too-many-requests') {
          AppTexts.authErrorMessages =
              'Too many requests, please try again later';
        } else {
          AppTexts.authErrorMessages =
              'An error occurred, please try again later';
        }
        AppStyles.errorToastr(context, AppTexts.authErrorMessages!);
        emit(AuthenticationError());
      }
    }
  }

  Future<void> createNewUser(BuildContext context) async {
    emit(AuthenticationLoading());
    if (formKey.currentState?.validate() == false) {
      emit(AuthenticationSignUpError());
      return;
    } else {
      try {
        var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        final email = user.user!.email.toString();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(email: email),
          ),
        );
        emit(AuthenticationSignUp());
      } on FirebaseAuthException catch (e) {
        log(e.code);
        log(e.toString());
        log(e.message.toString());
        if (e.code == 'invalid-email') {
          AppTexts.authErrorMessages = 'The email address is not valid.';
        } else if (e.code == 'user-disabled') {
          AppTexts.authErrorMessages = 'The user account has been disabled.';
        } else if (e.code == 'user-not-found') {
          AppTexts.authErrorMessages = 'The user account does not exist.';
        } else if (e.code == 'wrong-password') {
          AppTexts.authErrorMessages = 'The password is invalid.';
        } else if (e.code == 'email-already-in-use') {
          AppTexts.authErrorMessages =
              'The email is already in use, please add different email';
        } else if (e.code == 'operation-not-allowed') {
          AppTexts.authErrorMessages = 'Operation is not allowed.';
        } else {
          AppTexts.authErrorMessages = 'An undefined Error happened.';
        }
        AppStyles.errorToastr(context, AppTexts.authErrorMessages!);
        emit(AuthenticationSignUpError());
      }
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    loginEmailFocusNode.dispose();
    loginPasswordFocusNode.dispose();
    // اريد حفظ قيمة ال isRemember في ال shared preferences
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isRemember', isRemember);
    });
    debugPrint('AuthenticationCubit disposed');
    return super.close();
  }
}
