import 'package:flutter/material.dart';
import 'package:news_wave/features/home/widgets/custom_app_bar.dart';
import 'package:news_wave/features/home/widgets/home_news_item_widget.dart';

class AuthorPageWidget extends StatelessWidget {
  const AuthorPageWidget(
      {super.key, required this.author, required this.imagePath});

  final List author;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CustomAppBar(
            imagePath: imagePath,
            selected: 2,
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return HomeNewsItemWidget(
              index: index,
              color: Colors.green,
            );
          },
          itemCount: author.length,
        ),
      ],
    );
  }
}
