import 'package:flutter/material.dart';
import 'package:metrix/core/theme/app_colors.dart';

class CustomDropDownMenu extends StatefulWidget {
  final List<String> data;
  final Function(String?) onChanged;
  final String hint;

  const CustomDropDownMenu({
    super.key,
    required this.data,
    required this.onChanged,
    required this.hint,
  });

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  String? dropDownValue;

  @override
  void initState() {
    super.initState();
    if (widget.data.isNotEmpty) {
      dropDownValue = widget.data.first;
    } else {
      dropDownValue = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      icon: Icon(Icons.arrow_drop_down_rounded , color: AppColors.blue,size: 24,),
        borderRadius: BorderRadius.circular(10),
        dropdownColor: AppColors.white,
        value:
            widget.data.contains(dropDownValue)
                ? dropDownValue
                : null,
        hint: Text(widget.hint),
        items: widget.data.isNotEmpty
                ? widget.data.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()
                : [],
        onChanged: (String? newValue) {
          setState(() {
            dropDownValue = newValue;
            widget.onChanged(newValue);
          });
        },
    );
  }
}
