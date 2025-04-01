import 'package:metrix/core/args/details_args.dart';
import 'package:metrix/core/common/widgets/custom_dialog.dart';
import 'package:metrix/core/common/widgets/custom_update_dialog.dart';
import 'package:metrix/core/common/widgets/table_cell_elements.dart';
import 'package:metrix/core/common/widgets/table_cell_header.dart';
import 'package:metrix/core/theme/app_colors.dart';
import 'package:metrix/features/student_details/cubits/delete_student_cubit.dart';
import 'package:metrix/features/student_details/cubits/update_student_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsTable extends StatefulWidget {
  final List<Map<String, dynamic>> details;
  final String unitId;
  const DetailsTable({super.key, required this.details, required this.unitId});

  @override
  State<DetailsTable> createState() => _DetailsTableState();
}

class _DetailsTableState extends State<DetailsTable> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usnController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();

  void _deleteStudent(String unitID, String studentUnitID, String studentID) {
    BlocProvider.of<DeleteStudentCubit>(
      context,
    ).deleteStudent(unitID, studentUnitID, studentID);
  }

  void _updateStudent(
    String studentID,
    String unitID,
    String name,
    String usn,
    String branch,
  ) {
    BlocProvider.of<UpdateStudentCubit>(
      context,
    ).updateStudent(unitID, studentID, name, usn, branch);
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: AppColors.darkGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: {3: FixedColumnWidth(180), 4: FixedColumnWidth(140)},
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
            TableCellHeader(title: "Branch"),
            TableCellHeader(title: "Tools"),
            TableCellHeader(title: "Logs"),
          ],
        ),
        ...List.generate(widget.details.length, (index) {
          return TableRow(
            children: [
              TableCellElements(title: widget.details[index]["student_name"]),
              TableCellElements(title: widget.details[index]["student_usn"]),
              TableCellElements(title: widget.details[index]["department"]),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          _nameController.text =
                              widget.details[index]["student_name"];
                          _usnController.text =
                              widget.details[index]["student_usn"];
                          _branchController.text =
                              widget.details[index]["department"];
                          showDialog(
                            context: context,
                            builder:
                                (context) => Dialog(
                                  backgroundColor: AppColors.white,
                                  child: CustomUpdateDialog(
                                    nameController: _nameController,
                                    usnController: _usnController,
                                    branchController: _branchController,
                                    onCancelPressed: () {
                                      Navigator.pop(context);
                                    },
                                    onDonePressed: () {
                                      _updateStudent(
                                        widget.details[index]["student_id"],
                                        widget.unitId,
                                        _nameController.text,
                                        _usnController.text,
                                        _branchController.text,
                                      );
                                    },
                                  ),
                                ),
                          );
                        },
                        icon: Icon(Icons.edit, color: AppColors.blue),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => Dialog(
                                  backgroundColor: AppColors.white,
                                  child: CustomDialog(
                                    title: "Delete",
                                    subTitle: "Do you Really Want to Delete.",
                                    onDonePressed: () {
                                      _deleteStudent(
                                        widget.unitId,
                                        widget
                                            .details[index]["student_unit_id"],
                                        widget.details[index]["student_id"],
                                      );
                                    },
                                    onCancelPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                          );
                        },
                        icon: Icon(Icons.delete, color: AppColors.redColor),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "/logs",
                      arguments: DetailsArgs(
                        studentId: widget.details[index]["student_id"],
                        studentName: widget.details[index]["student_name"],
                        studentUsn: widget.details[index]["student_usn"],
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.exit_to_app_rounded,
                    size: 30,
                    color: AppColors.blue,
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
