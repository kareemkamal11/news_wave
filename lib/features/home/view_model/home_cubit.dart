import 'dart:convert';

import '../model/news_item_model.dart';
import 'home_state.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final String _baseUrl = 'https://api.mediastack.com/v1/news';
  final String _apiKey = '89f8b6602b9a8ca66bcc282d2be421ac';
  final String unsplashApiKey = '6CnSkVtcGhqLn3tRXEh3paafizN0J42R9pBmjt0lcy0';

  List<NewsItemModel> newsList = [];
  List<NewsItemModel> allNewsList = [];
  List<NewsItemModel> categoryNewsList = [];
  List<NewsItemModel> sourceNewsList = [];
  List<NewsItemModel> searchNewsList = [];
  List<CategoryItemModel> categories = [];
  List<String> sources = [];

  /// جلب كافة الأخبار
  Future<List<NewsItemModel>> fetchAllNews() async {
    final url = Uri.parse('$_baseUrl?access_key=$_apiKey');
    allNewsList = await _getNewsData(url);
    emit(NewsLoaded());
    return allNewsList;
  }

  /// جلب الأخبار بناءً على قسم معين
  Future<List<NewsItemModel>> fetchNewsByCategory(String category) async {
    final url = Uri.parse('$_baseUrl?access_key=$_apiKey&categories=$category');
    categoryNewsList = await _getNewsData(url);
    emit(NewsLoaded());
    return categoryNewsList;
  }

  /// جلب الأخبار بناءً على مصدر معين
  Future<List<NewsItemModel>> fetchNewsBySource(String source) async {
    final url = Uri.parse('$_baseUrl?access_key=$_apiKey&sources=$source');
    sourceNewsList = await _getNewsData(url);
    emit(NewsLoaded());
    return sourceNewsList;
  }

  /// البحث عن الأخبار بكلمات معينة
  Future<List<NewsItemModel>> searchNews(String keywords) async {
    final url = Uri.parse('$_baseUrl?access_key=$_apiKey&keywords=$keywords');
    searchNewsList = await _getNewsData(url);
    emit(NewsLoaded());
    return searchNewsList;
  }

  /// دالة مساعدة لتنفيذ الطلبات العامة وتجنب تكرار الكود
  Future<List<NewsItemModel>> _getNewsData(Uri url) async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newsList = data['data'];

        // استخراج الأقسام والمصادر
        // احفظ الناتج من extractCategories في متغير categories
        CategoryItemModel categoryItem = await extractCategories(newsList);
        categories.add(categoryItem);
        extractSources(newsList);

        return newsList;
      } else {
        print('Failed to load news. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('An error occurred: $e');
      return [];
    }
  }

  Future<String> fetchCategoryImage(String category) async {
    final url = Uri.parse(
        'https://api.unsplash.com/photos/random?query=$category&client_id=$unsplashApiKey');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['urls']['regular'];
      } else {
        print('Failed to load image. Status code: ${response.statusCode}');
        return '';
      }
    } catch (e) {
      print('An error occurred: $e');
      return '';
    }
  }

  Future<dynamic> extractCategories(List<dynamic> newsList) async {
    final Set<String> categorySet = {};
    for (var news in newsList) {
      if (news['category'] != null) {
        categorySet.add(news['category']);
      }
      categories = await Future.wait(categorySet.map((category) async {
        final imageUrl = await fetchCategoryImage(category);
        final news = await fetchNewsByCategory(category);
        return CategoryItemModel(name: category, image: imageUrl, news: news);
      }));
    }
  }

  void extractSources(List<dynamic> newsList) {
    final Set<String> sourceSet = {};
    for (var news in newsList) {
      if (news['url'] != null) {
        final uri = Uri.parse(news['url']);
        sourceSet.add(uri.host);
      }
    }
    sources = sourceSet.toList();
  }
}

class CategoryItemModel {
  final String name;
  final String image;
  final List<NewsItemModel> news;

  CategoryItemModel({
    required this.name,
    required this.image,
    required this.news,
  });
}
