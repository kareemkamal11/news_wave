import 'dart:convert';
import 'home_state.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final String _baseUrl = 'https://api.mediastack.com/v1/news';
  final String _apiKey = '89f8b6602b9a8ca66bcc282d2be421ac';

  /// جلب كافة الأخبار
  Future<List<dynamic>> fetchAllNews() async {
    final url = Uri.parse('$_baseUrl?access_key=$_apiKey');
    return await _getNewsData(url);
  }

  /// جلب الأخبار بناءً على قسم معين
  Future<List<dynamic>> fetchNewsByCategory(String category) async {
    final url = Uri.parse('$_baseUrl?access_key=$_apiKey&categories=$category');
    return await _getNewsData(url);
  }

  /// جلب الأخبار بناءً على مصدر معين
  Future<List<dynamic>> fetchNewsBySource(String source) async {
    final url = Uri.parse('$_baseUrl?access_key=$_apiKey&sources=$source');
    return await _getNewsData(url);
  }

  /// البحث عن الأخبار بكلمات معينة
  Future<List<dynamic>> searchNews(String keywords) async {
    final url = Uri.parse('$_baseUrl?access_key=$_apiKey&keywords=$keywords');
    return await _getNewsData(url);
  }

  /// دالة مساعدة لتنفيذ الطلبات العامة وتجنب تكرار الكود
  Future<List<dynamic>> _getNewsData(Uri url) async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'];
      } else {
        print('Failed to load news. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('An error occurred: $e');
      return [];
    }
  }
}

const apiKey = '89f8b6602b9a8ca66bcc282d2be421ac';

Future<void> fetchNews() async {
  final url =
      Uri.parse('https://api.mediastack.com/v1/news?access_key=$apiKey');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // تحويل البيانات إلى JSON
      final data = jsonDecode(response.body);
      print(data); // أو يمكنك تخزينها في متغير أو كائن
    } else {
      print('Failed to load news. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}
