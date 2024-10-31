import 'package:flutter/material.dart';
import 'package:news_wave/features/home/model/news_item_model.dart';
import 'package:news_wave/features/home/view/widgets/custom_app_bar.dart';

import '../../widgets/news_item_widget.dart';

class BookmarkPageWidget extends StatelessWidget {
  const BookmarkPageWidget(
      {super.key, required this.bookmarkList, required this.imagePath});

  final List<NewsItemModel> bookmarkList;
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
              imageUrl: bookmarkList[index].imageUrl,
              title: bookmarkList[index].title,
              source: bookmarkList[index].source,
              sourceIcon: bookmarkList[index].sourceIcon,
              time: bookmarkList[index].time,
              urlSource: bookmarkList[index].urlSource,
              category: bookmarkList[index].category,
              isBookmarked: bookmarkList[index].isBookmarked,
              onMarked: () {},

            );
          },
          itemCount: bookmarkList.length,
        ),
      ],
    );
  }
}
