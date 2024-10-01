// ignore_for_file: unused_local_variable, use_build_context_synchronously


import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/auth_token_body_widget.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/login_body_widget.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/sign_up_body_widget.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_styles.dart';

import 'profile_screen.dart';

class AuthenticationDataWidget extends StatefulWidget {
  const AuthenticationDataWidget({
    super.key,
  });

  @override
  State<AuthenticationDataWidget> createState() =>
      _AuthenticationDataWidgetState();
}

class _AuthenticationDataWidgetState extends State<AuthenticationDataWidget> {
  bool isSignup = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
 Future<void> facebookAuthentication() async {
  try {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.cancelled) {
      FlutterToastr.show(
        'Sign in canceled by user',
        context,
        duration: 3,
        backgroundColor: Colors.orange,
        textStyle: const TextStyle(fontSize: 15, color: Colors.white),
      );
      return;
    }

    if (result.status == LoginStatus.failed) {

      log('Sign in failed: ${result.message}');
      FlutterToastr.show(
        'Sign in failed: ${result.message}',
        context,
        duration: 3,
        backgroundColor: Colors.red,
        textStyle: const TextStyle(fontSize: 15, color: Colors.white),
      );
      return;
    }

    final AccessToken accessToken = result.accessToken!;
    log('Access token: ${accessToken.tokenString}');
    final AuthCredential credential = FacebookAuthProvider.credential(accessToken.tokenString);

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ),
    );
  } catch (e) {
    log(e.toString());
    FlutterToastr.show(
      e.toString(),
      context,
      duration: 3,
      backgroundColor: Colors.red,
      textStyle: const TextStyle(fontSize: 15, color: Colors.white),
    );
  }
}

    Future<void> googleAuthentication() async {
      try {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        if (googleUser == null) {
          FlutterToastr.show(
            'Sign in canceled by user',
            context,
            duration: 3,
            backgroundColor: Colors.orange,
            textStyle: const TextStyle(fontSize: 15, color: Colors.white),
          );
          return;
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
      } catch (e) {
        FlutterToastr.show(
          e.toString(),
          context,
          duration: 3,
          backgroundColor: Colors.red,
          textStyle: const TextStyle(fontSize: 15, color: Colors.white),
        );
      }
    }

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
            isSignup ? AppAssets.auth.signup : AppAssets.auth.login,
            width: 90,
            height: 40,
          ),
          Form(
            key: formKey,
            child: isSignup
                ? SignUpBodyWidget(
                    isSignup: isSignup,
                    formKey: formKey,
                  )
                : LoginBodyWidget(
                    isSignup: isSignup,
                    formKey: formKey,
                  ),
          ),
          const SizedBox(height: 15),
          AuthTokenBodyWidget(
            gPressed: googleAuthentication,
            fPressed: facebookAuthentication,
            isSignup: isSignup,
            onPressed: () {
              setState(() {
                isSignup = !isSignup;
              });
            },
          ),
        ],
      ),
    );
  }

  void errorToastr(BuildContext context, String errorMessages) {
    FlutterToastr.show(
      errorMessages,
      context,
      duration: 3,
      backgroundColor: Colors.red,
      textStyle: const TextStyle(fontSize: 15, color: Colors.white),
    );
  }
}
