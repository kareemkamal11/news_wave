import 'package:flutter/material.dart';
import 'package:news_wave/features/home/view/widgets/home_widgets/custom_app_bar.dart';

import '../../widgets/home_widgets/news_item_widget.dart';

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
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return NewsItemWidget(
              imageUrl: '',
              title: '',
              source: '',
              time: '',
              urlSource:
                  'https://www.tmz.com/2020/08/04/rafael-nadal-us-open-tennis-covid-19-concerns/',
              category: 'Bookmark',
            );
          },
          itemCount: bookmark.length,
        ),
      ],
    );
  }
}
