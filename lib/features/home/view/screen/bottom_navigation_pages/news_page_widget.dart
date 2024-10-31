import 'package:flutter/material.dart';
import 'package:news_wave/features/home/model/news_item_model.dart';
import 'package:news_wave/features/home/view/widgets/custom_app_bar.dart';
import 'package:news_wave/features/home/view/widgets/news_item_widget.dart';

class NewsPageWidget extends StatelessWidget {
  const NewsPageWidget({
    super.key,
    required this.news,
    required this.imagePath,
    required this.onMarked,
  });

  final List<NewsItemModel> news;
  final String imagePath;
  final Function() onMarked;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CustomAppBar(
            imagePath: imagePath,
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return NewsItemWidget(
              imageUrl: news[index].imageUrl,
              title: news[index].title,
              source: news[index].source,
              sourceIcon: news[index].sourceIcon,
              time: news[index].time,
              urlSource: news[index].urlSource,
              category: news[index].category,
              isBookmarked: news[index].isBookmarked,
              onMarked: onMarked,
            );
          },
          itemCount: news.length,
        ),
      ],
    );
  }
}
