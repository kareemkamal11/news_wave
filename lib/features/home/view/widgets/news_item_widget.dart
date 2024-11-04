// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_styles.dart';
import 'package:news_wave/features/home/view/widgets/news_reading_screen.dart';

class NewsItemWidget extends StatelessWidget {
  const NewsItemWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.source,
    required this.time,
    required this.category,
    required this.urlSource,
    required this.sourceIcon,
    required this.isBookmarked,
    required this.onMarked,
  });

  final String imageUrl;
  final String title;
  final String source;
  final String sourceIcon;
  final String time;
  final String category;
  final String urlSource;
  final bool isBookmarked;
  final Function() onMarked;

  @override
  Widget build(BuildContext context) {
    Future<bool> checkInternetConnection() async {
      try {
        final result = await InternetAddress.lookup(urlSource);
        return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } on SocketException catch (_) {
        return false;
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: InkWell(
        onTap: () async {
          if (await checkInternetConnection()) {
            AppStyles.errorToastr(
                context, 'No internet connection. Please try again later.');
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NewsReadingScreen(url: urlSource),
              ),
            );
          }
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
                  image: imageUrl.isEmpty
                      ? AssetImage(AppAssets.failedImaeg)
                      : imageUrl.startsWith('http')
                          ? NetworkImage(imageUrl)
                          : FileImage(
                              File(imageUrl),
                            ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Positioned(
              bottom: 0,
              child: NewsItemDataWidget(
                title: title,
                source: source,
                sourceIcon: sourceIcon,
                time: time,
                isBookmarked: isBookmarked,
                onMarked: onMarked,
                category: category,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// final Uri uri = url.startsWith('http')
//     ? Uri.parse(url) // إذا كان من الإنترنت
//     : Uri.file(url); // إذا كان من التخزين المحلي

class NewsItemDataWidget extends StatelessWidget {
  const NewsItemDataWidget({
    super.key,
    required this.title,
    required this.source,
    required this.time,
    required this.isBookmarked,
    required this.onMarked,
    required this.category,
    required this.sourceIcon,
  });

  final String title;
  final String source;
  final String sourceIcon;
  final String time;
  final String category;
  final bool isBookmarked;
  final Function() onMarked;

  @override
  Widget build(BuildContext context) {
    final timeData = DateFormat('MM-dd hh:mm');
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
                onPressed: onMarked,
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
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.transparent,
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
                timeData.format(DateTime.parse(time)),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 25),
              Text(
                category,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
