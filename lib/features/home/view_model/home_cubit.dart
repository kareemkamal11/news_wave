import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_wave/features/home/model/category_item_model.dart';
import 'package:news_wave/features/home/model/news_item_model.dart';
import 'home_state.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    fetchAllData(); // Call fetchAllData in the constructor
  }

  Map<String, dynamic>? data;
  final String baseUrl = 'https://newsdata.io/api/1/latest';
  final String apiKey = 'pub_58129dda715c6a153d787ca5ce9286851b630';
  final String unsplashApiKey = '6CnSkVtcGhqLn3tRXEh3paafizN0J42R9pBmjt0lcy0';
  List<CategoryItemModel> categoryList = [];
  List<CategoryItemModel> sourceList = [];
  List<NewsItemModel> newsList = [];
  List<NewsItemModel> categoryNews = [];
  List<NewsItemModel> sourceNews = [];
  List<NewsItemModel> bookmarkList = [];
  List<NewsItemModel> searchResults = [];

  void fetchAllData() async {
    emit(HomeInitial()); // بدأ التحميل 
    await getApiNews();
    await fetchCategories(data);
    await fetchSources(data);
    emit(NewsLoaded()); // تم تحميل الأخبار
  }

  void onMarked(NewsItemModel news) async {
    news.isBookmarked = !news.isBookmarked;
    if (news.isBookmarked) {
      if (!bookmarkList.any((item) => item.urlSource == news.urlSource)) {
        bookmarkList.add(news);
      }
    } else {
      bookmarkList.remove(news);
    }
    emit(NewsBookmarked()); // تحديث حالة العلامات المرجعية
  }

  Future<void> getApiNews() async {
    final response = await http.get(Uri.parse('$baseUrl?apikey=$apiKey'));
    log('Response status: $response');
    log('Response body: ${response.body}');
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      for (var news in data?['results'] ?? []) {
        String category =
            (news['category'] != null && news['category'].isNotEmpty)
                ? news['category'][0]
                : 'general';
        newsList.add(NewsItemModel(
          title: news['title'],
          imageUrl: news['image_url'] ?? '',
          source: news['source_id'],
          sourceIcon: fetchSourceIcon(news['link']),
          time: news['pubDate'],
          urlSource: news['link'],
          category: category,
          isBookmarked: false,
        ));
      }
    } else {
      emit(NewsError()); // في حال حدوث خطأ
      log('Error fetching news');
    }
  }

  Future<List<NewsItemModel>> fetchNewsByCategory(String category) async {
    categoryNews.clear();
    final response =
        await http.get(Uri.parse('$baseUrl?apikey=$apiKey&category=$category'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var news in data?['results'] ?? []) {
        String newsCategory =
            (news['category'] != null && news['category'].isNotEmpty)
                ? news['category'][0]
                : 'general';
        categoryNews.add(NewsItemModel(
          title: news['title'],
          imageUrl: news['image_url'] ?? '',
          source: news['source_id'],
          sourceIcon: fetchSourceIcon(news['link']),
          time: news['pubDate'],
          urlSource: news['link'],
          category: newsCategory,
          isBookmarked: false,
        ));
      }
      emit(NewsByCategoryLoaded()); // تم تحميل الأخبار حسب الفئة
      log(categoryNews.toString());
      return categoryNews;
    } else {
      emit(NewsError());
      log('Error fetching news by category ${response.statusCode}');
      return [];
    }
  }

  Future<List<NewsItemModel>> fetchNewsBySource(String source) async {
    sourceNews.clear();
    final response =
        await http.get(Uri.parse('$baseUrl?apikey=$apiKey&domain=$source'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var news in data?['results'] ?? []) {
        String newsCategory =
            (news['category'] != null && news['category'].isNotEmpty)
                ? news['category'][0]
                : 'general';
        sourceNews.add(NewsItemModel(
          title: news['title'],
          imageUrl: news['image_url'] ?? '',
          source: news['source_id'],
          sourceIcon: fetchSourceIcon(news['link']),
          time: news['pubDate'],
          urlSource: news['link'],
          category: newsCategory,
          isBookmarked: false,
        ));
      }
      emit(NewsBySourceLoaded()); // تم تحميل الأخبار حسب المصدر
      log(sourceNews.toString());
      return sourceNews;
    } else {
      emit(NewsError());
      log('Error fetching news by source');
      return [];
    }
  }

  Future<String> fetchCategoryImage(String category) async {
    String imagePath = '';
    final response = await http.get(Uri.parse(
        'https://api.unsplash.com/photos/random?query=$category&client_id=$unsplashApiKey'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      imagePath = data['urls']['regular'];
    }
    return imagePath;
  }

  Future<void> fetchCategories(data) async {
    List categories = data?['results'] ?? [];
    for (var news in categories) {
      if (news['category'] != null && news['category'].isNotEmpty) {
        String category = news['category'][0];
        String image = await fetchCategoryImage(category);
        var newsListByCategory = await fetchNewsByCategory(category);
        if (!categoryList.any((item) => item.title == category)) {
          categoryList.add(CategoryItemModel(
            title: category,
            image: image,
            news: newsListByCategory,
          ));
        }
      }
    }
  }

  String fetchSourceIcon(String url) {
    final uri = Uri.parse(url);
    final source = uri.host;
    final sourceIcon = 'https://logo.clearbit.com/$source';
    return sourceIcon;
  }

  Future<void> fetchSources(data) async {
    List sources = data?['results'] ?? [];
    for (var news in sources) {
      String image = fetchSourceIcon(news['link']);
      var newsListBySource = await fetchNewsBySource(news['source_id']);
      if (!sourceList.any((item) => item.title == news['source_id'])) {
        sourceList.add(CategoryItemModel(
          title: news['source_id'],
          image: image,
          news: newsListBySource,
        ));
      }
    }
  }

  Future<void> searchNews(String query) async {
    emit(HomeInitial()); // بدأ التحميل
    final response =
        await http.get(Uri.parse('$baseUrl?apikey=$apiKey&q=$query'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      searchResults.clear();
      for (var news in data?['results'] ?? []) {
        String category =
            (news['category'] != null && news['category'].isNotEmpty)
                ? news['category'][0]
                : 'general';
        searchResults.add(NewsItemModel(
          title: news['title'],
          imageUrl: news['image_url'] ?? '',
          source: news['source_id'],
          sourceIcon: fetchSourceIcon(news['link']),
          time: news['pubDate'],
          urlSource: news['link'],
          category: category,
          isBookmarked: false,
        ));
      }
      emit(NewsSearched()); // تم تحميل نتائج البحث
    } else {
      emit(NewsError());
      log('Error searching news');
    }
  }
}
