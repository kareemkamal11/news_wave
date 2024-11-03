import 'package:news_wave/features/home/model/news_item_model.dart';

class CategoryItemModel {
  final String title;
  final String? image;
  final List<NewsItemModel> news;

  CategoryItemModel({
    required this.title,
    required this.image,
    required this.news,
  });
}
