import 'package:flutter/material.dart';
import 'package:news_wave/core/helper/context_helper.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/features/home/view/screen/category_news_screen.dart';
import 'package:news_wave/features/home/view/widgets/home_widgets/custom_app_bar.dart';

import '../../widgets/home_widgets/category_item_widget.dart';

class AuthorPageWidget extends StatelessWidget {
  const AuthorPageWidget(
      {super.key, required this.author, required this.imagePath});

  final List author;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    String imageSource = 'https://logo.clearbit.com/bbcnews.com';
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CustomAppBar(
            imagePath: imagePath,
          ),
        ),
        SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            return CategoryItemWidget(
              title: 'BBC News',
              image: DecorationImage(
                image: imageSource.isEmpty
                    ? AssetImage(AppAssets.failedImaeg)
                    : NetworkImage(imageSource), // رابط الصورة
              ),
              onTap: () {
                context.pustTo(CategoryNewsScreen(
                  categotyTitle: 'BBC News',
                ));
              },
            );
          },
          itemCount: author.length,
        ),
      ],
    );
  }
}
