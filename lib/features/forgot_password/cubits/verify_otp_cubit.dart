import 'dart:convert';

import 'package:metrix/core/constants/http_headers.dart';
import 'package:metrix/core/constants/http_routes.dart';
import 'package:metrix/features/forgot_password/cubits/verify_otp_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit() : super(VerifyOtpInitialState());

  Future<void> verifyOtp(String email, String otp) async {
    try {
      emit(VerifyOtpLoadingState());
      if (email.isEmpty || otp.isEmpty) {
        emit(VerifyOtpFailureState(message: "enter valid otp and email."));
        return;
      }
      final jsonBody = jsonEncode({"email": email.trim(), "otp": otp.trim()});
      final jsonResponse = await http.post(
        Uri.parse(HttpRoutes.verifyOtp),
        body: jsonBody,
        headers: HttpHead.jsonHeaders,
      );
      final response = jsonDecode(jsonResponse.body);
      if (jsonResponse.statusCode != 200) {
        emit(VerifyOtpFailureState(message: response["error"]));
        return;
      }
      final box = await Hive.openBox("user_details");
      await box.put("user_id",response["user_id"]);
      await box.close();
      emit(VerifyOtpSuccessState(message: "otp verification successfull."));
    } catch (e) {
      emit(VerifyOtpFailureState(message: "unable to process the request."));
    }
  }
}
