import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

const kPrimaryColor = Color(0xFF2CB9C1);
const kTextColor = Color(0xFF2CADB7);
const kCategoryBackgroundColor = Color(0xFFFEEEEEE);
const kCategoryClickedBackgroundColor = Color(0xFFF333333);
const kNewsBackgroundColor = Color(0xFFF32A2EF);
const kNewIconColor = Color(0xFFF32A2EF);
const kCategoryClickedtextColor = Color(0xFFF999999);
const kIconsColor = Color(0xFFF888888);
const kDrawerSelectedColor = Color(0xFFFEAF6FE);
const kDrawerColor = Color(0xFFFFAFAFA);
const kDrawerSelectedTextColor = Color(0xFFF32A2EF);
const kConnectButtnBackGroundColor = Color(0xFFF57AC4A);
const kfabBackGroundColor = Color(0xFFFE6EDF2);

final boldText = GoogleFonts.cairo(
  fontWeight: FontWeight.w700,
  fontSize: SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 8.sp,
);
final boldText3 = GoogleFonts.cairo(
    fontWeight: FontWeight.w700,
    fontSize: SizerUtil.deviceType == DeviceType.mobile ? 13.sp : 8.sp);
final boldText2 = GoogleFonts.cairo(
    fontWeight: FontWeight.w700,
    fontSize: SizerUtil.deviceType == DeviceType.mobile ? 9.sp : 6.sp);

final boldTextWhite =
    GoogleFonts.cairo(fontWeight: FontWeight.w700, color: Colors.white);
final boldTextRadio =
    GoogleFonts.cairo(fontWeight: FontWeight.w700, fontSize: 20);
final boldTextGrey =
    GoogleFonts.cairo(fontWeight: FontWeight.w700, color: Colors.grey);
final boldTextwhite = GoogleFonts.cairo(
    fontWeight: FontWeight.w700,
    fontSize: SizerUtil.deviceType == DeviceType.mobile ? 8.sp : 5.sp,
    color: Colors.white);
final boldTextBlue = GoogleFonts.cairo(
  fontWeight: FontWeight.w700,
  color: Colors.blue,
  fontSize: SizerUtil.deviceType == DeviceType.mobile ? 9.sp : 6.sp,
);
