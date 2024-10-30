import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_wave/features/auth/view/widgets/auth_widget/authentication_data_widget.dart';
import 'package:news_wave/features/auth/viewmodel/authentication_cubit.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_styles.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
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
      ),
    );
  }
}
