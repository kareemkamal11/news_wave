// import 'package:flutter/material.dart';
// import 'package:news_wave/auth/view/widgets/authentication_field.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_wave/features/auth/core/static/auth_assets.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.displayImage,
    required this.getImage,
  });
  final File? displayImage;
  final Function()? getImage;

  showImage(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.transparent,
            icon: Container(
              width: 300,
              height: 300,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: displayImage == null
                      ? AssetImage(
                          AuthAssets.emptyImage,
                        )
                      : FileImage(
                          File(displayImage!.path),
                        ),
                  fit: BoxFit.cover,
                ),
                shape: const OvalBorder(
                  side: BorderSide(width: 1, color: Color(0xFF0F8ACF)),
                ),
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        children: [
          InkWell(
            onTap: () => showImage(context),
            child: Container(
              width: 150,
              height: 150,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: displayImage == null
                      ? AssetImage(
                          AuthAssets.emptyImage,
                        )
                      : FileImage(
                          File(displayImage!.path),
                        ),
                  fit: BoxFit.cover,
                ),
                shape: const OvalBorder(
                  side: BorderSide(width: 1, color: Color(0xFF0F8ACF)),
                ),
              ),
            ),
          ),
          Positioned(
            left: 93,
            top: 110,
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: getImage,
              child: Container(
                width: 40,
                height: 40,
                clipBehavior: Clip.antiAlias,
                decoration: const ShapeDecoration(
                  color: Color(0xFF0F8ACF),
                  shape: OvalBorder(
                    side: BorderSide(width: 1, color: Color(0xFF0F8ACF)),
                  ),
                ),
                child: Image.asset(AuthAssets.takePhoto,
                    width: 20, height: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
