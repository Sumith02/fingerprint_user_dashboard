import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrix/core/theme/app_colors.dart';

class TableCellElements extends StatelessWidget {
  final String title;
  const TableCellElements({super.key , required this.title});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              color: AppColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}