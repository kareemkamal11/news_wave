// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_wave/core/static/app_texts.dart';
import 'package:news_wave/features/auth/view/widgets/auth_widget/auth_custom_button.dart';
import 'package:news_wave/features/auth/view/widgets/profile_widget/form_profile_widget.dart';
import 'package:news_wave/features/auth/view/widgets/profile_widget/profile_image.dart';
import 'package:news_wave/database_helper.dart';
import 'package:news_wave/features/home/screen/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.email});

  final String email;

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
  final ImagePicker picker = ImagePicker();
  File? image;

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    } else if (value.length < 8) {
      return 'Username must be at least 6 characters';
    }
    return null;
  }

  String? phoneNumberValidator(String? value) {
    isNumeric(String? s) {
      if (s == null) {
        return false;
      }
      return double.tryParse(s) != null;
    }

    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (value.length < 11 || !isNumeric(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? imageValidate;

  

  submitForm() async {
    log('data is entered');

    if (formKey.currentState!.validate() && image != null) {
      final Map<String, dynamic> user = {
        'email': widget.email,
        'name': nameController.text,
        'username': usernameController.text,
        'phone': phoneNumberController.text,
        'imagePath': image!.path,
      };

      DatabaseHelper.instance.insertUser(user);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else if (image == null) {
      setState(() {
        imageValidate = 'Please select an image';
      });
    }
  }

  Future<void> selectImage(ImageSource source) async {
    final XFile? pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    } else if (image == null) {
      setState(() {
        imageValidate = 'Please select an image';
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
                  selectImage(ImageSource.gallery);
                },
              ),
              TextButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text('Camera'),
                onPressed: () {
                  Navigator.of(context).pop();
                  selectImage(ImageSource.camera);
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
      body: SingleChildScrollView(
        child: Container(
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
                AppTexts.fillProfile,
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
                imageValidate ?? '',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 30),
              FormProfileWidget(
                nameController: nameController,
                usernameController: usernameController,
                phoneNumberController: phoneNumberController,
                nameFocusNode: nameFocusNode,
                usernameFocusNode: usernameFocusNode,
                phoneNumberFocusNode: phoneNumberFocusNode,
                formKey: formKey,
                nameValidator: nameValidator,
                usernameValidator: usernameValidator,
                phoneNumberValidator: phoneNumberValidator,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
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
          label: AppTexts.next,
        ),
      ),
    );
  }
}
