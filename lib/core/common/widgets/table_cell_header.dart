import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrix/core/theme/app_colors.dart';

class TableCellHeader extends StatelessWidget {
  final String title;
  const TableCellHeader({super.key , required this.title});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
    );
  }
}
