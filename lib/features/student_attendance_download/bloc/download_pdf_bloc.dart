import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:metrix/core/constants/http_headers.dart';
import 'package:metrix/core/constants/http_routes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
part 'download_pdf_event.dart';
part 'download_pdf_state.dart';

class DownloadPdfBloc extends Bloc<DownloadPdfEvent, DownloadPdfState> {
  DownloadPdfBloc() : super(DownloadPdfInitial()) {
    on<DownloadAttPdfEvent>(_downloadPdf);
  }

  Future<void> _downloadPdf(
    DownloadAttPdfEvent event,
    Emitter<DownloadPdfState> emit,
  ) async {
    try {
      emit(DownlaodAttPdfLoadingState());

      // Debug prints to track field values
      print("📝 Input Debug:");
      print("unitId: '${event.unitId}'");
      print("startDate: '${event.startDate}'");
      print("endDate: '${event.endDate}'");
      print("slot: '${event.slot}'");

      if (event.unitId.isEmpty ||
          event.startDate.isEmpty ||
          event.endDate.isEmpty ||
          event.slot.isEmpty) {
        emit(DownloadAttPdfFailureState(message: "Enter all the Details."));
        return;
      }

      final box = await Hive.openBox("user_details");
      final String? userId = box.get("user_id");
      await box.close();

      if (userId == null) {
        emit(
          DownloadAttPdfFailureState(
            message: "Invalid user ID. Please logout and login again.",
          ),
        );
        return;
      }

      final requestBody = jsonEncode({
        "unit_id": event.unitId.trim(),
        "user_id": userId.trim(),
        "start_date": convertDateFormat(event.startDate.trim()),
        "end_date": convertDateFormat(event.endDate.trim()),
        "slot": event.slot.trim(),
      });

      print("📤 Sending Request Body: $requestBody");

      final jsonResponse = await http.post(
        body: requestBody,
        Uri.parse(HttpRoutes.pdfDownload),
        headers: HttpHead.jsonHeaders,
      );

      print("📥 Status Code: ${jsonResponse.statusCode}");
      print("📥 Response Body: ${jsonResponse.body}");

      if (jsonResponse.statusCode != 200) {
        emit(DownloadAttPdfFailureState(message: "Unable to download PDF."));
        return;
      }

      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory == null) {
        emit(DownloadAttPdfFailureState(message: "Unable to save PDF."));
        return;
      }

      String filePath =
          "$selectedDirectory/Attendance_from_${event.startDate}_to_${event.endDate}_${DateFormat("HHmmss").format(DateTime.now())}.pdf";

      File file = File(filePath);
      await file.writeAsBytes(jsonResponse.bodyBytes);

      emit(
        DownloadAttPdfSuccessState(message: "Download successful: $filePath"),
      );
    } catch (e) {
      print("❌ Exception: $e");
      emit(
        DownloadAttPdfFailureState(message: "Unable to process the request."),
      );
    }
  }

  String convertDateFormat(String date) {
    List<String> parts = date.split('-');
    return '${parts[2]}-${parts[1]}-${parts[0]}';
  }
}
