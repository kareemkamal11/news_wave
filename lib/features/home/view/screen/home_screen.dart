import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_wave/core/token/email_token.dart';
import 'package:news_wave/database_helper.dart';
import 'package:news_wave/features/home/model/category_item_model.dart';
import 'package:news_wave/features/home/model/news_item_model.dart';
import 'package:news_wave/features/home/view/screen/bottom_navigation_pages/author_page_widget.dart';
import 'package:news_wave/features/home/view/screen/bottom_navigation_pages/bookmark_page_widget.dart';
import 'package:news_wave/features/home/view/widgets/navigation_buttom_widget.dart';
import 'package:news_wave/features/home/view/screen/bottom_navigation_pages/news_page_widget.dart';
import 'package:news_wave/features/home/view/screen/bottom_navigation_pages/topics_page_widget.dart';
import 'package:news_wave/features/home/view_model/home_cubit.dart';
import 'package:news_wave/features/home/view_model/home_state.dart';

import 'package:http/http.dart' as http;

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
    fetchAllData();
  }

  final String baseUrl = 'https://api.mediastack.com/v1/news';
  final String apiKey = '315692332a31a918309cffc3b02157a3';
  final String unsplashApiKey = '6CnSkVtcGhqLn3tRXEh3paafizN0J42R9pBmjt0lcy0';
  List<CategoryItemModel> categoryList = [];
  List<CategoryItemModel> sourceList = [];
  List<NewsItemModel> newsList = [];
  List<NewsItemModel> bookmarkList = [];
  List<NewsItemModel> categoryNews = [];
  List<NewsItemModel> sourceNews = [];

  void fetchAllData() async {
    await getApiNews();
    await fetchCateogries(data);
    await fetchSources(data);
  }

  getApiNews() async {
    await http.get(Uri.parse('$baseUrl?access_key=$apiKey')).then((response) {
      setState(() {
        data = json.decode(response.body);
      });
      log('Data: $data');
    });
    for (var news in data?['data']) {
      newsList.add(NewsItemModel(
        title: news['title'],
        imageUrl: news['image'] ?? '',
        source: news['source'],
        sourceIcon: fetchSourceIcon(news['url']) ?? '',
        time: news['published_at'],
        urlSource: news['url'],
        category: news['category'],
        isBookmarked: false,
      ));
    }
  }

  fetchNewsbyCategory(String category) async {
    await http
        .get(Uri.parse('$baseUrl?access_key=$apiKey&categories=$category'))
        .then((response) {
      setState(() {
        data = json.decode(response.body);
      });
      log('Data: $data');
    });
    for (var news in data?['data']) {
      categoryNews.add(NewsItemModel(
        title: news['title'],
        imageUrl: news['image'] ?? '',
        source: news['source'],
        sourceIcon: fetchSourceIcon(news['url']) ?? '',
        time: news['published_at'],
        urlSource: news['url'],
        category: news['category'],
        isBookmarked: false,
      ));
    }
    return categoryNews;
  }

  fetchCategoryImage(String category) async {
    String imagePath = '';
    await http
        .get(Uri.parse(
            'https://api.unsplash.com/photos/random?query=$category&client_id=$unsplashApiKey'))
        .then((response) {
      data = json.decode(response.body);
      imagePath = data?['urls']['regular'];
      log('Data: $data');
    });
    return imagePath;
  }

  fetchCateogries(data) async {
    List categories = data['data'];
    for (var category in categories) {
      String image = await fetchCategoryImage(category['category']) ?? '';
      var newsList = await fetchNewsbyCategory(category['category']);
      if (!categoryList.any((item) => item.title == category['category'])) {
        categoryList.add(CategoryItemModel(
          title: category['category'],
          image: image,
          news: newsList,
        ));
      }
    }
  }

  fetchNewsbySource(String source) async {
    await http
        .get(Uri.parse('$baseUrl?access_key=$apiKey&sources=$source'))
        .then((response) {
      setState(() {
        data = json.decode(response.body);
      });
      log('Data: $data');
    });
    for (var news in data?['data']) {
      sourceNews.add(NewsItemModel(
        title: news['title'],
        imageUrl: news['image'] ?? '',
        source: news['source'],
        sourceIcon: fetchSourceIcon(news['url']) ?? '',
        time: news['published_at'],
        urlSource: news['url'],
        category: news['category'],
        isBookmarked: false,
      ));
    }
    return sourceNews;
  }

  fetchSourceIcon(url) {
    final uri = Uri.parse(url);
    final source = uri.host;
    final sourceIcon = 'https://logo.clearbit.com/$source';
    return sourceIcon;
  }

  fetchSources(data) async {
    List sources = data['data'];
    for (var source in sources) {
      String image = await fetchSourceIcon(source['url']) ?? '';
      var newsList = await fetchNewsbySource(source['source']);
      if (!sourceList.any((item) => item.title == source['source'])) {
        sourceList.add(CategoryItemModel(
          title: source['source'],
          image: image,
          news: newsList,
        ));
      }
    }
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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        // var newsCubit = BlocProvider.of<HomeCubit>(context);
        return SafeArea(
          child: Scaffold(
              body: PageView(
                  controller: pageController,
                  onPageChanged: onPageChanged,
                  children: [
                    NewsPageWidget(
                      news: newsList,
                      imagePath: imagePath ?? '',
                    ),
                    TopicsPageWidget(
                      topics: categoryList,
                      imagePath: imagePath ?? '',
                    ),
                    AuthorPageWidget(
                      authors: sourceList,
                      imagePath: imagePath ?? '',
                    ),
                    BookmarkPageWidget(
                      bookmarkList: [],
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
