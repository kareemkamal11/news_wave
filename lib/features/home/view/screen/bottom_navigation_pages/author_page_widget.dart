import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_wave/core/helper/context_helper.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/features/home/model/category_item_model.dart';
import 'package:news_wave/features/home/view/screen/category_news_screen.dart';
import 'package:news_wave/features/home/view/widgets/custom_app_bar.dart';
import 'package:news_wave/features/home/view_model/home_cubit.dart';
import 'package:news_wave/features/home/view_model/home_state.dart';

import '../../widgets/category_item_widget.dart';

class AuthorPageWidget extends StatelessWidget {
  const AuthorPageWidget({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        List<CategoryItemModel> authors =
            BlocProvider.of<HomeCubit>(context).sourceList;
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomAppBar(
                imagePath: imagePath,
              ),
            ),
            authors.isEmpty
                ? const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) {
                      return CategoryItemWidget(
                        title: authors[index].title,
                        image: DecorationImage(
                          image: authors[index].image!.isEmpty
                              ? AssetImage(AppAssets.failedImaeg)
                              : NetworkImage(
                                  authors[index].image!), // رابط الصورة
                        ),
                        onTap: () {
                          context.pustTo(CategoryNewsScreen(
                            categotyTitle: authors[index].title,
                            categoryNews: authors[index].news,
                          ));
                        },
                      );
                    },
                    itemCount: authors.length,
                  ),
          ],
        );
      },
    );
  }
}
