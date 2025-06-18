import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:metrix/core/constants/http_headers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrix/core/constants/http_routes.dart';

part 'download_excel_event.dart';
part 'download_excel_state.dart';

class DownloadExcelBloc extends Bloc<DownloadExcelEvent, DownloadExcelState> {
  DownloadExcelBloc() : super(DownloadExcelInitial()) {
    on<DownloadAttExcel>(_downloadExcel);
  }

  Future<void> _downloadExcel(
    DownloadAttExcel event,
    Emitter<DownloadExcelState> emit,
  ) async {
    try {
      emit(DownloadAttExcelLoadingState());

      if (event.unitId.isEmpty ||
          event.startDate.isEmpty ||
          event.endDate.isEmpty) {
        emit(DownloadAttExcelFailureState(message: "Enter all the Details."));
        return;
      }

      final box = await Hive.openBox("user_details");
      final String? userId = box.get("user_id");
      await box.close();

      if (userId == null) {
        emit(
          DownloadAttExcelFailureState(
            message: "Invalid user ID. Please logout and login again.",
          ),
        );
        return;
      }
      final jsonResponse = await http.post(
        Uri.parse(HttpRoutes.excelDownload),
        headers: HttpHead.jsonHeaders,
        body: jsonEncode({
          "unit_id": event.unitId,
          "user_id": userId,
          "slot": event.slot,
          "start_date": convertDateFormat(event.startDate),
          "end_date": convertDateFormat(event.endDate),
        }),
      );


      print("Sending request to ${HttpRoutes.excelDownload}");
      print("Request Headers: ${HttpHead.jsonHeaders}");
      print("Request Body: ${jsonEncode({
        "unit_id": event.unitId,
        "user_id": userId,  
        "slot": event.slot,
        "start_date": convertDateFormat(event.startDate),
        "end_date": convertDateFormat(event.endDate),
      })}");


      // Debug print for response
      print("Response Status Code: ${jsonResponse.statusCode}");
      print("Response Body: ${jsonResponse.body}");

      if (jsonResponse.statusCode != 200) {
        emit(
          DownloadAttExcelFailureState(message: "Unable to Download Excel."),
        );
        return;
      }

      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory == null) {
        emit(DownloadAttExcelFailureState(message: "Unable to store Excel."));
        return;
      }

      String filePath =
          "$selectedDirectory/Attendance${event.startDate}_and_${event.endDate}_time_${DateFormat("HHmmss").format(DateTime.now())}.xlsx";

      File file = File(filePath);
      await file.writeAsBytes(jsonResponse.bodyBytes);

      emit(
        DownloadAttExcelSuccessState(
          message: "Download Successful: $filePath",
        ),
      );
    } catch (e, stack) {
      print("Exception occurred: $e");
      print("Stack Trace: $stack");

      emit(
        DownloadAttExcelFailureState(
          message: "Error occurred while downloading Excel.",
        ),
      );
    }
  }

  String convertDateFormat(String date) {
    List<String> parts = date.split('-');
    return '${parts[2]}-${parts[1]}-${parts[0]}';
  }
}
