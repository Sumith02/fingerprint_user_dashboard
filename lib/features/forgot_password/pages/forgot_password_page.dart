import 'package:metrix/core/common/widgets/custom_app_bar.dart';
import 'package:metrix/core/common/widgets/custom_elevated_button.dart';
import 'package:metrix/core/common/widgets/custom_snack_bar.dart';
import 'package:metrix/core/common/widgets/custom_text_field.dart';
import 'package:metrix/core/theme/app_colors.dart';
import 'package:metrix/features/forgot_password/cubits/send_otp_cubit.dart';
import 'package:metrix/features/forgot_password/cubits/send_otp_cubit_state.dart';
import 'package:metrix/features/forgot_password/cubits/verify_otp_cubit.dart';
import 'package:metrix/features/forgot_password/cubits/verify_otp_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isOtpFieldUnlocked = false;

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<VerifyOtpCubit, VerifyOtpState>(
          listener: (context, state) {
            if (state is VerifyOtpSuccessState) {
              Navigator.pushReplacementNamed(context, "/password");
            }
            if (state is VerifyOtpFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(message: state.message).build(context),
              );
              _otpController.clear();
            }
          },
        ),
        BlocListener<SendOtpCubit, SendOtpState>(
          listener: (context, state) {
            if (state is SendOtpSuccessState) {
              setState(() {
                _isOtpFieldUnlocked = true;
              });
            }
            if (state is SendOtpFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(message: state.message).build(context),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar:CustomAppBar(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/forgot");
              },
              title: "Forgot Password",
            ).buildCustomAppBar(),
        body: Center(
          child: SizedBox(
            width: 400,
            height: 550,
            child: Card(
              elevation: 100,
              shadowColor: AppColors.moderateBlue,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.device_unknown_rounded,
                      size: 100,
                      color: AppColors.blue,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Password?",
                      style: GoogleFonts.poppins(
                        color: AppColors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      textAlign: TextAlign.center,
                      "Enter your Details to get OTP and Change Password.",
                      style: GoogleFonts.poppins(
                        color: AppColors.darkGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: _emailController,
                      hintText: "Email",
                      icon: Icons.mail_rounded,
                    ),
                    SizedBox(height: 20),
                    BlocBuilder<SendOtpCubit, SendOtpState>(
                      builder: (context, state) {
                        return CustomElevatedButton(
                          isLoading: state is SendOtpLoadingState,
                          onPressed:
                              state is SendOtpSuccessState
                                  ? null
                                  : () {
                                    BlocProvider.of<SendOtpCubit>(
                                      context,
                                    ).sendOtpRequest(_emailController.text);
                                  },
                          buttonSize: Size(
                            MediaQuery.of(context).size.width,
                            55,
                          ),
                          buttonText: "Send OTP",
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      onChanged: (p0) {
                        if (p0.length == 6) {
                          BlocProvider.of<VerifyOtpCubit>(context).verifyOtp(
                            _emailController.text,
                            _otpController.text,
                          );
                        }
                      },
                      controller: _otpController,
                      hintText: "OTP",
                      icon: Icons.access_time_filled_rounded,
                    ),
                    SizedBox(height: 20),
                    BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
                      builder: (context, state) {
                        return CustomElevatedButton(
                          isLoading: state is VerifyOtpLoadingState,
                          onPressed:
                              _isOtpFieldUnlocked
                                  ? () {
                                    BlocProvider.of<VerifyOtpCubit>(
                                      context,
                                    ).verifyOtp(
                                      _emailController.text,
                                      _otpController.text,
                                    );
                                  }
                                  : null,
                          buttonSize: Size(
                            MediaQuery.of(context).size.width,
                            55,
                          ),
                          buttonText: "Verify",
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
