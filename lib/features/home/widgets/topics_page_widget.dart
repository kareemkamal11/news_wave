import 'package:flutter/material.dart';
import 'package:news_wave/features/home/widgets/custom_app_bar.dart';
import 'package:news_wave/features/home/widgets/home_news_item_widget.dart';

class TopicsPageWidget extends StatelessWidget {
  const TopicsPageWidget(
      {super.key, required this.topics, required this.imagePath});

  final List topics;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CustomAppBar(
            imagePath: imagePath,
            selected: 1,
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return HomeNewsItemWidget(
              index: index,
              color: Colors.blue,
            );
          },
          itemCount: topics.length,
        ),
      ],
    );
  }
}
