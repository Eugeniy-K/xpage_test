import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xpage_test/utils/constants.dart';

ThemeData? materialTheme = ThemeData(
  scaffoldBackgroundColor: kBackgroundColor,
  brightness: Brightness.light,
  primaryColor: Colors.white,
  // appBarTheme: AppBarTheme(
  //   backgroundColor: kPrimarySwatchColor,
  //   centerTitle: true,
  //   systemOverlayStyle: SystemUiOverlayStyle(
  //     statusBarIconBrightness: Brightness.light,
  //   ),
  // ),
  fontFamily: kFontFamily,
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 22,
      height: 1.36,
      fontWeight: FontWeight.w700,
      color: kTextColor,
    ),
    // headline2: TextStyle(
    //   fontSize: 20,
    //   height: 1.5,
    //   fontWeight: FontWeight.w700,
    //   color: kWhiteColor,
    // ),
  ),
);

CupertinoThemeData? cupertinoTheme = CupertinoThemeData(
  scaffoldBackgroundColor: kBackgroundColor,
  textTheme: CupertinoTextThemeData(
    textStyle: TextStyle(
      fontFamily: kFontFamily,
      fontSize: 15,
      height: 1.46,
      color: kTextColor,
    ),
    navTitleTextStyle: TextStyle(
      fontFamily: kFontFamily,
      fontWeight: FontWeight.w700,
      height: 1.5,
      fontSize: 20,
      color: kWhiteColor,
    ),
    navActionTextStyle: TextStyle(color: kWhiteColor),
    tabLabelTextStyle: TextStyle(),
  ),
  brightness: Brightness.light,
);
