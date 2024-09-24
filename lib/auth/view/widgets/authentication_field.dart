import 'package:flutter/material.dart';
import 'package:news_wave/core/static/app_assets.dart';
import 'package:news_wave/core/static/app_styles.dart';
import 'package:news_wave/core/static/app_texts.dart';

class AuthenticationField extends StatefulWidget {
  final String? hintText;
  final String labelText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? clearText;
  final TextEditingController controller;
  final FocusNode focusNode;

  const AuthenticationField({
    super.key,
    required this.validator,
    this.clearText,
    this.hintText,
    this.onChanged,
    required this.controller,
    required this.labelText,
    this.suffixIcon,
    required this.focusNode,
  });

  @override
  State<AuthenticationField> createState() => _AuthenticationFieldState();
}

class _AuthenticationFieldState extends State<AuthenticationField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      onTextChanged();
    });
    widget.focusNode.addListener(() {
      onTextChanged();
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
    widget.focusNode.dispose();

    widget.controller.removeListener(() {
      onTextChanged();
    });
    widget.focusNode.removeListener(() {
      onTextChanged();
    });
  }

  void onTextChanged() {
    setState(() {});
  }

  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: widget.labelText,
                style: AppStyles.auth.titleTextStyle,
              ),
              const TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        TextFormField(
          focusNode: widget.focusNode,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppStyles.auth.decorationFieldColor,
                width: 3,
              ),
            ),
            errorStyle: TextStyle(color: Colors.red.withOpacity(0.7)),
            suffixIcon: widget.focusNode.hasFocus
                ? (widget.controller.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            widget.controller.clear();
                          });
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.red,
                        ),
                      )
                    : null)
                : (widget.labelText == AppTexts.auth.password
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        child: Image.asset(
                          obscureText
                              ? AppAssets.auth.visiblePassword
                              : AppAssets.auth.invisiblePassword,
                        ),
                      )
                    : null),
            focusedErrorBorder: AppStyles.auth.errorFieldBorder,
          ),
          obscureText: obscureText,
          validator: widget.validator,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
