import 'dart:convert';

import 'package:metrix/core/constants/http_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    on<FetchStudentDetails>(_fetchStudentDetails);
  }
  Future<void> _fetchStudentDetails(
    FetchStudentDetails event,
    Emitter<DetailsState> emit,
  ) async {
    try {
      emit(FetchStudentDetailsLoadingState());
      final jsonResponse = await http.get(
        Uri.parse("${HttpRoutes.fetchStudents}/${event.unitId}"),
        headers: {"Content-Type": "application/json"},
      );
      final response = jsonDecode(jsonResponse.body);
      if (jsonResponse.statusCode != 200) {
        emit(FetchStudentDetailsFailureState(message: "No Student's Exist."));
        return;
      }
      if (response["students"] == null) {
        emit(FetchStudentDetailsFailureState(message: "No Student's Exist."));
        return;
      }
      final List<Map<String, dynamic>> details =
          List<Map<String, dynamic>>.from(response["students"]);
      emit(FetchStudentDetailsSuccessState(details: details));
    } catch (e) {
      emit(
        FetchStudentDetailsFailureState(
          message: "Error occured while Fetching the data.",
        ),
      );
    }
  }
}
