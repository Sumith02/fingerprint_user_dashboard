import 'package:metrix/core/common/widgets/table_cell_elements.dart';
import 'package:metrix/core/theme/app_colors.dart';
import 'package:metrix/core/common/widgets/table_cell_header.dart';
import 'package:flutter/material.dart';

class LogsTable extends StatelessWidget {
  final List<Map<String, dynamic>> logs;
  final String name;
  final String usn;
  const LogsTable({
    super.key,
    required this.logs,
    required this.name,
    required this.usn,
  });


  String convertDateFormat(String date) {
    List<String> parts = date.split('-');
    return '${parts[2]}-${parts[1]}-${parts[0]}';
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: AppColors.darkGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      children: [
        TableRow(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.white),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: AppColors.blue,
          ),
          children: [
            TableCellHeader(title: "Name"),
            TableCellHeader(title: "USN"),
            TableCellHeader(title: "Date"),
            TableCellHeader(title: "Login"),
            TableCellHeader(title: "Logout"),
          ],
        ),
        ...List.generate(logs.length, (index) {
          return TableRow(
            children: [
              TableCellElements(title: name),
              TableCellElements(title: usn),
              TableCellElements(title: convertDateFormat(logs[index]["date"])),
              TableCellElements(title: logs[index]["login_time"] == "25:00" ? "Pending" : logs[index]["login_time"] ),
              TableCellElements(title: logs[index]["logout_time"] == "25:00" ? "Pending" : logs[index]["logout_time"]),
            ],
          );
        }),
      ],
    );
  }
}
