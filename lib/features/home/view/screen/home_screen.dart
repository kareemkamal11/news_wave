import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_wave/core/token/email_token.dart';
import 'package:news_wave/database_helper.dart';
import 'package:news_wave/features/home/model/news_item_model.dart';
import 'package:news_wave/features/home/view/screen/bottom_navigation_pages/author_page_widget.dart';
import 'package:news_wave/features/home/view/screen/bottom_navigation_pages/bookmark_page_widget.dart';
import 'package:news_wave/features/home/view/widgets/navigation_buttom_widget.dart';
import 'package:news_wave/features/home/view/screen/bottom_navigation_pages/news_page_widget.dart';
import 'package:news_wave/features/home/view/screen/bottom_navigation_pages/topics_page_widget.dart';
import 'package:news_wave/features/home/view_model/home_cubit.dart';
import 'package:news_wave/features/home/view_model/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? data;
  String? imagePath;

  Future<void> fetchImagePath() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      String? user = await EmailToken.getEmail();
      var data = await DatabaseHelper.instance.getUser(user!);
      setState(() {
        imagePath = data['imagePath'];
      });
    } catch (e) {
      print('Error fetching image path: $e');
    }
  }

  List news = List.generate(100, (index) => index);

  @override
  void initState() {
    super.initState();
    fetchImagePath();
  }

  int selected = 0;

  final PageController pageController = PageController();

  void onItemTapped(int index) {
    setState(() {
      selected = index;
    });
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      selected = index;
    });
  }

  List<NewsItemModel> newsBookmark = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var newsCubit = BlocProvider.of<HomeCubit>(context);
        return SafeArea(
          child: Scaffold(
              body: PageView(
                  controller: pageController,
                  onPageChanged: onPageChanged,
                  children: [
                    NewsPageWidget(
                      news: newsCubit.allNewsList,
                      onMarked: newsCubit.onMarked,
                      imagePath: imagePath ?? '',
                    ),
                    TopicsPageWidget(
                      topics: newsCubit.categories,
                      imagePath: imagePath ?? '',
                    ),
                    AuthorPageWidget(
                      authors: newsCubit.sources,
                      imagePath: imagePath ?? '',
                    ),
                    BookmarkPageWidget(
                      bookmarkList: newsBookmark,
                      imagePath: imagePath ?? '',
                    ),
                  ]),
              bottomNavigationBar: NavigationButtomWidget(
                selected: selected,
                pageController: pageController,
                onTap: onItemTapped,
              )),
        );
      },
    );
  }
}
