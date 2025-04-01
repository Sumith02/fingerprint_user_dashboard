
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrix/core/theme/app_colors.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onDonePressed;
  final VoidCallback onCancelPressed;
  const CustomDialog({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onDonePressed,
    required this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 145,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
        child: Column(
          children: [
            Align(
              alignment: Alignment(-1, 0),
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment(-1, 0),
              child: Text(
                subTitle,
                style: GoogleFonts.poppins(color: AppColors.black),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: onDonePressed,
                  icon: Icon(Icons.done_rounded, color: AppColors.blue),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: onCancelPressed,
                  icon: Icon(Icons.close_rounded, color: AppColors.redColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
