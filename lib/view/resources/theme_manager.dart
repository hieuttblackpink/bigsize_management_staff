import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:google_fonts/google_fonts.dart';

ThemeData lightThemeData = ThemeData(
  fontFamily: "Quicksand",
  backgroundColor: ColorManager.backGroundBlue,
  scaffoldBackgroundColor: ColorManager.backGroundBlue,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ColorManager.whiteColor,
    foregroundColor: ColorManager.foreGroundGrey,
  ),
  appBarTheme: AppBarTheme(
      elevation: 0,
      toolbarHeight: 50,
      titleSpacing: 0,
      titleTextStyle: _textTheme.headline2,
      foregroundColor: ColorManager.foreGroundGrey,
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white.withOpacity(0),
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark)),
  primaryTextTheme: _textTheme,
  primaryColor: ColorManager.mainBlue,
  iconTheme: const IconThemeData(color: ColorManager.darkGrey, size: 30),
  brightness: Brightness.light,
  primaryColorDark: ColorManager.darkGrey,
  primaryColorLight: ColorManager.darkGrey,
  listTileTheme: ListTileThemeData(
    tileColor: ColorManager.whiteColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(ColorManager.foreGroundBlue),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    )),
    foregroundColor: MaterialStateProperty.all(ColorManager.darkWhite),
  )),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    side: MaterialStateBorderSide.resolveWith((states) =>
        BorderSide(color: Colors.grey.withOpacity(0.4), width: 2.0)),
    foregroundColor: MaterialStateProperty.all(ColorManager.darkGrey),
  )),
  textTheme: _textTheme,
  colorScheme: const ColorScheme(
    background: ColorManager.backGroundBlue,
    onSurface: ColorManager.foreGroundBlue,
    onBackground: ColorManager.foreGroundGrey,
    onSecondary: ColorManager.whiteColor,
    onPrimary: ColorManager.lightGrey,
    primary: ColorManager.darkGrey,

    // till here
    secondary: ColorManager.lightBlue,
    surface: ColorManager.darkWhite,
    error: ColorManager.whiteColor,
    onError: ColorManager.lightGrey,
    brightness: Brightness.light,
  ),
);

class ColorManager {
  static const Color foreGroundGrey = Color(0xff939094);
  static const Color foreGroundBlue = Color(0xff2D8EFF);

  static const Color backGroundBlue = Color.fromRGBO(235, 246, 255, 1);

  static const Color mainBlue = Color(0xff2666CF);
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Color(0xFF2C3333);
  static const Color lightBlue = Color(0xFF30AADD);
  static const Color darkWhite = Color(0xFFEEEEEE);
  static const Color darkGrey = Color.fromRGBO(64, 64, 64, 1);
  static const Color lightGrey = Color.fromRGBO(175, 175, 175, 1.0);
}

const TextTheme _textTheme = TextTheme(
  headline1: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: "QuicksandBold"),
  headline2: TextStyle(
      //used
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontFamily: "QuicksandBold"),
  headline3: TextStyle(
      //used
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: ColorManager.whiteColor,
      fontFamily: "QuicksandMedium"),
  headline4: TextStyle(
      //used
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontFamily: "QuicksandMedium"),
  caption: TextStyle(
      //used
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: ColorManager.blackColor,
      fontFamily: "QuicksandBold"),

  subtitle1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: ColorManager.blackColor,
      fontFamily: "QuicksandMedium"),
  subtitle2: TextStyle(
      fontSize: 18,
      color: ColorManager.foreGroundBlue,
      fontFamily: "QuicksandBold"),

  // here
  button: TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "QuicksandBold"),
  overline: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: Colors.black,
      fontFamily: "Quicksand"),
);
