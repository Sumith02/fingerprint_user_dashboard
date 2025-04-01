import 'package:flutter/material.dart';
import 'package:metrix/core/theme/app_colors.dart';


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          color: AppColors.blue,
          strokeCap: StrokeCap.round,
          strokeWidth: 5,
        ),
      ),
    );
  }
}