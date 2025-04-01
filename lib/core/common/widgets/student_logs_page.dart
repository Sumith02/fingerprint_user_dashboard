
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrix/core/common/widgets/custom_app_bar.dart';
import 'package:metrix/core/common/widgets/custom_text_field.dart';
import 'package:metrix/core/theme/app_colors.dart';

class StudentLogsPage extends StatefulWidget {
  const StudentLogsPage({super.key});

  @override
  State<StudentLogsPage> createState() => _StudentLogsPageState();
}

class _StudentLogsPageState extends State<StudentLogsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(onPressed: () {}, title: "Log's").buildCustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Student Log's",
                          style: GoogleFonts.poppins(
                            color: AppColors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Student Log's can be Verified with Dates.",
                          style: GoogleFonts.poppins(color: AppColors.darkGrey),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: 300,
                      child: CustomTextField(
                        controller: TextEditingController(),
                        hintText: "Search...",
                        icon: Icons.search_rounded,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              
            ],
          ),
        ),
      ),
    );
  }
}
