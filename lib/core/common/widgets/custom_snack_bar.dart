import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrix/core/theme/app_colors.dart';

class CustomSnackBar {
  final String message;
  CustomSnackBar({required this.message});

  SnackBar build(BuildContext context) {
    return SnackBar(
      content: Text(
        message,
        style: GoogleFonts.poppins(
          color: AppColors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: AppColors.blue,
      elevation: 1,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
