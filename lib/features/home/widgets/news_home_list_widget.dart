import 'package:flutter/material.dart';

class NewsHomeListWidget extends StatelessWidget {
  const NewsHomeListWidget({
    super.key,
    required this.news,
  });

  final List news;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Container(
            width: 395,
            height: 355,
            color: Colors.red,
            child: Center(
              child: Text('index $index'),
            ),
          ),
        );
      },
    );
  }
 }
