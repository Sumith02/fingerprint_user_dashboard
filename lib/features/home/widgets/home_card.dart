import 'package:metrix/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCard extends StatelessWidget {
  final String cardText;
  final bool isOnline;
  final VoidCallback onPressed;
  final String subTitle;
  const HomeCard({
    super.key,
    required this.cardText,
    required this.isOnline,
    required this.onPressed,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 100,
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          elevation: 5,
          shadowColor: AppColors.lightBlue,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fingerprint_rounded,
                    color: isOnline ? AppColors.blue : AppColors.moderateBlue,
                    size: 80,
                  ),
                  SizedBox(height: 30),
                  Text(
                    textAlign: TextAlign.center,
                    cardText,
                    style: GoogleFonts.poppins(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    subTitle,
                    style: GoogleFonts.poppins(
                      color: AppColors.darkGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
