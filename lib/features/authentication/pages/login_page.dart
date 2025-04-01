import 'package:metrix/core/common/widgets/custom_elevated_button.dart';
import 'package:metrix/core/common/widgets/custom_snack_bar.dart';
import 'package:metrix/core/common/widgets/custom_text_field.dart';
import 'package:metrix/core/theme/app_colors.dart';
import 'package:metrix/features/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text Editing Controllers For Input
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Disposing the Controllers once the page is out of Scope
  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _clear() {
    _userNameController.clear();
    _passwordController.clear();
  }

  // Main Build Function
  @override
  Widget build(BuildContext context) {
    // Authentication Bloc Listner
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        // If login fails this snackbar will be shown
        if (state is LoginFailedState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(CustomSnackBar(message: state.message).build(context));
          _clear();
        }
        // If login is successfull then navigate to home page
        if (state is LoginSuccessState) {
          Navigator.pushReplacementNamed(context, "/home");
        }
      },
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 400,
            height: 400,
            child: Card(
              elevation: 100,
              shadowColor: AppColors.moderateBlue,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Company Logo
                    Image.asset("assets/logo.png", width: 100),
                    SizedBox(height: 40),
                    // Username Text Field
                    CustomTextField(
                      controller: _userNameController,
                      hintText: "Username",
                      icon: Icons.person,
                    ),
                    SizedBox(height: 20),
                    // Password Text Field
                    CustomTextField(
                      controller: _passwordController,
                      hintText: "Password",
                      icon: Icons.lock,
                      isObscureText: true,
                      isPasswordField: true,
                    ),
                    SizedBox(height: 10),
                    // Forgot Password Text
                    Align(
                      alignment: Alignment(1, 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/forgot");
                        },
                        child: Text(
                          "Forgot Password",
                          style: GoogleFonts.poppins(color: AppColors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Login Elevated Button
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        return CustomElevatedButton(
                          isLoading: state is LoginLoadingState,
                          onPressed: () {
                            // A Login Event is Triggered When Button is Clicked
                            BlocProvider.of<AuthenticationBloc>(context).add(
                              LoginEvent(
                                userName: _userNameController.text,
                                password: _passwordController.text,
                              ),
                            );
                          },
                          buttonSize: Size(
                            MediaQuery.of(context).size.width,
                            55,
                          ),
                          buttonText: "Login",
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
