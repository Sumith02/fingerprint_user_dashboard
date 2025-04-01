
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrix/core/theme/app_colors.dart';

class AppTheme {
  static _borderTheme([
    Color borderColor = AppColors.darkGrey,
    double width = 1,
  ]) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: borderColor, width: width),
  );

  static final ThemeData lightTheme = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColors.moderateBlue,
      cursorColor: AppColors.blue,
    ),
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.blue,
        statusBarBrightness: Brightness.light,
      ),
      titleSpacing: 4,
      titleTextStyle: GoogleFonts.poppins(
        color: AppColors.white,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: AppColors.white, size: 30),
      backgroundColor: AppColors.blue,
      elevation: 0,
      surfaceTintColor: AppColors.transparent,
      centerTitle: false,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: GoogleFonts.poppins(color: AppColors.darkGrey),
      border: _borderTheme(),
      errorBorder: _borderTheme(),
      enabledBorder: _borderTheme(),
      focusedBorder: _borderTheme(AppColors.blue, 2),
      disabledBorder: _borderTheme(),
    ),
    cardTheme: CardTheme(
      surfaceTintColor: AppColors.white,
      color: AppColors.white,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.white,
      dayPeriodColor: AppColors.moderateBlue,
      dayPeriodTextColor: AppColors.black,
      dialBackgroundColor: AppColors.lightBlue,
      dialHandColor: AppColors.blue,
      hourMinuteColor: AppColors.moderateBlue,
      hourMinuteTextColor: AppColors.black,
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.blue),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.blue),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.blue),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.blue),
      ),
      backgroundColor: AppColors.white,
      headerBackgroundColor: AppColors.blue,
      headerForegroundColor: AppColors.white,
      headerHelpStyle: GoogleFonts.poppins(
        color: AppColors.white,
        fontSize: 14,
      ),
      headerHeadlineStyle: GoogleFonts.poppins(
        color: AppColors.white,
        fontSize: 35,
      ),
    ),
  );
}
