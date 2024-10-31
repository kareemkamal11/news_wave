import 'package:flutter/material.dart';
import 'package:news_wave/core/static/app_styles.dart';
import 'package:news_wave/features/home/model/news_item_model.dart';
import 'package:news_wave/features/home/view/widgets/news_item_widget.dart';

class CategoryNewsScreen extends StatelessWidget {
  const CategoryNewsScreen({
    super.key,
    required this.categotyTitle,
    required this.categoryNews,
  });

  final String categotyTitle;
  final List<NewsItemModel> categoryNews;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 120),
                        Text(
                          categotyTitle,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 2,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList.builder(
              itemBuilder: (context, index) {
                return NewsItemWidget(
                  imageUrl: categoryNews[index].imageUrl,
                  title: categoryNews[index].title,
                  source: categoryNews[index].source,
                  sourceIcon: categoryNews[index].sourceIcon,
                  time: categoryNews[index].time,
                  urlSource: categoryNews[index].urlSource,
                  category: categoryNews[index].category,
                  isBookmarked: categoryNews[index].isBookmarked,
                  onMarked: () {},
                );
              },
              itemCount: 10,
            ),
          ],
        ),
      ),
    );
  }
}
