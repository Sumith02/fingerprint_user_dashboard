import 'dart:convert';

import 'package:metrix/core/constants/http_headers.dart';
import 'package:metrix/core/constants/http_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    on<UpdatePassword>(_updatePassword);
  }

  Future<void> _updatePassword(UpdatePassword event, Emitter<ChangePasswordState> emit) async {
    try {
      emit(UpdatePasswordLoadingState());
      final box = await Hive.openBox("user_details");
      final String ? userID = box.get("user_id");
      await box.close();
      if (event.newPassword.isEmpty ||userID!.isEmpty || event.confirmPassword.isEmpty) {
        emit(
          UpdatePasswordFailureState(
            message: "please enter all the required fields.",
          ),
        );
        return;
      }
      if (event.newPassword.trim() != event.confirmPassword.trim()) {
        emit(
          UpdatePasswordFailureState(message: "please make sure the password's are matching."),
        );
        return;
      }
      final jsonBody = jsonEncode({
        "user_id": userID.trim(),
        "password": event.newPassword.trim(),
      });
      final jsonResponse = await http.post(
        Uri.parse(HttpRoutes.changePassword),
        body: jsonBody,
        headers: HttpHead.jsonHeaders,
      );
      final response = jsonDecode(jsonResponse.body);
      if (jsonResponse.statusCode != 200) {
        emit(UpdatePasswordFailureState(message: response["error"]));
        return;
      }
      emit(UpdatePasswordSuccessState(message: response["message"]));
    } catch (e) {
      emit(
        UpdatePasswordFailureState(message: "unable to process the request."),
      );
    }
  }
}
