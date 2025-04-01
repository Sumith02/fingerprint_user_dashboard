import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metrix/core/theme/app_colors.dart';

class CustomTimePickerField extends StatefulWidget {
  final TextEditingController timeController;
  final String hint;
  const CustomTimePickerField({
    super.key,
    required this.timeController,
    required this.hint,
  });

  @override
  State<CustomTimePickerField> createState() => _CustomTimePickerFieldState();
}

class _CustomTimePickerFieldState extends State<CustomTimePickerField> {
  Future<void> _showTimeDialog(TextEditingController controller) async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (time != null) {
      setState(() {
        // Convert TimeOfDay to a formatted 12-hour string
        final now = DateTime.now();
        final formattedTime = DateFormat('hh:mm a').format(
          DateTime(now.year, now.month, now.day, time.hour, time.minute),
        );
        controller.text = formattedTime; // Store formatted time
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        _showTimeDialog(widget.timeController);
      },
      readOnly: true,
      controller: widget.timeController,
      cursorColor: AppColors.blue,
      cursorHeight: 18,
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: Icon(Icons.watch_later_outlined, color: AppColors.blue),
      ),
    );
  }
}
