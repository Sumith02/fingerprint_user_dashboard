import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrix/core/theme/app_colors.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onPressed;
  const CustomErrorWidget({super.key, required this.errorMessage , required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_rounded, color: AppColors.blue, size: 100),
          SizedBox(height: 20),
          Text(
            errorMessage,
            style: GoogleFonts.poppins(
              color: AppColors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "You can try again.",
            style: GoogleFonts.poppins(
              color: AppColors.darkGrey,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 10),
          IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.refresh_rounded, color: AppColors.blue, size: 30),
          ),
        ],
      ),
    );
  }
}
