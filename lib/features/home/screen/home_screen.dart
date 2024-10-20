import 'package:flutter/material.dart';
import 'package:news_wave/core/token/email_token.dart';
import 'package:news_wave/database_helper.dart';
import 'package:news_wave/features/home/widgets/author_page_widget.dart';
import 'package:news_wave/features/home/widgets/bookmark_page_widget.dart';
import 'package:news_wave/features/home/widgets/navigation_buttom_widget.dart';
import 'package:news_wave/features/home/widgets/news_page_widget.dart';
import 'package:news_wave/features/home/widgets/topics_page_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: [
                NewsPageWidget(news: news, imagePath: imagePath ?? ''),
                TopicsPageWidget(imagePath: imagePath ?? ''),
                AuthorPageWidget(author: news, imagePath: imagePath ?? ''),
                BookmarkPageWidget(bookmark: news, imagePath: imagePath ?? ''),
              ]),
          bottomNavigationBar: NavigationButtomWidget(
            selected: selected,
            pageController: pageController,
            onTap: onItemTapped,
          )),
    );
  }
}
