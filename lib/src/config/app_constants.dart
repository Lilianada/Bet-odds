import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF013D7B);
  static const Color background = Color.fromRGBO(4, 4, 5, 1);
  static const Color modal = Color.fromARGB(255, 23, 23, 23);
  static const Color secondary = Color(0xFF1969b2);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color.fromARGB(255, 155, 155, 155);
  static const Color link = Color(0xFF00C9E6);
  static const Color error = Color(0xFFE60000);
  static const Color success = Color(0xFF00E600);
  static const Color transparent = Color(0x00000000);
  static const Color labelTextStyle = Color.fromARGB(255, 74, 74, 74);
  static const Color purple = Color(0xFF682AF7);
}

class AppStyles {
  static const TextStyle buttonTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
    color: Colors.black,
  );

  static const TextStyle linkTextStyle = TextStyle(
    fontSize: 16.0,
    color: AppColors.primary,
    fontWeight: FontWeight.normal,
  );

  // static const TextStyle headerTextStyle = TextStyle(
  //   fontSize: 24.0,
  //   color: AppColors.primary,
  //   fontWeight: FontWeight.w700,
  // );

  static const OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 135, 134, 134)),
  );

  static const OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.primary),
  );

  static const OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.error),
  );

  static const OutlineInputBorder focusedErrorBorder = OutlineInputBorder(
    borderSide: BorderSide(color:  AppColors.error),
  );

  static final RoundedRectangleBorder buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  );

  static const TextStyle floatingLabelTextStyle = TextStyle(
    color: AppColors.primary
  );

  static const Size buttonSize = Size(double.infinity, 50.0);
}