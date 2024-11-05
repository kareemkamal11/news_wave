class NewsItemModel {
  String title;
  String imageUrl;
  String source;
  String sourceIcon;
  String time;
  String urlSource;
  String category;
  bool isBookmarked;

  NewsItemModel({
    required this.title,
    required this.imageUrl,
    required this.source,
    required this.sourceIcon,
    required this.time,
    required this.urlSource,
    required this.category,
    required this.isBookmarked,
  });

}
