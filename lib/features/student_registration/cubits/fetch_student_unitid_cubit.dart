import 'dart:convert';

import 'package:metrix/core/constants/http_routes.dart';
import 'package:metrix/features/student_registration/cubits/student_unit_id_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class FetchStudentUnitidCubit extends Cubit<FetchStudentUnitIDCubitState> {
  FetchStudentUnitidCubit() : super(FetchStudentUnitIDCubitInitialState());

  Future<void> fetchStudentUnitid(String unitId) async {
    try {
      emit(FetchStudentUnitIDLoadingState());
      final jsonResponse = await http.get(
        Uri.parse("${HttpRoutes.getStudentUnitID}/$unitId"),
        headers: {"Content-Type": "application/json"},
      );
      final response = jsonDecode(jsonResponse.body);
      if (response == null) {
        emit(
          FetchStudentUnitIDFailureState(message: "no response from server."),
        );
        return;
      }
      if (jsonResponse.statusCode != 200) {
        emit(FetchStudentUnitIDFailureState(message: response["error"]));
        return;
      }
      List<String> generated = List.generate(257, (i) => "$i");
      generated.remove("0");
      if (response['student_unit_ids'] == null) {
        emit(FetchStudentUnitIDSuccessState(studentUnitID: generated));
        return;
      }
      for (var i in response['student_unit_ids']) {
        String existing = i;
        generated.remove(existing);
      }
      emit(FetchStudentUnitIDSuccessState(studentUnitID: generated));
    } catch (e) {
      emit(
        FetchStudentUnitIDFailureState(
          message: "error in data format recived.",
        ),
      );
    }
  }
}
