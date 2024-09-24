import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/auth_custom_button.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/authentication_field.dart';
import 'package:news_wave/auth/view/widgets/profile_widget/profile_image.dart';
import 'package:news_wave/core/static/app_texts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isImageValid = true;

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    return null;
  }

  String imageValidate = '';

  void submitForm() {
    setState(() {
      isImageValid = image != null;
    });

    if (formKey.currentState!.validate() && isImageValid) {
      // Save profile data
      log('Form is valid');
      setState(() {
        imageValidate = '';
      });
      log('Image is valid');
    } else {
      // Show error message
      log('Form is invalid');
      if (!isImageValid) {
        setState(() {
          imageValidate = 'Please select an image';
        });
      }
    }
  }

  final ImagePicker picker = ImagePicker();
  File? image;

  Future<void> getImage(ImageSource source) async {
    final XFile? pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage
            .path); // ???? ??? ???? ???? ?????? ?????? ??? ??? ??? ????? ?? ????? ?? ???????
        log(image!.path);
      });
    }
  }

  void showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextButton.icon(
                icon: const Icon(
                  Icons.photo,
                  size: 20,
                ),
                label: const Text('Gallery'),
                onPressed: () {
                  Navigator.of(context).pop();
                  getImage(ImageSource.gallery);
                },
              ),
              TextButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text('Camera'),
                onPressed: () {
                  Navigator.of(context).pop();
                  getImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 80,
              left: 15,
              right: 15,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppTexts.auth.fillProfile,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.12,
                  ),
                ),
                const SizedBox(height: 20),
                ProfileImage(
                  displayImage: image,
                  getImage: showImageSourceDialog,
                ),
                const SizedBox(height: 10),
                Text(
                  imageValidate.isEmpty ? '' : imageValidate,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 25),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AuthenticationField(
                        validator: (value) => nameValidator(value),
                        controller: nameController,
                        labelText: AppTexts.auth.fullName,
                        focusNode: nameFocusNode,
                      ),
                      const SizedBox(height: 20),
                      AuthenticationField(
                        validator: (value) => usernameValidator(value),
                        controller: usernameController,
                        labelText: AppTexts.auth.username,
                        focusNode: usernameFocusNode,
                      ),
                      const SizedBox(height: 20),
                      AuthenticationField(
                        validator: (value) => phoneNumberValidator(value),
                        controller: phoneNumberController,
                        labelText: AppTexts.auth.phone,
                        focusNode: phoneNumberFocusNode,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x0C000000),
                  blurRadius: 4,
                  offset: Offset(0, -2),
                  spreadRadius: 0,
                )
              ],
            ),
            child: AuthCustomButton(
              onPressed: submitForm,
              label: AppTexts.auth.next,
            ),
          ),
        ],
      ),
    );
  }
}
