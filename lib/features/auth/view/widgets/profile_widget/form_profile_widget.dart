import 'package:flutter/material.dart';
import 'package:news_wave/core/static/app_texts.dart';
import 'package:news_wave/features/auth/view/widgets/auth_widget/authentication_field.dart';

class FormProfileWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController phoneNumberController;
  final FocusNode nameFocusNode;
  final FocusNode usernameFocusNode;
  final FocusNode phoneNumberFocusNode;
  final GlobalKey<FormState> formKey;
  final Function(String?) nameValidator;
  final Function(String?) usernameValidator;
  final Function(String?) phoneNumberValidator;

  const FormProfileWidget({
    super.key,
    required this.nameController,
    required this.usernameController,
    required this.phoneNumberController,
    required this.nameFocusNode,
    required this.usernameFocusNode,
    required this.phoneNumberFocusNode,
    required this.formKey,
    required this.nameValidator,
    required this.usernameValidator,
    required this.phoneNumberValidator,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AuthenticationField(
            validator: (value) => nameValidator(value),
            controller: nameController,
            labelText: AppTexts.fullName,
            focusNode: nameFocusNode,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 20),
          AuthenticationField(
            validator: (value) => usernameValidator(value),
            controller: usernameController,
            labelText: AppTexts.username,
            focusNode: usernameFocusNode,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 20),
          AuthenticationField(
            validator: (value) => phoneNumberValidator(value),
            controller: phoneNumberController,
            labelText: AppTexts.phone,
            focusNode: phoneNumberFocusNode,
            keyboardType: TextInputType.phone,
            maxLength: 11,
          ),
        ],
      ),
    );
  }
}
