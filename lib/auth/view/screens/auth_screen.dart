import 'package:flutter/material.dart';
import 'package:news_wave/auth/view/widgets/authentication_data_widget.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_styles.dart';

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
              flex: 3,
              child: AuthenticationDataWidget(),
            )
          ],
        ),
      ),
    );
  }
}
