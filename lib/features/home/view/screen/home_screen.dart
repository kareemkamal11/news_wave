// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_wave/core/helper/context_helper.dart';
import 'package:news_wave/core/static/app_styles.dart';
import 'package:news_wave/core/token/email_token.dart';
import 'package:news_wave/database_helper.dart';
import 'package:news_wave/features/auth/view/screens/auth_screen.dart';
import 'package:news_wave/features/home/view/screen/bottom_navigation_pages/author_page_widget.dart';
import 'package:news_wave/features/home/view/screen/bottom_navigation_pages/bookmark_page_widget.dart';
import 'package:news_wave/features/home/view/widgets/navigation_buttom_widget.dart';
import 'package:news_wave/features/home/view/screen/bottom_navigation_pages/news_page_widget.dart';
import 'package:news_wave/features/home/view/screen/bottom_navigation_pages/topics_page_widget.dart';
import 'package:news_wave/features/home/view_model/home_cubit.dart';
import 'package:news_wave/features/home/view_model/home_state.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName;
  String? email;
  String? imagePath;

  Future<void> fetchImagePath() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      String? user = await EmailToken.getEmail();
      var data = await DatabaseHelper.instance.getUser(user!);
      setState(() {
        email = user;
        userName = data['name'];
        imagePath = data['imagePath'];
      });
    } catch (e) {
      print('Error fetching image path: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchImagePath();
  }

  int selected = 0;

  final PageController pageController = PageController();

  void onItemTapped(int index) {
    setState(() {
      selected = index;
    });
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var homeCubit = BlocProvider.of<HomeCubit>(context);

        return SafeArea(
          child: Scaffold(
            body: PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: [
                NewsPageWidget(
                  news: homeCubit.newsList,
                  imagePath: imagePath ?? '',
                ),
                TopicsPageWidget(
                  imagePath: imagePath ?? '',
                ),
                AuthorPageWidget(
                  imagePath: imagePath ?? '',
                ),
                BookmarkPageWidget(
                  bookmarkList: homeCubit.bookmarkList,
                  imagePath: imagePath ?? '',
                ),
              ],
            ),
            bottomNavigationBar: NavigationButtomWidget(
              selected: selected,
              pageController: pageController,
              onTap: onItemTapped,
            ),
            drawer: ProfileDrawerWidget(
              userName: userName ?? '',
              userEmail: email ?? '',
              imagePath: imagePath ?? '',
            ),
          ),
        );
      },
    );
  }
}

class ProfileDrawerWidget extends StatelessWidget {
  const ProfileDrawerWidget({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.imagePath,
  });

  final String userName;

  final String userEmail;

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: imagePath.isEmpty
                  ? CircularProgressIndicator()
                  : CircleAvatar(
                      radius: 80,
                      backgroundImage: FileImage(File(imagePath)),
                    ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            userName,
            style: GoogleFonts.poppins(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            userEmail,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 150),
          TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              context.pushReplacementTo(AuthScreen());
            },
            icon: Icon(Icons.logout, color: Colors.red),
            label: Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
