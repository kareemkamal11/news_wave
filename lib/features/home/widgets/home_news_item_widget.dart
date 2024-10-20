import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_wave/core/static/app_styles.dart';

class HomeNewsItemWidget extends StatefulWidget {
  const HomeNewsItemWidget({
    super.key,
    required this.index,
    required this.imageUrl,
    required this.title,
    required this.source,
    required this.time,
  });

  final int index;
  final String imageUrl;
  final String title;
  final String source;
  final String time;

  @override
  State<HomeNewsItemWidget> createState() => _HomeNewsItemWidgetState();
}

class _HomeNewsItemWidgetState extends State<HomeNewsItemWidget> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Stack(
        children: [
          Container(
            width: 395,
            height: 355,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl),
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
              time: widget.time,
              isBookmarked: isBookmarked,
              bookmark: () {
                setState(() {
                  isBookmarked = !isBookmarked;
                });
              },
            ),
          )
        ],
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
  });

  final String title;
  final String source;
  final String time;
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
                    ? Icon(Icons.bookmark_border_sharp,
                        color: AppColors.textWhiteColor)
                    : Icon(Icons.bookmark, color: AppColors.primaryColor),
              )
            ],
          ),
          Row(children: [
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
          ])
        ],
      ),
    );
  }
}
