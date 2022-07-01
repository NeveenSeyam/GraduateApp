import 'package:flutter/material.dart';
import 'package:hogo_app/utils/theme/app_colors.dart';
import 'package:hogo_app/widgets/text_field_container.dart';
import 'package:sizer/sizer.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  double? height;
  double? width;
  Color? color;
  bool? isObscured;
  String? Function(String?)? validator;
  TextEditingController? controller;

  final ValueChanged<String> onChanged;

  RoundedInputField({
    required this.hintText,
    required this.onChanged,
    this.height,
    this.validator,
    this.controller,
    this.isObscured = false,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      height: height,
      width: width,
      color: color,
      child: TextFormField(
        controller: controller,
        validator: validator ??
            (value) {
              return null;
            },
        cursorColor: AppColors.primaryColor,
        obscureText: isObscured ?? false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              color: AppColors.primaryColor.withOpacity(0.6), fontSize: 13.sp),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
