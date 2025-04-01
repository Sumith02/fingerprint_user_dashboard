import 'package:flutter/material.dart';

class CustomAppBar {
  final VoidCallback onPressed;
  final String title;
  const CustomAppBar({required this.onPressed , required this.title});
  PreferredSizeWidget buildCustomAppBar() {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(onPressed: onPressed, icon: Icon(Icons.refresh_rounded)),
        SizedBox(width: 10),
      ],
    );
  }
}
