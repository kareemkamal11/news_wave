import 'package:flutter/material.dart';
import 'package:news_wave/features/home/model/news_item_model.dart';
import 'package:news_wave/features/home/view/widgets/custom_app_bar.dart';
import 'package:news_wave/features/home/view/widgets/news_item_widget.dart';

class NewsPageWidget extends StatelessWidget {
  const NewsPageWidget({
    super.key,
    required this.news,
    required this.imagePath,
  });

  final List<NewsItemModel> news;
  final String imagePath;

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
              title: 'Title',
              source: 'BBC News',
              sourceIcon: 'https://logo.clearbit.com/bbcnews.com',
              time: '7h ago',
              urlSource:
                  'https://www.tmz.com/2020/08/04/rafael-nadal-us-open-tennis-covid-19-concerns/',
              category: 'Technology',
            );
          },
          itemCount: news.length,
        ),
      ],
    );
  }
}
