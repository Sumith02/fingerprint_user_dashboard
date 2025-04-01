import 'package:metrix/core/common/widgets/custom_app_bar.dart';
import 'package:metrix/core/common/widgets/custom_snack_bar.dart';
import 'package:metrix/core/common/widgets/custom_text_field.dart';
import 'package:metrix/core/common/widgets/error_widget.dart';
import 'package:metrix/core/common/widgets/loading_widget.dart';
import 'package:metrix/core/theme/app_colors.dart';
import 'package:metrix/features/student_details/bloc/details_bloc.dart';
import 'package:metrix/features/student_details/cubits/delete_student_cubit.dart';
import 'package:metrix/features/student_details/cubits/state.dart';
import 'package:metrix/features/student_details/cubits/update_student_cubit.dart';
import 'package:metrix/features/student_details/widgets/details_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentDetailsPage extends StatefulWidget {
  final String unitId;
  const StudentDetailsPage({super.key, required this.unitId});

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DetailsBloc>(
      context,
    ).add(FetchStudentDetails(unitId: widget.unitId));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DeleteStudentCubit, StudentDetailsState>(
          listener: (context, state) {
            if (state is DeleteSuccessState) {
              Navigator.pop(context);
              setState(() {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(CustomSnackBar(message: state.message).build(context));
              });
              BlocProvider.of<DetailsBloc>(
                context,
              ).add(FetchStudentDetails(unitId: widget.unitId));
            }
            if (state is DeleteFailureState) {
              Navigator.pop(context);
              setState(() {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(CustomSnackBar(message: state.message).build(context));
              });
            }
          },
        ),
        BlocListener<UpdateStudentCubit, StudentDetailsState>(
          listener: (context, state) {
            if (state is UpdateStudentSuccessState) {
              Navigator.pop(context);
              setState(() {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(CustomSnackBar(message: state.message).build(context));
              });
              BlocProvider.of<DetailsBloc>(
                context,
              ).add(FetchStudentDetails(unitId: widget.unitId));
            }
            if (state is UpdateStudentFailureState) {
              Navigator.pop(context);
              setState(() {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(CustomSnackBar(message: state.message).build(context));
              });
            }
          },
        ),
      ],
      child: Scaffold(
        appBar:
            CustomAppBar(
              onPressed: () {
                BlocProvider.of<DetailsBloc>(
                  context,
                ).add(FetchStudentDetails(unitId: widget.unitId));
              },
              title: "Details",
            ).buildCustomAppBar(),
        body: Padding(
          padding: EdgeInsets.all(40),
          child: BlocBuilder<DetailsBloc, DetailsState>(
            builder: (context, state) {
              if (state is FetchStudentDetailsLoadingState) {
                return LoadingWidget();
              } else if (state is FetchStudentDetailsFailureState) {
                return CustomErrorWidget(
                  errorMessage: state.message,
                  onPressed: () {
                    BlocProvider.of<DetailsBloc>(
                      context,
                    ).add(FetchStudentDetails(unitId: widget.unitId));
                  },
                );
              } else if (state is FetchStudentDetailsSuccessState) {
                final students = state.details;
                final query = _searchController.text.toLowerCase();
                final filteredStudents =
                    students.where((student) {
                      final name = student["student_name"].toLowerCase();
                      return name.contains(query);
                    }).toList();
                return SingleChildScrollView(
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
                                  "Student Details",
                                  style: GoogleFonts.poppins(
                                    color: AppColors.black,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Student details can be Modified using tools.",
                                  style: GoogleFonts.poppins(
                                    color: AppColors.darkGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              width: 300,
                              child: CustomTextField(
                                onChanged: (p0) {
                                  setState(() {});
                                },
                                controller: _searchController,
                                hintText: "Search...",
                                icon: Icons.search_rounded,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      DetailsTable(
                        details: filteredStudents,
                        unitId: widget.unitId,
                      ),
                    ],
                  ),
                );
              }
              return LoadingWidget();
            },
          ),
        ),
      ),
    );
  }
}
