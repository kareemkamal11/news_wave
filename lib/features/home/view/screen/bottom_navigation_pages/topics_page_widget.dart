import 'package:flutter/material.dart';
import 'package:news_wave/core/helper/context_helper.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/features/home/model/category_item_model.dart';
import 'package:news_wave/features/home/view/screen/category_news_screen.dart';
import 'package:news_wave/features/home/view/widgets/custom_app_bar.dart';
import 'package:news_wave/features/home/view/widgets/category_item_widget.dart';

class TopicsPageWidget extends StatelessWidget {
  const TopicsPageWidget(
      {super.key, required this.imagePath, required this.topics});
  final String imagePath;
  final List<CategoryItemModel> topics;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CustomAppBar(
            imagePath: imagePath,
          ),
        ),
        topics.isEmpty
            ? const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: CategoryItemWidget(
                      onTap: () {
                        context.pustTo(
                          CategoryNewsScreen(
                            categotyTitle: topics[index].title,
                            categoryNews: topics[index].news,
                          ),
                        );
                      },
                      title: topics[index].title,
                      image: DecorationImage(
                        image: topics[index].image!.isEmpty
                        ? AssetImage(AppAssets.failedImaeg)
                        : NetworkImage(topics[index].image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                itemCount: topics.length,
              )
      ],
    );
  }
}
