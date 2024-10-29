import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_styles.dart';

class NewsReadingScreen extends StatelessWidget {
  const NewsReadingScreen({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ReadingAppBarWidget(),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri(url),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class ReadingAppBarWidget extends StatelessWidget {
  const ReadingAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.textColor),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Image.asset(AppAssets.logoIcon,
                  width: 90, height: 40, color: AppColors.primaryColor),
              IconButton(
                icon: Icon(Icons.share, color: AppColors.textColor),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 2,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
