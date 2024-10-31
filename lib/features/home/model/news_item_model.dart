class NewsItemModel {
  final String imageUrl;
  final String title;
  final String source;
  final String sourceIcon;
  final String urlSource;
  final String time;
  final String category;
  bool isBookmarked;

  NewsItemModel({
    required this.imageUrl,
    required this.title,
    required this.source,
    required this.sourceIcon,
    required this.urlSource,
    required this.time,
    required this.category,
    this.isBookmarked = false,
  });
}
