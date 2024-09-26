import 'package:flutter/material.dart';

typedef My = AppConstant;

class AppConstant {
  // Value Shortcuts
  static const double padding = 15.0;
  static const double radius = 7.5;
  static const double buttonHeight = 50.0;
  static const double buttonTextSize = 16.0;
  static const double titleTextSize = 18.0;

  // Value Color
  static const Color black = Color(0xFF1E1E1E);
  static const Color softRed = Color(0xFFC53F3F);

  static const Color grey = Color(0xFF747474);
  static const Color grey2 = Color(0xff696969);
  static Color grey3 = const Color(0xffEBEFF3).withOpacity(0.5);
  static Color grey4 = const Color(0xff919191).withOpacity(0.5);

  static const Color blue = Color(0xff57B7EB);

  static const Color green = Color(0xff0ED290);
  static const Color green2 = Color(0xff82CD47);
  static Color green3 = const Color(0xff82CD47).withOpacity(0.1);

  static const Color primaryWithOpacity = Color.fromRGBO(171, 9, 0, 0.1);
  static Color primaryGradient = const Color(0xff82CD47).withOpacity(0.5);

  // Etc
  static const String lipsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.";
  static const Color transparent = Colors.transparent;
  static const Duration duration = Duration(milliseconds: 300);
  static Future delayed = Future.delayed(duration);
  static const Curve curve = Curves.easeIn;
  static const Duration timeout = Duration(minutes: 1);
  static const Duration alertDuration = Duration(milliseconds: 2000);
  static DateTime initialDate = DateTime(2022, 01, 01);
}
