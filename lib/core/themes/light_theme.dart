import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/core/themes/color.dart';

final ThemeData lightTheme = ThemeData(
    appBarTheme: appbarTheme(),
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: redColor),
    fontFamily: GoogleFonts.poppins().fontFamily,
    scaffoldBackgroundColor: whiteColor,
    textTheme: textTheme());

AppBarTheme appbarTheme() => const AppBarTheme(
      backgroundColor: whiteColor,
      centerTitle: false,
      elevation: 0,
    );

//Text Theme

TextTheme textTheme() => const TextTheme(
      headlineLarge: TextStyle(
        color: blackColor,
        fontSize: 28,
        fontWeight: FontWeight.w900,
        letterSpacing: 2.0,
      ),
      headlineMedium: TextStyle(
        color: blackColor,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        letterSpacing: 2.0,
      ),
      headlineSmall: TextStyle(
        color: blackColor,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 2.0,
      ),
      titleLarge: TextStyle(
        color: blackColor,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        letterSpacing: 2.0,
      ),
      titleMedium: TextStyle(
        color: blackColor,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 2.0,
      ),
      titleSmall: TextStyle(
        color: greyColor,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 2.0,
      ),
      bodyLarge: TextStyle(
        color: blackColor,
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 2.0,
      ),
      bodyMedium: TextStyle(
        color: greyColor,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: 2.0,
      ),
      bodySmall: TextStyle(
        color: blackColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: 2.0,
      ),
    );
