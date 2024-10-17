import 'package:flutter/material.dart';
import 'package:news_wave/features/home/widgets/custom_app_bar.dart';
import 'package:news_wave/features/home/widgets/home_news_item_widget.dart';

class BookmarkPageWidget extends StatelessWidget {
  const BookmarkPageWidget(
      {super.key, required this.bookmark, required this.imagePath});

  final List bookmark;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CustomAppBar(
            imagePath: imagePath,
            selected: 3,
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return HomeNewsItemWidget(
              index: index,
              color: Colors.yellow,
            );
          },
          itemCount: bookmark.length,
        ),
      ],
    );
  }
}
