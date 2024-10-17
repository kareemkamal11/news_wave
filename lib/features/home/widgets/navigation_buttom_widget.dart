import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_styles.dart';
import 'package:news_wave/core/static/app_texts.dart';

class NavigationButtomWidget extends StatelessWidget {
  const NavigationButtomWidget({
    super.key,
    required this.selected,
    required this.pageController,
    required this.onTap,
  });

  final int selected;

  final PageController pageController;

  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppAssets.homeIcon),
          activeIcon: SvgPicture.asset(AppAssets.homeSelected),
          label: AppTexts.home,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppAssets.topicesIcon),
          activeIcon: SvgPicture.asset(AppAssets.topicsSelected),
          label: AppTexts.topics,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppAssets.authorIcon),
          activeIcon: SvgPicture.asset(AppAssets.authorSelected),
          label: AppTexts.author,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppAssets.bookmarkIcon),
          activeIcon: SvgPicture.asset(AppAssets.bookmarkSelected),
          label: AppTexts.bookmark,
        ),
      ],
      iconSize: 50,
      selectedIconTheme: IconThemeData(color: AppColors.primaryColor),
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      currentIndex: selected,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.textColor,
      onTap: onTap,
    );
  }
}
