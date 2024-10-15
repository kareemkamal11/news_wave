import 'dart:io';
import 'package:flutter/material.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppBarPhotoWidget(imagePath: imagePath),
        const SizedBox(width: 60),
        Image.asset(
          AppAssets.logo,
          width: 180,
          height: 80,
          color: Color(0xFF0F8ACF),
          fit: BoxFit.fitHeight,
        ),
      ],
    );
  }
}

class AppBarPhotoWidget extends StatelessWidget {
  const AppBarPhotoWidget({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppStyles.primaryColor,
            width: 1,
          ),
          image: DecorationImage(
            image: FileImage(File(imagePath)),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
