import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_wave/core/helper/context_helper.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_styles.dart';
import 'package:news_wave/features/home/view/widgets/news_item_widget.dart';
import 'package:news_wave/features/home/view_model/home_cubit.dart';
import 'package:news_wave/features/home/view_model/home_state.dart';

class SearchPageWidget extends StatefulWidget {
  const SearchPageWidget({
    super.key,
  });

  @override
  State<SearchPageWidget> createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  final TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    searchController.addListener(
      () {
        setState(() {
          isSearching = searchController.text.isNotEmpty;
        });
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<HomeCubit>(context);
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
                            TextButton(
                              onPressed: () => context.back(),
                              child: Icon(Icons.arrow_back),
                            ),
                            const SizedBox(width: 80),
                            Image.asset(AppAssets.logo,
                                color: Color(0xFF0F8ACF),
                                width: 180 / 1.3,
                                height: 80 / 1.4)
                          ],
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              SearchFieldWidget(
                                suffinxIcon: isSearching
                                    ? IconButton(
                                        onPressed: () {
                                          searchController.clear();
                                          cubit.searchResults.clear();
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.close,
                                            color: Colors.red),
                                      )
                                    : SizedBox(),
                                hintText: 'Search...',
                                onSaved: (value) {},
                                onSearchTapped: () {
                                  cubit.searchNews(searchController.text);
                                },
                                searchController: searchController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList.builder(
                    itemCount: cubit.searchResults.length,
                    itemBuilder: (context, index) {
                      return NewsItemWidget(
                        imageUrl: cubit.searchResults[index].imageUrl,
                        title: cubit.searchResults[index].title,
                        sourceIcon: cubit.searchResults[index].sourceIcon,
                        source: cubit.searchResults[index].source,
                        time: cubit.searchResults[index].time,
                        urlSource: cubit.searchResults[index].urlSource,
                        category: cubit.searchResults[index].category,
                        isBookmarked: cubit.searchResults[index].isBookmarked,
                        onMarked: () =>
                            cubit.onMarked(cubit.searchResults[index]),
                      );
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SearchFieldWidget extends StatefulWidget {
  const SearchFieldWidget({
    super.key,
    required this.suffinxIcon,
    required this.hintText,
    required this.onSaved,
    required this.onSearchTapped,
    required this.searchController,
  });

  final Function(dynamic) onSaved;
  final Function() onSearchTapped;
  final Widget? suffinxIcon;
  final String hintText;
  final TextEditingController searchController;

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.searchController,
      onSubmitted: (value) => widget.onSearchTapped(),
      onChanged: (value) => widget.onSaved(value),
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      maxLines: 1,
      decoration: InputDecoration(
        enabledBorder: AppStyles.searchFieldBorder,
        focusedBorder: AppStyles.searchFieldBorder,
        hintText: widget.hintText,
        hintStyle: AppStyles.titleTextStyle
            .copyWith(color: AppColors.primaryColor, fontSize: 20),
        suffixIcon: widget.suffinxIcon,
        prefixIcon: Image.asset(AppAssets.searchIcon, width: 30, height: 30),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 3,
          ),
        ),
      ),
    );
  }
}
