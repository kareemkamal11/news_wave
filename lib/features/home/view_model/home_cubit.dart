import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
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
