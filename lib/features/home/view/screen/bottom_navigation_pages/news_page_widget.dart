import 'package:flutter/material.dart';
import 'package:news_wave/features/home/view/widgets/home_widgets/custom_app_bar.dart';
import 'package:news_wave/features/home/view/widgets/home_widgets/news_item_widget.dart';

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
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return NewsItemWidget(
              imageUrl:
                  'https://s.yimg.com/ny/api/res/1.2/MmlwYgzLr9jjkILWAzjFXw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://s.yimg.com/os/creatr-uploaded-images/2024-10/946eeba0-8ea5-11ef-b5bf-0104b4e9532a',
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
