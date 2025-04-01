import 'dart:convert';

import 'package:metrix/core/constants/http_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegisterStudentEvent>(_regesterStudent);
  }
  Future<void> _regesterStudent(
    RegisterStudentEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    try {
      emit(RegisterStudentLoadingState());
      final requestBody = jsonEncode({
        "student_unit_id": event.studentUnitId,
        "unit_id": event.unitId,
        "student_name": event.studentName,
        "student_usn": event.studentUSN,
        "department": event.studentBranch,
        "fingerprint_data": event.fingerprintData,
      });
      final jsonResponse = await http.post(
        Uri.parse(HttpRoutes.createStudent),
        body: requestBody,
        headers: {"Content-Type": "application/json"},
      );
      final response = jsonDecode(jsonResponse.body);
      if (response == null) {
        emit(
          RegisterStudentFailureState(
            message: "Error occured while getting response.",
          ),
        );
        return;
      }
      if (jsonResponse.statusCode != 200) {
        emit(RegisterStudentFailureState(message: response["message"]));
        return;
      }
      emit(
        RegisterStudentSuccessState(
          message: "Student Registration Successfull.",
        ),
      );
    } catch (e) {
      emit(RegisterStudentFailureState(message: "An Exception Occured."));
    }
  }
}
