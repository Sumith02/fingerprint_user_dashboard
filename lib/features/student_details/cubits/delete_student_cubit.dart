import 'dart:convert';

import 'package:metrix/core/constants/http_routes.dart';
import 'package:metrix/features/student_details/cubits/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class DeleteStudentCubit extends Cubit<StudentDetailsState> {
  DeleteStudentCubit() : super(StudentDetailsInitialState());

  Future<void> deleteStudent(
    String unitID,
    String studentUnitID,
    String studentID,
  ) async {
    if (unitID.isEmpty || studentID.isEmpty || studentUnitID.isEmpty) {
      emit(DeleteFailureState(message: "Unable to Delete Values are Empty."));
    }
    final jsonBody = jsonEncode({
      "unit_id": unitID,
      "student_unit_id": studentUnitID,
      "student_id": studentID,
    });
    final jsonResponse = await http.post(
      Uri.parse(HttpRoutes.deleteStudent),
      body: jsonBody,
      headers: {"Content-Type": "application/json"},
    );
    final response = jsonDecode(jsonResponse.body);
    if (jsonResponse.statusCode != 200) {
      emit(DeleteFailureState(message: response["error"]));
      return;
    }
    emit(DeleteSuccessState(message: "Student Deleted Successfully"));
  }
}
