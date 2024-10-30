class NewsItemModel {
  final String imageUrl;
  final String title;
  final String source;
  final String sourceIcon;
  final String linkUrl;
  final String time;
  final String category;
  bool isBookmarked;

  NewsItemModel({
    required this.imageUrl,
    required this.title,
    required this.source,
    required this.sourceIcon,
    required this.linkUrl,
    required this.time,
    required this.category,
    this.isBookmarked = false,
  });
}
