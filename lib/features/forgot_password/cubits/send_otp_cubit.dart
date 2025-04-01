import 'dart:convert';

import 'package:metrix/core/constants/http_headers.dart';
import 'package:metrix/core/constants/http_routes.dart';
import 'package:metrix/features/forgot_password/cubits/send_otp_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class SendOtpCubit extends Cubit<SendOtpState> {
  SendOtpCubit() : super(SendOtpInitialState());

  Future<void> sendOtpRequest(String email) async {
    try {
      emit(SendOtpLoadingState());
      if (email.isEmpty) {
        emit(
          SendOtpFailureState(
            message: "please enter a valid email to continue.",
          ),
        );
        return;
      }
      final jsonBody = jsonEncode({"email": email.trim()});
      final jsonResponse = await http.post(
        Uri.parse(HttpRoutes.forgotPassword),
        body: jsonBody,
        headers: HttpHead.jsonHeaders,
      );
      final response = jsonDecode(jsonResponse.body);
      if (jsonResponse.statusCode != 200) {
        emit(SendOtpFailureState(message: response["error"]));
        return;
      }
      emit(SendOtpSuccessState(message: "otp has been sent to given mail id."));
    } catch (e) {
      emit(SendOtpFailureState(message: "unable to process the request."));
    }
  }
}
