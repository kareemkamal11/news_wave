// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:news_wave/auth/view/screens/auth_screen.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // add the navigation to the next screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.primaryColor,
      body: Center(
        child: Image.asset(AppAssets.logo,
            width: 200, height: 150, ),
      ),
    );
  }
}
