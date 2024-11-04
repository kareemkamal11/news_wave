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

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'source': source,
      'sourceIcon': sourceIcon,
      'time': time,
      'urlSource': urlSource,
      'category': category,
      'isBookmarked': isBookmarked ? 1 : 0,
    };
  }

  factory NewsItemModel.fromMap(Map<String, dynamic> map) {
    return NewsItemModel(
      title: map['title'],
      imageUrl: map['imageUrl'],
      source: map['source'],
      sourceIcon: map['sourceIcon'],
      time: map['time'],
      urlSource: map['urlSource'],
      category: map['category'],
      isBookmarked: map['isBookmarked'] == 1,
    );
  }
}
