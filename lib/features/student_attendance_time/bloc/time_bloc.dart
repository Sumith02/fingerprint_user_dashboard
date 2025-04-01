import 'dart:convert';

import 'package:metrix/core/constants/http_headers.dart';
import 'package:metrix/core/constants/http_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

part 'time_event.dart';
part 'time_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  TimeBloc() : super(TimeInitial()) {
    on<SetTime>(_setTime);
  }

  Future<void> _setTime(SetTime event, Emitter<TimeState> emit) async {
    try {
      emit(SetTimeLoadingState());

      final box = await Hive.openBox("user_details");
      final String? userId = box.get("user_id");
      await box.close();

      if (event.morningStart.isEmpty ||
          event.afternoonStart.isEmpty ||
          event.afternoonEnd.isEmpty ||
          event.morningEnd.isEmpty ||
          event.eveningStart.isEmpty ||
          event.eveningEnd.isEmpty) {
        emit(SetTimeFailureState(message: "please enter all the required fields."));
        return;
      }

      if (userId == null) {
        emit(SetTimeFailureState(message: "invalid user id please logout and login again."));
        return;
      }

      final jsonBody = jsonEncode({
        "morning_start_time": formatTimeToHHMM(event.morningStart.trim()),
        "morning_end_time": formatTimeToHHMM(event.morningEnd.trim()),
        "afternoon_start_time":formatTimeToHHMM(event.afternoonStart.trim()),
        "afternoon_end_time": formatTimeToHHMM(event.afternoonEnd.trim()),
        "evening_start_time": formatTimeToHHMM(event.eveningStart.trim()),
        "evening_end_time": formatTimeToHHMM(event.eveningEnd.trim()),
        "user_id": userId.trim(),
      });

      final jsonResponse = await http.post(
        Uri.parse(HttpRoutes.setTime),
        body: jsonBody,
        headers: HttpHead.jsonHeaders,
      );

      final response = jsonDecode(jsonResponse.body);

      if (jsonResponse.statusCode != 200) {
        emit(SetTimeFailureState(message: response["error"]));
        return;
      }
      
      emit(SetTimeSuccessState(message: "Time setting successful."));
    } catch (e) {
      emit(SetTimeFailureState(message: "Unable to process the request."));
    }
  }
  String formatTimeToHHMM(String time) {
  final format = DateFormat("hh:mm a");
  DateTime parsedTime = format.parse(time);
  return DateFormat("HH:mm").format(parsedTime);
}
}
