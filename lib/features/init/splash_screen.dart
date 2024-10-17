// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:news_wave/features/auth/view/screens/auth_screen.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_styles.dart';
import 'package:news_wave/database_helper.dart';
import 'package:news_wave/features/home/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await DatabaseHelper.instance.database;
    Future.delayed(
      const Duration(seconds: 2),
      () {
        SharedPreferences.getInstance().then((prefs) {
          final bool authed = prefs.getBool('isRemember') ?? false;
          if (authed) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const AuthScreen(),
              ),
            );
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image.asset(
          AppAssets.logo,
          width: 200,
          height: 110,
        ),
      ),
    );
  }
}
