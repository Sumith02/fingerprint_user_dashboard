
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metrix/core/theme/app_colors.dart';

class CustomDatePickerField extends StatefulWidget {
  final TextEditingController dateController;
  final String hint;
  const CustomDatePickerField({
    super.key,
    required this.dateController,
    required this.hint,
  });

  @override
  State<CustomDatePickerField> createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  Future<void> _showDateDialog(TextEditingController controller) async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        controller.text = DateFormat('dd-MM-yyyy').format(date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        _showDateDialog(widget.dateController);
      },
      readOnly: true,
      controller: widget.dateController,
      cursorColor: AppColors.blue,
      cursorHeight: 18,
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: Icon(Icons.calendar_month_rounded, color: AppColors.blue),
      ),
    );
  }
}
