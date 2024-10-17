import 'package:flutter/material.dart';
import 'package:news_wave/features/home/widgets/custom_app_bar.dart';
import 'package:news_wave/features/home/widgets/home_news_item_widget.dart';

class NewsPageWidget extends StatelessWidget {
  const NewsPageWidget({
    super.key,
    required this.news,
    required this.imagePath,
  });

  final List news;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CustomAppBar(
            imagePath: imagePath,
            selected: 0,
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return HomeNewsItemWidget(
              index: index,
              color: Colors.red,
            );
          },
          itemCount: news.length,
        ),
      ],
    );
  }
}
