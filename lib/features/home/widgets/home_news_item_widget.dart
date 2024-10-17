import 'package:flutter/material.dart';
import 'package:news_wave/core/static/app_styles.dart';

class HomeNewsItemWidget extends StatefulWidget {
  const HomeNewsItemWidget({
    super.key,
    required this.index,
    required this.color,
  });

  final int index;
  final Color color;

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
            color: widget.color,
            child: Center(
              child: Text('index ${widget.index}'),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
                width: 395,
                height: 100,
                padding: EdgeInsets.all(10),
                color: Colors.black.withOpacity(0.5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: 'Gaza War: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '"Where can we hide from the death coming from the sky?"',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 16,
                                ),
                              ),
                            ]),
                          ),
                        ),
                        TextButton(
                          child: !isBookmarked
                              ? Icon(Icons.bookmark_border_sharp,
                                  color: AppColors.textWhiteColor)
                              : Icon(Icons.bookmark,
                                  color: AppColors.primaryColor),
                          onPressed: () {
                            setState(() {
                              isBookmarked = !isBookmarked;
                            });
                          },
                        )
                      ],
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
