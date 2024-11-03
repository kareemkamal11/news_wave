import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_wave/features/home/model/news_item_model.dart';
import 'package:news_wave/features/home/view/widgets/custom_app_bar.dart';
import 'package:news_wave/features/home/view/widgets/news_item_widget.dart';
import 'package:news_wave/features/home/view_model/home_cubit.dart';
import 'package:news_wave/features/home/view_model/home_state.dart';

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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<HomeCubit>(context);
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomAppBar(
                imagePath: imagePath,
              ),
            ),
            news.isEmpty
                ? const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SliverList.builder(
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
                        onMarked: () => cubit.onMarked(),
                      );
                    },
                    itemCount: news.length,
                  ),
          ],
        );
      },
    );
  }
}
