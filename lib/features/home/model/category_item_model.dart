import 'package:news_wave/features/home/model/news_item_model.dart';

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