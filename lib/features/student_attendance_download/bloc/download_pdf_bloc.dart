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
            message: "invalid user id please logout and login again.",
          ),
        );
        return;
      }

      final jsonResponse = await http.post(
        body: jsonEncode({
          "unit_id": event.unitId.trim(),
          "user_id": userId.trim(),
          "start_date": convertDateFormat(event.startDate.trim()),
          "end_date": convertDateFormat(event.endDate.trim()),
          "slot": event.slot.trim(),
        }),
        Uri.parse(HttpRoutes.pdfDownload),
        headers: HttpHead.jsonHeaders,
      );
      if (jsonResponse.statusCode != 200) {
        emit(DownloadAttPdfFailureState(message: "unable to download pdf."));
        return;
      }
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory == null) {
        emit(DownloadAttPdfFailureState(message: "unable to save pdf."));
        return;
      }
      String filePath =
          "$selectedDirectory/Attendance_from_${event.startDate}_to_${event.endDate}_${DateFormat("HHmmss").format(DateTime.now())}.pdf";
      File file = File(filePath);
      await file.writeAsBytes(jsonResponse.bodyBytes);
      emit(
        DownloadAttPdfSuccessState(message: "download successfull: $filePath"),
      );
    } catch (e) {
      emit(
        DownloadAttPdfFailureState(message: "unable to process the request."),
      );
    }
  }

  String convertDateFormat(String date) {
    List<String> parts = date.split('-');
    return '${parts[2]}-${parts[1]}-${parts[0]}';
  }
}
