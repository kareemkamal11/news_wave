// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_wave/auth/view/widgets/auth_widget/auth_custom_button.dart';
import 'package:news_wave/auth/view/widgets/profile_widget/form_profile_widget.dart';
import 'package:news_wave/auth/view/widgets/profile_widget/profile_image.dart';
import 'package:news_wave/core/static/app_texts.dart';

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
    } else if (value.length < 11 && !isNumeric(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? imageValidate;

// Future<void> submitForm() async {
//   if (formKey.currentState?.validate() ?? false) {
//     String name = nameController.text;
//     String username = usernameController.text;
//     String phone = phoneNumberController.text;
//     String? imageUrl;

//     try {
//       if (image != null) {
//         Reference storageReference = FirebaseStorage.instance // يعني هنا بنعمل ريفرنس للمكان اللي هيتحط فيه الصورة في الفايربيس
//             .ref() // هنا بنعمل ريفرنس للفايربيس كله
//             .child('profile_images/${image!.getUuid()}'); // هنا بنعمل ريفرنس للمكان اللي هيتحط فيه الصورة في الفايربيس
//         UploadTask uploadTask = storageReference.putFile(File(image!.path)); // هنا بنرفع الصورة للفايربيس
//         TaskSnapshot taskSnapshot = await uploadTask; // هنا بنستني لحد ما تترفع الصورة
//         imageUrl = await taskSnapshot.ref.getDownloadURL(); // هنا بنجيب الرابط بتاع الصورة اللي اترفعت
//       }

//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance // هنا بنجيب الداتا من الفايربيس
//           .collection('users') // هنا بندخل علي الكولكشن بتاع اليوزرز
//           .where('username', isEqualTo: username) // هنا بنعمل وير كويري علي اليوزرنيم بتاع اليوزر علشان نشوف هل اليوزرنيم ده موجود ولا لا
//           .get(); // هنا بنجيب الداتا اللي جبناها من الفايربيس
//       if (querySnapshot.docs.isNotEmpty) { // هنا بنشوف هل الداتا اللي جبناها موجودة ولا لا لو موجودة يبقي اليوزرنيم ده موجود
//         AppStyles.errorToastr(context, 'Username already exists'); // هنا بنعمل توستر بتقول ان اليوزرنيم ده موجود
//         return;
//       }

//       await FirebaseFirestore.instance.collection('users').add({ // هنا بنضيف الداتا اللي احنا جبناها من اليوزر للفايربيس
//         'name': name,
//         'username': username,
//         'phone': phone,
//         'imageUrl': imageUrl,
//       });
//     } on FirebaseException catch (e) {
//       if (e.code == 'unauthorized') {
//         AppStyles.errorToastr(context, 'You are not authorized to perform this action.');
//       } else {
//         AppStyles.errorToastr(context, 'An error occurred: ${e.message}');
//       }
//     }
//   }
// }
  Future<void> selectImage(ImageSource source) async {
    final XFile? pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    } else {
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
        child: Column(
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
                    imageValidate ?? '',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 25),
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
            Positioned(
              child: Container(
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
                  onPressed: () {
                    log('pressed');
                  },
                  label: AppTexts.auth.next,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
