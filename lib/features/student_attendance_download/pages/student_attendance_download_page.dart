import 'package:flutter/services.dart';
import 'package:metrix/core/common/cubits/fetch_unit_cubit_state.dart';
import 'package:metrix/core/common/cubits/fetch_units_cubit.dart';
import 'package:metrix/core/common/widgets/custom_app_bar.dart';
import 'package:metrix/core/common/widgets/custom_date_picker_field.dart';
import 'package:metrix/core/common/widgets/custom_drop_down.dart';
import 'package:metrix/core/common/widgets/custom_elevated_button.dart';
import 'package:metrix/core/common/widgets/custom_snack_bar.dart';
import 'package:metrix/core/theme/app_colors.dart';
import 'package:metrix/features/student_attendance_download/bloc/download_excel_bloc.dart';
import 'package:metrix/features/student_attendance_download/bloc/download_pdf_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StudentAttendanceDownloadPage extends StatefulWidget {
  const StudentAttendanceDownloadPage({super.key});

  @override
  State<StudentAttendanceDownloadPage> createState() =>
      _StudentAttendanceDownloadPageState();
}

class _StudentAttendanceDownloadPageState
    extends State<StudentAttendanceDownloadPage> {
  final TextEditingController _unitIdForPdfController = TextEditingController();
  final TextEditingController _unitIdForExcelController =
      TextEditingController();
  final TextEditingController _startDateForPdfController =
      TextEditingController();
  final TextEditingController _startDateForExcelController =
      TextEditingController();
  final TextEditingController _endDateForPdfController =
      TextEditingController();
  final TextEditingController _endDateForExcelController =
      TextEditingController();
  final TextEditingController _pdfSlotController = TextEditingController();
  final TextEditingController _excelSlotController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<FetchUnitIDCubit>(context).fetchMachines();
    super.initState();
  }

  @override
  void dispose() {
    _unitIdForPdfController.dispose();
    _unitIdForExcelController.dispose();
    _startDateForPdfController.dispose();
    _startDateForExcelController.dispose();
    _endDateForPdfController.dispose();
    _endDateForExcelController.dispose();
    _pdfSlotController.dispose();
    _excelSlotController.dispose();
    super.dispose();
  }

  void _clear() {
    _startDateForExcelController.clear();
    _startDateForPdfController.clear();
    _endDateForExcelController.clear();
    _endDateForPdfController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FetchUnitIDCubit, FetchUnitIDState>(
          listener: (context, state) {
            if (state is FetchUnitIDFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(message: state.message).build(context),
              );
            }
          },
        ),
        BlocListener<DownloadPdfBloc, DownloadPdfState>(
          listener: (context, state) {
            if (state is DownloadAttPdfFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(message: state.message).build(context),
              );
            }
            if (state is DownloadAttPdfSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(message: state.message).build(context),
              );
            }
          },
        ),

        BlocListener<DownloadExcelBloc, DownloadExcelState>(
          listener: (context, state) {
            if (state is DownloadAttExcelFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(message: state.message).build(context),
              );
            }
            if (state is DownloadAttExcelSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(message: state.message).build(context),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar:
            CustomAppBar(
              onPressed: () {
                BlocProvider.of<FetchUnitIDCubit>(context).fetchMachines();
                _clear();
              },
              title: "Download Attendance",
            ).buildCustomAppBar(),
        body: Center(
          child: Card(
            elevation: 100,
            shadowColor: AppColors.moderateBlue,
            child: SizedBox(
              width: 800,
              height: 500,
              child: Row(
                children: [
                  SizedBox(
                    width: 400,
                    height: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.picture_as_pdf_outlined,
                            color: AppColors.blue,
                            size: 100,
                          ),
                          SizedBox(height: 40),
                          BlocBuilder<FetchUnitIDCubit, FetchUnitIDState>(
                            builder: (context, state) {
                              if (state is FetchUnitIDLoadingState) {
                                return Skeletonizer(
                                  enabled: true,
                                  effect: SoldColorEffect(
                                    color: AppColors.moderateBlue,
                                  ),
                                  child: CustomDropDownMenu(
                                    data: [],
                                    onChanged: (value) {
                                      _unitIdForPdfController.text = value!;
                                    },
                                    hint: "Select Machine",
                                  ),
                                );
                              }
                              if (state is FetchUnitIDSuccessState) {
                                return CustomDropDownMenu(
                                  data: state.units,
                                  onChanged: (value) {
                                    _unitIdForPdfController.text = value!;
                                  },
                                  hint: "Select Machine",
                                );
                              }
                              return Skeletonizer(
                                enabled: true,
                                effect: SoldColorEffect(
                                  color: AppColors.moderateBlue,
                                ),
                                child: CustomDropDownMenu(
                                  data: [],
                                  onChanged: (value) {
                                    _unitIdForPdfController.text = value!;
                                  },
                                  hint: "Select Machine",
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          CustomDatePickerField(
                            dateController: _startDateForPdfController,
                            hint: "Start Date",
                          ),
                          SizedBox(height: 20),
                          CustomDatePickerField(
                            dateController: _endDateForPdfController,
                            hint: "End Date",
                          ),
                          SizedBox(height: 20),
                          CustomDropDownMenu(
                            data: ["morning", "afternoon", "full"],
                            onChanged: (value) {
                              _pdfSlotController.text = value!;
                            },
                            hint: "Slot",
                          ),
                          SizedBox(height: 20),
                          BlocBuilder<DownloadPdfBloc, DownloadPdfState>(
                            builder: (context, state) {
                              return CustomElevatedButton(
                                isLoading: state is DownlaodAttPdfLoadingState,
                                onPressed: () {
                                  BlocProvider.of<DownloadPdfBloc>(context).add(
                                    DownloadAttPdfEvent(
                                      unitId: _unitIdForPdfController.text,
                                      startDate:
                                          _startDateForPdfController.text,
                                      endDate: _endDateForPdfController.text,
                                      slot: _pdfSlotController.text,
                                    ),
                                  );
                                },
                                buttonSize: Size(
                                  MediaQuery.of(context).size.width,
                                  55,
                                ),
                                buttonText: "Download PDF",
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    height: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.backup_table_rounded,
                            color: AppColors.blue,
                            size: 100,
                          ),
                          SizedBox(height: 40),
                          BlocBuilder<FetchUnitIDCubit, FetchUnitIDState>(
                            builder: (context, state) {
                              if (state is FetchUnitIDLoadingState) {
                                return Skeletonizer(
                                  enabled: true,
                                  effect: SoldColorEffect(
                                    color: AppColors.moderateBlue,
                                  ),
                                  child: CustomDropDownMenu(
                                    data: [],
                                    onChanged: (value) {
                                      _unitIdForExcelController.text = value!;
                                    },
                                    hint: "Select Machine",
                                  ),
                                );
                              }
                              if (state is FetchUnitIDSuccessState) {
                                return CustomDropDownMenu(
                                  data: state.units,
                                  onChanged: (value) {
                                    _unitIdForExcelController.text = value!;
                                  },
                                  hint: "Select Machine",
                                );
                              }
                              return Skeletonizer(
                                enabled: true,
                                effect: SoldColorEffect(
                                  color: AppColors.moderateBlue,
                                ),
                                child: CustomDropDownMenu(
                                  data: [],
                                  onChanged: (value) {
                                    _unitIdForExcelController.text = value!;
                                  },
                                  hint: "Select Machine",
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          CustomDatePickerField(
                            dateController: _startDateForExcelController,
                            hint: "Start Date",
                          ),
                          SizedBox(height: 20),
                          CustomDatePickerField(
                            dateController: _endDateForExcelController,
                            hint: "End Date",
                          ),
                          SizedBox(height: 20),
                          CustomDropDownMenu(
                            data: ["morning", "afternoon", "full"],
                            onChanged: (value) {
                              _excelSlotController.text = value!;
                            },
                            hint: "Slot",
                          ),
                          SizedBox(height: 20),
                          BlocBuilder<DownloadExcelBloc, DownloadExcelState>(
                            builder: (context, state) {
                              return CustomElevatedButton(
                                isLoading:
                                    state is DownloadAttExcelLoadingState,
                                onPressed: () {
                                  BlocProvider.of<DownloadExcelBloc>(
                                    context,
                                  ).add(
                                    DownloadAttExcel(
                                      slot: _excelSlotController.text,
                                      unitId: _unitIdForExcelController.text,
                                      startDate:
                                          _startDateForExcelController.text,
                                      endDate: _endDateForExcelController.text,
                                    ),
                                  );
                                },
                                buttonSize: Size(
                                  MediaQuery.of(context).size.width,
                                  55,
                                ),
                                buttonText: "Download Excel",
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
