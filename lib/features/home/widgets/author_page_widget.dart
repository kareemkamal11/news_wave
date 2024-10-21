import 'package:flutter/material.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/features/home/widgets/custom_app_bar.dart';

import 'topics_item_widget.dart';

class AuthorPageWidget extends StatelessWidget {
  const AuthorPageWidget(
      {super.key, required this.author, required this.imagePath});

  final List author;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    String imageSource = '';
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CustomAppBar(
            imagePath: imagePath,
            selected: 2,
          ),
        ),
        SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            return CategoryItemWidget(
              title: 'BBC News',
              image: DecorationImage(
                image: imageSource.isEmpty
                    ? AssetImage(AppAssets.failedImaeg)
                    : NetworkImage(imageSource), // رابط الصورة
              ),
              onTap: () {},
            );
          },
          itemCount: author.length,
        ),
      ],
    );
  }
}

class SourceItemWidget extends StatelessWidget {
  final String imageSource; // رابط الصورة
  final VoidCallback onTap; // الفانكشن الذي سيتم تنفيذه عند الضغط
  final String source;

  const SourceItemWidget({
    super.key,
    required this.imageSource,
    required this.onTap,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // تنفيذ الفانكشن عند الضغط
      child: Container(
        width: 178,
        height: 100,
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias, // تقطيع الصورة لكي
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // تدوير الحواف بـ 10
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // ظل خفيف
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), // تغيير اتجاه الظل
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageSource.isEmpty
                      ? AssetImage(AppAssets.failedImaeg)
                      : NetworkImage(imageSource), // رابط الصورة
                ),
              ),
            ),
            Center(
              child: Text(
                source,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
