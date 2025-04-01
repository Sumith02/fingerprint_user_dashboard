
import 'package:flutter/material.dart';
import 'package:metrix/core/theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool isObscureText;
  final String hintText;
  final IconData icon;
  final bool isPasswordField;
  final Function(String)? onChanged;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.isObscureText = false,
    this.isPasswordField = false,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isObscure;

  @override
  void initState() {
    isObscure = widget.isObscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: isObscure,
      cursorColor: AppColors.blue,
      cursorHeight: 18,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(widget.icon, color: AppColors.blue),
        suffixIcon:
            widget.isPasswordField
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: isObscure ? AppColors.darkGrey : AppColors.blue,
                  ),
                )
                : null,
      ),
    );
  }
}
