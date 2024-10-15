import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_styles.dart';
import 'package:news_wave/core/static/app_texts.dart';
import 'package:news_wave/core/token/email_token.dart';
import 'package:news_wave/database_helper.dart';
import 'package:news_wave/features/home/widgets/app_search_widget.dart';
import 'package:news_wave/features/home/widgets/custom_app_bar.dart';
import 'package:news_wave/features/home/widgets/news_home_list_widget.dart';

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

  calculateCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth / 150).floor();
  }

  calculatorCrossMinCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth / 100).floor();
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
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    imagePath == null
                        ? CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            child: CustomAppBar(
                              imagePath: imagePath!,
                            ),
                          ),
                    const SizedBox(height: 15),
                    selected == 0
                        ? AppSearchWidget(
                            hintText: 'Search',
                            searchController: TextEditingController(),
                            onSaved: (value) {},
                            suffinxIcon: Icon(Icons.clear, color: Colors.red),
                            onSearchTapped: () {},
                          )
                        : Container(
                            width: double.infinity,
                            height: 2,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1,
                                    strokeAlign: BorderSide.strokeAlignCenter,
                                    color: AppStyles.primaryColor),
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              SliverFillRemaining(
                child: PageView(
                  controller: pageController,
                  onPageChanged: onPageChanged,
                  children: [
                    NewsHomeListWidget(news: news),
                    Text('Topics'),
                    Text('Author'),
                    Text('Bookmark'),
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: NavigationButtomWidget(
            selected: selected,
            pageController: pageController,
            onTap: onItemTapped,
          )),
    );
  }
}

class NavigationButtomWidget extends StatelessWidget {
  const NavigationButtomWidget({
    super.key,
    required this.selected,
    required this.pageController,
    required this.onTap,
  });

  final int selected;

  final PageController pageController;

  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppAssets.homeIcon),
          activeIcon: SvgPicture.asset(AppAssets.homeSelected),
          label: AppTexts.home,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppAssets.topicesIcon),
          activeIcon: SvgPicture.asset(AppAssets.topicsSelected),
          label: AppTexts.topics,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppAssets.authorIcon),
          activeIcon: SvgPicture.asset(AppAssets.authorSelected),
          label: AppTexts.author,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppAssets.bookmarkIcon),
          activeIcon: SvgPicture.asset(AppAssets.bookmarkSelected),
          label: AppTexts.bookmark,
        ),
      ],
      iconSize: 50,
      selectedIconTheme: IconThemeData(color: AppStyles.primaryColor),
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      currentIndex: selected,
      selectedItemColor: AppStyles.primaryColor,
      unselectedItemColor: AppStyles.textColor,
      onTap: onTap,
    );
  }
}
