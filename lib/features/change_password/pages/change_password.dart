import 'package:metrix/core/common/widgets/custom_app_bar.dart';
import 'package:metrix/core/common/widgets/custom_elevated_button.dart';
import 'package:metrix/core/common/widgets/custom_snack_bar.dart';
import 'package:metrix/core/common/widgets/custom_text_field.dart';
import 'package:metrix/core/theme/app_colors.dart';
import 'package:metrix/features/change_password/bloc/change_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPasswordPage extends StatefulWidget {
  const UserPasswordPage({super.key});

  @override
  State<UserPasswordPage> createState() => _UserPasswordPageState();
}

class _UserPasswordPageState extends State<UserPasswordPage> {

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _clear() {
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is UpdatePasswordSuccessState) {
          _clear();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(CustomSnackBar(message: state.message).build(context));
        }
        if (state is UpdatePasswordFailureState) {
          _clear();
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
              title: "Password",
            ).buildCustomAppBar(),
        body: Center(
          child: SizedBox(
            width: 400,
            height: 500,
            child: Card(
              elevation: 100,
              shadowColor: AppColors.moderateBlue,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.lock, size: 100, color: AppColors.blue),
                    SizedBox(height: 10),
                    Text(
                      "Change Password",
                      style: GoogleFonts.poppins(
                        color: AppColors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "After changing the Password you can only Login with New Password.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: AppColors.darkGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      isObscureText: true,
                      isPasswordField: true,
                      controller: _newPasswordController,
                      hintText: "New Password",
                      icon: Icons.password_rounded,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      isObscureText: true,
                      isPasswordField: true,
                      controller: _confirmPasswordController,
                      hintText: "Confirm Password",
                      icon: Icons.password_rounded,
                    ),
                    SizedBox(height: 20),
                    BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                      builder: (context, state) {
                        return CustomElevatedButton(
                          isLoading: state is UpdatePasswordLoadingState,
                          onPressed: () {
                            BlocProvider.of<ChangePasswordBloc>(context).add(
                              UpdatePassword(
                                newPassword: _newPasswordController.text,
                                confirmPassword: _confirmPasswordController.text,
                              ),
                            );
                          },
                          buttonSize: Size(
                            MediaQuery.of(context).size.width,
                            55,
                          ),
                          buttonText: "Change Password",
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
