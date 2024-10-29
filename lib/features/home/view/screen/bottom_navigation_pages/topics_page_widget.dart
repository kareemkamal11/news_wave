import 'package:flutter/material.dart';
import 'package:news_wave/core/helper/context_helper.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/features/home/view/screen/category_news_screen.dart';
import 'package:news_wave/features/home/view/widgets/home_widgets/custom_app_bar.dart';
import 'package:news_wave/features/home/view/widgets/home_widgets/category_item_widget.dart';

class TopicsPageWidget extends StatelessWidget {
  const TopicsPageWidget({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    List topics = [
      {
        'title': 'Business',
        'image': AppAssets.business,
      },
      {
        'title': 'Science',
        'image': AppAssets.science,
      },
      {
        'title': 'Sports',
        'image': AppAssets.sports,
      },
      {
        'title': 'Technology',
        'image': AppAssets.technology,
      }
    ];
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
            return Padding(
              padding: const EdgeInsets.all(15),
              child: CategoryItemWidget(
                onTap: () {
                  context.pustTo(
                    CategoryNewsScreen(categotyTitle: topics[index]['title']),
                  );
                },
                title: topics[index]['title'],
                image: DecorationImage(
                  image: AssetImage(topics[index]['image']),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          itemCount: topics.length,
        )
      ],
    );
  }
}
