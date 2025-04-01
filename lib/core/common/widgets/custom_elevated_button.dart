import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrix/core/theme/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final Size buttonSize;
  final bool isLoading;
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonSize,
    required this.buttonText,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: buttonSize,
      ),
      onPressed:isLoading ? null : onPressed,
      child: isLoading? SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: AppColors.blue,
          strokeCap: StrokeCap.round,
        ),
      ):Text(
        buttonText,
        style: GoogleFonts.nunito(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
    );
  }
}
