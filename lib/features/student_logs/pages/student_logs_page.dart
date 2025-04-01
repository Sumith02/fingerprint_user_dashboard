import 'package:metrix/core/common/widgets/custom_app_bar.dart';
import 'package:metrix/core/common/widgets/error_widget.dart';
import 'package:metrix/core/common/widgets/loading_widget.dart';
import 'package:metrix/core/theme/app_colors.dart';
import 'package:metrix/features/student_logs/bloc/logs_bloc.dart';
import 'package:metrix/features/student_logs/widgets/logs_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentLogsPage extends StatefulWidget {
  final String studentId;
  final String studentName;
  final String studentUsn;
  const StudentLogsPage({
    super.key,
    required this.studentId,
    required this.studentName,
    required this.studentUsn,
  });

  @override
  State<StudentLogsPage> createState() => _StudentLogsPageState();
}

class _StudentLogsPageState extends State<StudentLogsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LogsBloc>(
      context,
    ).add(FetchStudentLogsEvent(studentId: widget.studentId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(
            onPressed: () {
              BlocProvider.of<LogsBloc>(
                context,
              ).add(FetchStudentLogsEvent(studentId: widget.studentId));
            },
            title: "Log's",
          ).buildCustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(40),
        child: BlocBuilder<LogsBloc, LogsState>(
          builder: (context, state) {
            if (state is FetchStudentLogsLoadingState) {
              return LoadingWidget();
            } else if (state is FetchStudentLogsFailureState) {
              return CustomErrorWidget(
                errorMessage: state.message,
                onPressed: () {
                  BlocProvider.of<LogsBloc>(
                    context,
                  ).add(FetchStudentLogsEvent(studentId: widget.studentId));
                },
              );
            } else if (state is FetchStudentLogsSuccessState) {
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
                                "Student Log's",
                                style: GoogleFonts.poppins(
                                  color: AppColors.black,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Student Log's can be Verified with Dates.",
                                style: GoogleFonts.poppins(
                                  color: AppColors.darkGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    LogsTable(
                      logs: state.logs,
                      name: widget.studentName,
                      usn: widget.studentUsn,
                    ),
                  ],
                ),
              );
            }
            return LoadingWidget();
          },
        ),
      ),
    );
  }
}
