import 'package:flutter/material.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/features/home/widgets/custom_app_bar.dart';

class TopicsPageWidget extends StatelessWidget {
  const TopicsPageWidget({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    List topics = [
      {
        'title': 'Business',
        'image': AppAssets.business,
      },
      {
        'title': 'Science',
        'image': AppAssets.science,
      },
      {
        'title': 'Sports',
        'image': AppAssets.sports,
      },
      {
        'title': 'Technology',
        'image': AppAssets.technology,
      }
    ];
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CustomAppBar(
            imagePath: imagePath,
            selected: 1,
          ),
        ),
        SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: 178,
                height: 175,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0C000000),
                      blurRadius: 2,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset(
                      topics[index]['image'],
                      fit: BoxFit.cover,
                    ),
                    Text(
                      topics[index]['title'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: topics.length,
        )
      ],
    );
  }
}
