import 'package:metrix/core/common/widgets/custom_app_bar.dart';
import 'package:metrix/core/common/widgets/custom_elevated_button.dart';
import 'package:metrix/core/common/widgets/custom_snack_bar.dart';
import 'package:metrix/core/common/widgets/custom_time_field.dart';
import 'package:metrix/core/theme/app_colors.dart';
import 'package:metrix/features/student_attendance_time/bloc/time_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentAttendanceTimeSettingPage extends StatefulWidget {
  const StudentAttendanceTimeSettingPage({super.key});

  @override
  State<StudentAttendanceTimeSettingPage> createState() =>
      _StudentAttendanceTimeSettingPageState();
}

class _StudentAttendanceTimeSettingPageState
    extends State<StudentAttendanceTimeSettingPage> {
  final TextEditingController _morningStartController = TextEditingController();
  final TextEditingController _morningEndController = TextEditingController();
  final TextEditingController _afternoonStartController =
      TextEditingController();
  final TextEditingController _afternoonEndController = TextEditingController();
  final TextEditingController _eveningStartController = TextEditingController();
  final TextEditingController _eveningEndController = TextEditingController();

  @override
  void dispose() {
    _morningStartController.dispose();
    _morningEndController.dispose();
    _afternoonStartController.dispose();
    _afternoonEndController.dispose();
    _eveningStartController.dispose();
    _eveningEndController.dispose();
    super.dispose();
  }

  void _clear() {
    _morningStartController.clear();
    _morningEndController.clear();
    _afternoonStartController.clear();
    _afternoonEndController.clear();
    _eveningStartController.clear();
    _eveningEndController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TimeBloc, TimeState>(
      listener: (context, state) {
        if (state is SetTimeSuccessState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(CustomSnackBar(message: state.message).build(context));
          Navigator.pushReplacementNamed(context, "/time");
        }
        if (state is SetTimeFailureState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(CustomSnackBar(message: state.message).build(context));
        }
      },
      child: Scaffold(
        appBar:
            CustomAppBar(
              onPressed: () {
                _clear();
              },
              title: "Time Setting",
            ).buildCustomAppBar(),
        body: Center(
          child: Card(
            elevation: 100,
            shadowColor: AppColors.moderateBlue,
            child: SizedBox(
              width: 400,
              height: 620,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.watch_later_rounded,
                      size: 100,
                      color: AppColors.blue,
                    ),
                    SizedBox(height: 20),
                    CustomTimePickerField(
                      timeController: _morningStartController,
                      hint: "Morning Start Time",
                    ),
                    SizedBox(height: 20),
                    CustomTimePickerField(
                      timeController: _morningEndController,
                      hint: "Morning End Time",
                    ),
                    SizedBox(height: 20),
                    CustomTimePickerField(
                      timeController: _afternoonStartController,
                      hint: "Afternoon Start Time",
                    ),
                    SizedBox(height: 20),
                    CustomTimePickerField(
                      timeController: _afternoonEndController,
                      hint: "Afternoon End Time",
                    ),
                    SizedBox(height: 20),
                    CustomTimePickerField(
                      timeController: _eveningStartController,
                      hint: "Evening Start Time",
                    ),
                    SizedBox(height: 20),
                    CustomTimePickerField(
                      timeController: _eveningEndController,
                      hint: "Evening End Time",
                    ),
                    SizedBox(height: 20),
                    BlocBuilder<TimeBloc, TimeState>(
                      builder: (context, state) {
                        return CustomElevatedButton(
                          isLoading: state is SetTimeLoadingState,
                          onPressed: () {
                            BlocProvider.of<TimeBloc>(context).add(
                              SetTime(
                                morningStart: _morningStartController.text,
                                morningEnd: _morningEndController.text,
                                afternoonStart: _afternoonStartController.text,
                                afternoonEnd: _afternoonEndController.text,
                                eveningStart: _eveningStartController.text,
                                eveningEnd: _eveningEndController.text,
                              ),
                            );
                          },
                          buttonSize: Size(
                            MediaQuery.of(context).size.width,
                            55,
                          ),
                          buttonText: "Set Time",
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
