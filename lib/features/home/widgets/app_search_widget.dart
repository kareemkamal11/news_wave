import 'package:flutter/material.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_styles.dart';

class AppSearchWidget extends StatelessWidget {
  const AppSearchWidget({
    super.key,
    required this.onSearchTapped,
    required this.hintText,
    required this.suffinxIcon,
    required this.onSaved,
    required this.searchController,
  });

  final Function() onSearchTapped;
  final Function(dynamic) onSaved;

  final String hintText;
  final Widget suffinxIcon;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchFieldWidget(
            searchController: searchController,
            suffinxIcon: suffinxIcon,
            onSaved: (value) => onSaved(value),
            onSearchTapped: onSearchTapped,
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({
    super.key,
    required this.suffinxIcon,
    required this.hintText,
    required this.onSaved,
    required this.onSearchTapped,
    required this.searchController,
  });

  final Function(dynamic) onSaved;
  final Function() onSearchTapped;
  final Widget? suffinxIcon;
  final String hintText;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onSubmitted: (value) => onSearchTapped,
      onChanged: (value) => onSaved(value),
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      maxLines: 1,
      decoration: InputDecoration(
        enabledBorder: AppStyles.searchFieldBorder,
        focusedBorder: AppStyles.searchFieldBorder,
        hintText: hintText,
        hintStyle: AppStyles.titleTextStyle
            .copyWith(color: AppStyles.primaryColor, fontSize: 20),
        suffixIcon: suffinxIcon,
        prefixIcon: Image.asset(AppAssets.searchIcon, width: 30, height: 30),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 3,
          ),
        ),
      ),
    );
  }
}
