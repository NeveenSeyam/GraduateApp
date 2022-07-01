import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/theme/app_colors.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  double? height;
  double? width;
  Color? color;
  TextFieldContainer(
      {required this.child, this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14),
      padding: EdgeInsets.symmetric(horizontal: 30),
      width: width ?? 314,
      decoration: BoxDecoration(
        color: color ?? AppColors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: child,
    );
  }
}
