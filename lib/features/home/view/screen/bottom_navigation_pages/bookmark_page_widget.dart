import 'package:flutter/material.dart';
import 'package:news_wave/features/home/model/news_item_model.dart';
import 'package:news_wave/features/home/view/widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_wave/features/home/view_model/home_cubit.dart';
import 'package:news_wave/features/home/view_model/home_state.dart';

import '../../widgets/news_item_widget.dart';

class BookmarkPageWidget extends StatelessWidget {
  const BookmarkPageWidget(
      {super.key, required this.bookmarkList, required this.imagePath});

  final List<NewsItemModel> bookmarkList;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var homeCubit = BlocProvider.of<HomeCubit>(context);

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomAppBar(
                imagePath: imagePath,
              ),
            ),
            bookmarkList.isEmpty
                ? const SliverFillRemaining(
                    child: Center(
                      child: Text('No Bookmarks'),
                    ),
                  )
                : SliverList.builder(
                    itemBuilder: (context, index) {
                      final news = bookmarkList[index];
                      return NewsItemWidget(
                        imageUrl: news.imageUrl,
                        title: news.title,
                        source: news.source,
                        sourceIcon: news.sourceIcon,
                        time: news.time,
                        urlSource: news.urlSource,
                        category: news.category,
                        isBookmarked: news.isBookmarked,
                        onMarked: () {
                          homeCubit.onMarked(news);
                        },
                      );
                    },
                    itemCount: bookmarkList.length,
                  ),
          ],
        );
      },
    );
  }
}
