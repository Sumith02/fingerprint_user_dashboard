part of 'download_excel_bloc.dart';

@immutable
sealed class DownloadExcelEvent {}

final class DownloadAttExcel extends DownloadExcelEvent {
  final String unitId;
  final String startDate;
  final String endDate;
  final String slot;
  DownloadAttExcel({
    required this.unitId,
    required this.startDate,
    required this.endDate,
    required this.slot,
  });
}
