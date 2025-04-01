part of 'download_pdf_bloc.dart';

@immutable
sealed class DownloadPdfEvent {}

final class DownloadAttPdfEvent extends DownloadPdfEvent {
  final String unitId;
  final String startDate;
  final String endDate;
  final String slot;
  DownloadAttPdfEvent({
    required this.unitId,
    required this.startDate,
    required this.endDate,
    required this.slot,
  });
}
