import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_styles.dart';
import 'package:news_wave/features/home/view/screen/news_reading_screen.dart';

class NewsItemWidget extends StatefulWidget {
  const NewsItemWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.source,
    required this.time,
    required this.category,
    required this.urlSource,
    required this.sourceIcon,
  });

  final String imageUrl;
  final String title;
  final String source;
  final String sourceIcon;
  final String time;
  final String category;
  final String urlSource;

  @override
  State<NewsItemWidget> createState() => _NewsItemWidgetState();
}

class _NewsItemWidgetState extends State<NewsItemWidget> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewsReadingScreen(url: widget.urlSource),
            ),
          );
        },
        child: Stack(
          children: [
            Container(
              width: 395,
              height: 355,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0.5),
                  width: 1,
                ),
                image: DecorationImage(
                  image: widget.imageUrl.isEmpty
                      ? AssetImage(AppAssets.failedImaeg)
                      : NetworkImage(widget.imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Positioned(
              bottom: 0,
              child: NewsItemDataWidget(
                title: widget.title,
                source: widget.source,
                sourceIcon: widget.sourceIcon,
                time: widget.time,
                isBookmarked: isBookmarked,
                bookmark: () {
                  setState(() {
                    isBookmarked = !isBookmarked;
                  });
                },
                category: widget.category,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewsItemDataWidget extends StatelessWidget {
  const NewsItemDataWidget({
    super.key,
    required this.title,
    required this.source,
    required this.time,
    required this.isBookmarked,
    required this.bookmark,
    required this.category,
    required this.sourceIcon,
  });

  final String title;
  final String source;
  final String sourceIcon;
  final String time;
  final String category;
  final bool isBookmarked;
  final Function() bookmark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 395,
      height: 100,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton(
                onPressed: bookmark,
                child: !isBookmarked
                    ? Icon(
                        Icons.bookmark_border_sharp,
                        color: AppColors.textWhiteColor,
                      )
                    : Icon(Icons.bookmark, color: AppColors.primaryColor),
              )
            ],
          ),
          Row(
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                  image: DecorationImage(
                    image: sourceIcon.isEmpty
                      ? AssetImage(
                          AppAssets.failedIcon,
                        )
                      : NetworkImage(sourceIcon),
                      fit: BoxFit.cover,
                ),
              ),
              ),
              SizedBox(width: 5),
              Text(
                source,
                style: GoogleFonts.poppins(
                  color: Colors.blueGrey[200],
                  //
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 15),
              Icon(Icons.access_time_rounded, color: Colors.white),
              SizedBox(width: 2),
              Text(
                time,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 50),
              Text(
                category,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
