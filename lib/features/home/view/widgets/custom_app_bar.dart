import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_wave/core/helper/context_helper.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_styles.dart';

import '../screen/bottom_navigation_pages/search_page_widget.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AppBarPhotoWidget(imagePath: imagePath),
            const SizedBox(width: 40),
            Image.asset(
              AppAssets.logo,
              width: 180,
              height: 80,
              color: Color(0xFF0F8ACF),
              fit: BoxFit.fitHeight,
            ),
            const SizedBox(width: 15),
            TextButton(
              onPressed: () {
                context.pustTo(SearchPageWidget());
              },
              child: Image.asset(AppAssets.searchIcon),
            )
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 2,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 15),
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
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primaryColor,
                width: 1,
              ),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: imagePath.isEmpty
                    ? CircularProgressIndicator()
                    : Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                      )),
          ),
        ));
  }
}
