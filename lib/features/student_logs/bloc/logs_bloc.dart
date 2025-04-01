import 'dart:convert';

import 'package:metrix/core/constants/http_headers.dart';
import 'package:metrix/core/constants/http_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'logs_event.dart';
part 'logs_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  LogsBloc() : super(LogsInitial()) {
    on<FetchStudentLogsEvent>(_fetchStudentLogs);
  }
  Future<void> _fetchStudentLogs(
    FetchStudentLogsEvent event,
    Emitter<LogsState> emit,
  ) async {
    try {
      emit(FetchStudentLogsLoadingState());
      final jsonResponse = await http.get(
        Uri.parse("${HttpRoutes.fetchStudentLogs}/${event.studentId}"),
        headers: HttpHead.jsonHeaders,
      );
      final response = jsonDecode(jsonResponse.body);
      print(response);
      if (jsonResponse.statusCode != 200) {
        emit(FetchStudentLogsFailureState(message: response["error"]));
        return;
      }
      if (response["logs"] == null) {
        emit(FetchStudentLogsFailureState(message: "No logs to display."));
        return;
      }
      final List<Map<String , dynamic>> logs = List<Map<String , dynamic>>.from(response["logs"]);
      emit(FetchStudentLogsSuccessState(logs: logs));
    } catch (e) {
      emit(FetchStudentLogsFailureState(message: "Error occured while Fetching the data."));
    }
  }
}
