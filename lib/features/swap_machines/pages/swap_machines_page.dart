import 'package:metrix/core/common/widgets/custom_app_bar.dart';
import 'package:metrix/core/common/widgets/custom_drop_down.dart';
import 'package:metrix/core/common/widgets/custom_elevated_button.dart';
import 'package:metrix/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwapMachinesPage extends StatefulWidget {
  const SwapMachinesPage({super.key});

  @override
  State<SwapMachinesPage> createState() => _SwapMachinesPageState();
}

class _SwapMachinesPageState extends State<SwapMachinesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(
            onPressed: () {},
            title: "Swap Machines",
          ).buildCustomAppBar(),
      body: Center(
        child: SizedBox(
          height: 480,
          width: 400,
          child: Card(
            elevation: 100,
            shadowColor: AppColors.moderateBlue,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    Icons.swap_calls_rounded,
                    size: 100,
                    color: AppColors.blue,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Swap Machines",
                    style: GoogleFonts.poppins(
                      color: AppColors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    textAlign: TextAlign.center,
                    "This Route will Swap Both the Machines Selected.",
                    style: GoogleFonts.poppins(
                      color: AppColors.darkGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomDropDownMenu(
                    data: ["Hello"],
                    onChanged: (value) {},
                    hint: "Select the Machine",
                  ),
                  SizedBox(height: 20),
                  CustomDropDownMenu(
                    data: ["Hello"],
                    onChanged: (values) {},
                    hint: "Select the Machine",
                  ),
                  SizedBox(height: 20),
                  CustomElevatedButton(
                    onPressed: () {},
                    buttonSize: Size(MediaQuery.of(context).size.width, 55),
                    buttonText: "Swap Data",
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
