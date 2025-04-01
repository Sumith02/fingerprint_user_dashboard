import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrix/core/common/widgets/custom_text_field.dart';
import 'package:metrix/core/theme/app_colors.dart';

class CustomUpdateDialog extends StatelessWidget {
  final VoidCallback onDonePressed;
  final VoidCallback onCancelPressed;
  final TextEditingController nameController;
  final TextEditingController usnController;
  final TextEditingController branchController;
  const CustomUpdateDialog({
    super.key,
    required this.onCancelPressed,
    required this.onDonePressed,
    required this.nameController,
    required this.usnController,
    required this.branchController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 340,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              "Update Student Details",
              style: GoogleFonts.poppins(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            CustomTextField(
              controller: nameController,
              hintText: "Student Name",
              icon: Icons.person,
            ),
            SizedBox(height: 20),
            CustomTextField(
              controller: usnController,
              hintText: "Student USN",
              icon: Icons.abc_rounded,
            ),
            SizedBox(height: 20),
            CustomTextField(
              controller: branchController,
              hintText: "Branch",
              icon: Icons.account_balance_rounded,
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
