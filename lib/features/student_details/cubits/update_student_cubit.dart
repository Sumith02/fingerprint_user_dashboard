import 'dart:convert';

import 'package:metrix/core/constants/http_routes.dart';
import 'package:metrix/features/student_details/cubits/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class UpdateStudentCubit extends Cubit<StudentDetailsState> {
  UpdateStudentCubit() : super(StudentDetailsInitialState());

  Future<void> updateStudent(
    String unitID,
    String studentID,
    String name,
    String usn,
    String branch,
  ) async {
    if (unitID.isEmpty ||
        studentID.isEmpty ||
        name.isEmpty ||
        usn.isEmpty ||
        branch.isEmpty) {
      emit(
        UpdateStudentFailureState(
          message: "Unable to Update Some Values Entered are Empty.",
        ),
      );
    }
    final jsonBody = jsonEncode({
      "unit_id": unitID,
      "student_id": studentID,
      "student_name": name,
      "student_usn": usn,
      "department": branch,
    });
    final jsonResponse = await http.post(
      Uri.parse(HttpRoutes.updateStudent),
      body: jsonBody,
      headers: {"Content-Type": "application/json"},
    );
    final response = jsonDecode(jsonResponse.body);
    if (jsonResponse.statusCode != 200) {
      emit(UpdateStudentFailureState(message: response["error"]));
      return;
    }
    emit(
      UpdateStudentSuccessState(
        message: "Student Details Updated Successfully",
      ),
    );
  }
}
