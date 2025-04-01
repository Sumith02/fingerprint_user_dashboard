import 'package:metrix/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData leading;
  final IconData trailing;
  final VoidCallback onPressed;
  const DrawerTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.leading,
    required this.trailing,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(leading, size: 28, color: AppColors.blue),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: AppColors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: GoogleFonts.poppins(
          color: AppColors.darkGrey,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Icon(trailing, size: 30, color: AppColors.moderateBlue),
    );
  }
}
