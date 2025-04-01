import 'package:metrix/core/common/cubits/fetch_unit_cubit_state.dart';
import 'package:metrix/core/common/cubits/fetch_units_cubit.dart';
import 'package:metrix/core/common/widgets/custom_app_bar.dart';
import 'package:metrix/core/common/widgets/custom_drop_down.dart';
import 'package:metrix/core/common/widgets/custom_elevated_button.dart';
import 'package:metrix/core/common/widgets/custom_snack_bar.dart';
import 'package:metrix/core/common/widgets/custom_text_field.dart';
import 'package:metrix/core/theme/app_colors.dart';
import 'package:metrix/features/student_registration/bloc/fingerprint_scanner_bloc.dart';
import 'package:metrix/features/student_registration/bloc/registration_bloc.dart';
import 'package:metrix/features/student_registration/bloc/verification_bloc.dart';
import 'package:metrix/features/student_registration/cubits/fetch_ports_cubit.dart';
import 'package:metrix/features/student_registration/cubits/fetch_student_unitid_cubit.dart';
import 'package:metrix/features/student_registration/cubits/port_state.dart';
import 'package:metrix/features/student_registration/cubits/student_unit_id_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usnController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _unitIdController = TextEditingController();
  final TextEditingController _studentUnitIdController =
      TextEditingController();
  final TextEditingController _fingerprintDataController =
      TextEditingController();
  final TextEditingController _portController = TextEditingController();
  bool isVerified = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    BlocProvider.of<FetchUnitIDCubit>(context).fetchMachines();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usnController.dispose();
    _branchController.dispose();
    _unitIdController.dispose();
    _studentUnitIdController.dispose();
    _portController.dispose();
    _animationController.dispose();
    _fingerprintDataController.dispose();
    super.dispose();
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
        BlocListener<FetchPortsCubit, FetchPortsCubitState>(
          listener: (context, state) {
            if (state is FetchPortsFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(message: state.message).build(context),
              );
            }
          },
        ),
        BlocListener<FetchStudentUnitidCubit, FetchStudentUnitIDCubitState>(
          listener: (context, state) {
            if (state is FetchStudentUnitIDFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(message: state.message).build(context),
              );
            }
          },
        ),
        BlocListener<FingerprintScannerBloc, FingerprintScannerState>(
          listener: (context, state) {
            if (state is FingerprintScannerAckState) {
              setState(() {
                _animationController.value = state.animationDuration;
              });
            }
          },
        ),
        BlocListener<VerificationBloc, VerificationState>(
          listener: (context, state) {
            if (state is VerifyDetailsFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(message: state.message).build(context),
              );
            }
            if (state is VerifyDetailsSuccessState) {
              setState(() {
                isVerified = true;
              });
            }
          },
        ),
        BlocListener<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state is RegisterStudentFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(message: state.message).build(context),
              );
            }
            if (state is RegisterStudentSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(message: state.message).build(context),
              );
              Navigator.pushReplacementNamed(context, "/register");
            }
          },
        ),
      ],
      child: Scaffold(
        appBar:
            CustomAppBar(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/register");
              },
              title: "Registration",
            ).buildCustomAppBar(),
        body: Center(
          child: SizedBox(
            width: 820,
            height: 600,
            child: Card(
              elevation: 100,
              shadowColor: AppColors.moderateBlue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 400,
                    height: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Register Student",
                            style: GoogleFonts.poppins(
                              color: AppColors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            controller: _nameController,
                            hintText: "Student Name",
                            icon: Icons.person,
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            controller: _usnController,
                            hintText: "Student USN",
                            icon: Icons.abc_rounded,
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            controller: _branchController,
                            hintText: "Student Branch",
                            icon: Icons.account_balance_rounded,
                          ),
                          SizedBox(height: 20),
                          BlocBuilder<FetchUnitIDCubit, FetchUnitIDState>(
                            builder: (context, state) {
                              if (state is FetchUnitIDLoadingState) {
                                return Skeletonizer(
                                  effect: SoldColorEffect(
                                    color: AppColors.moderateBlue,
                                  ),
                                  enabled: true,
                                  child: CustomDropDownMenu(
                                    data: [],
                                    onChanged: (value) {
                                      _unitIdController.text = value!;
                                      BlocProvider.of<FetchStudentUnitidCubit>(
                                        context,
                                      ).fetchStudentUnitid(value);
                                    },
                                    hint: "Select Biometric Device",
                                  ),
                                );
                              }
                              if (state is FetchUnitIDSuccessState) {
                                return CustomDropDownMenu(
                                  data: state.units,
                                  onChanged: (value) {
                                    _unitIdController.text = value!;
                                    BlocProvider.of<FetchStudentUnitidCubit>(
                                      context,
                                    ).fetchStudentUnitid(value);
                                  },
                                  hint: "Select Biometric Device",
                                );
                              }
                              return Skeletonizer(
                                effect: SoldColorEffect(
                                  color: AppColors.moderateBlue,
                                ),
                                enabled: true,
                                child: CustomDropDownMenu(
                                  data: [],
                                  onChanged: (value) {
                                    _unitIdController.text = value!;
                                    BlocProvider.of<FetchStudentUnitidCubit>(
                                      context,
                                    ).fetchStudentUnitid(value);
                                  },
                                  hint: "Select Biometric Device",
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          BlocBuilder<
                            FetchStudentUnitidCubit,
                            FetchStudentUnitIDCubitState
                          >(
                            builder: (context, state) {
                              if (state is FetchStudentUnitIDLoadingState) {
                                return Skeletonizer(
                                  effect: SoldColorEffect(
                                    color: AppColors.moderateBlue,
                                  ),
                                  enabled: true,
                                  child: CustomDropDownMenu(
                                    data: [],
                                    onChanged: (value) {
                                      _studentUnitIdController.text = value!;
                                      BlocProvider.of<FetchPortsCubit>(
                                        context,
                                      ).fetchPorts();
                                    },
                                    hint: "Select Student No",
                                  ),
                                );
                              }
                              if (state is FetchStudentUnitIDSuccessState) {
                                return CustomDropDownMenu(
                                  data: state.studentUnitID,
                                  onChanged: (value) {
                                    _studentUnitIdController.text = value!;
                                    BlocProvider.of<FetchPortsCubit>(
                                      context,
                                    ).fetchPorts();
                                  },
                                  hint: "Select Student No",
                                );
                              }
                              return Skeletonizer(
                                effect: SoldColorEffect(
                                  color: AppColors.moderateBlue,
                                ),
                                enabled: true,
                                child: CustomDropDownMenu(
                                  data: [],
                                  onChanged: (value) {
                                    _studentUnitIdController.text = value!;
                                    BlocProvider.of<FetchPortsCubit>(
                                      context,
                                    ).fetchPorts();
                                  },
                                  hint: "Select Student No",
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          BlocBuilder<FetchPortsCubit, FetchPortsCubitState>(
                            builder: (context, state) {
                              if (state is FetchPortsLoadingState) {
                                return Skeletonizer(
                                  effect: SoldColorEffect(
                                    color: AppColors.moderateBlue,
                                  ),
                                  enabled: true,
                                  child: CustomDropDownMenu(
                                    data: [],
                                    onChanged: (value) {
                                      _portController.text = value!;
                                      BlocProvider.of<FingerprintScannerBloc>(
                                        context,
                                      ).add(
                                        ActivateFingerprintScannerEvent(
                                          port: value,
                                        ),
                                      );
                                    },
                                    hint: "Select Port",
                                  ),
                                );
                              }
                              if (state is FetchPortSuccessState) {
                                return CustomDropDownMenu(
                                  data: state.ports,
                                  onChanged: (value) {
                                    _portController.text = value!;
                                    BlocProvider.of<FingerprintScannerBloc>(
                                      context,
                                    ).add(
                                      ActivateFingerprintScannerEvent(
                                        port: value,
                                      ),
                                    );
                                  },
                                  hint: "Select Port",
                                );
                              }
                              return Skeletonizer(
                                effect: SoldColorEffect(
                                  color: AppColors.moderateBlue,
                                ),
                                enabled: true,
                                child: CustomDropDownMenu(
                                  data: [],
                                  onChanged: (value) {
                                    _portController.text = value!;
                                    BlocProvider.of<FingerprintScannerBloc>(
                                      context,
                                    ).add(
                                      ActivateFingerprintScannerEvent(
                                        port: value,
                                      ),
                                    );
                                  },
                                  hint: "Select Port",
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    height: 600,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocBuilder<
                            FingerprintScannerBloc,
                            FingerprintScannerState
                          >(
                            builder: (context, state) {
                              if (state is FingerprintScannerAckState) {
                                return Text(
                                  state.message,
                                  style: GoogleFonts.poppins(
                                    color: AppColors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              }
                              if (state is FingerprintScanSuccessState) {
                                _fingerprintDataController.text =
                                    state.fingerprintData;
                                return Text(
                                  "Successfully Taken Fingerprint",
                                  style: GoogleFonts.poppins(
                                    color: AppColors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              }
                              if (state is FingerprintScannerFailureState) {
                                return Text(
                                  state.message,
                                  style: GoogleFonts.poppins(
                                    color: AppColors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              }
                              return Text(
                                "Fingerprint Scanner",
                                style: GoogleFonts.poppins(
                                  color: AppColors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                          BlocBuilder<
                            FingerprintScannerBloc,
                            FingerprintScannerState
                          >(
                            builder: (context, state) {
                              return LottieBuilder.asset(
                                "assets/finger_animation.json",
                                width: 300,
                                controller: _animationController,
                              );
                            },
                          ),
                          BlocBuilder<VerificationBloc, VerificationState>(
                            builder: (context, state) {
                              return CustomElevatedButton(
                                isLoading: state is VerifyDetailsLoadingState,
                                onPressed:
                                    isVerified
                                        ? null
                                        : () {
                                          BlocProvider.of<VerificationBloc>(
                                            context,
                                          ).add(
                                            VerifyDetailsEvent(
                                              studentName: _nameController.text,
                                              studentUSN: _usnController.text,
                                              studentBranch:
                                                  _branchController.text,
                                              unitId: _unitIdController.text,
                                              studentUnitId:
                                                  _studentUnitIdController.text,
                                              fingerprintData:
                                                  _fingerprintDataController
                                                      .text,
                                            ),
                                          );
                                        },
                                buttonSize: Size(
                                  MediaQuery.of(context).size.width,
                                  50,
                                ),
                                buttonText: "Verify",
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          BlocBuilder<RegistrationBloc, RegistrationState>(
                            builder: (context, state) {
                              return CustomElevatedButton(
                                isLoading: state is RegisterStudentLoadingState,
                                onPressed:
                                    isVerified
                                        ? () {
                                          BlocProvider.of<RegistrationBloc>(
                                            context,
                                          ).add(
                                            RegisterStudentEvent(
                                              studentName: _nameController.text,
                                              studentUSN: _usnController.text,
                                              studentBranch:
                                                  _branchController.text,
                                              unitId: _unitIdController.text,
                                              studentUnitId:
                                                  _studentUnitIdController.text,
                                              fingerprintData:
                                                  _fingerprintDataController
                                                      .text,
                                            ),
                                          );
                                        }
                                        : null,
                                buttonSize: Size(
                                  MediaQuery.of(context).size.width,
                                  50,
                                ),
                                buttonText: "Submit",
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
