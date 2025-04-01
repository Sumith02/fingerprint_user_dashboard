part of 'download_excel_bloc.dart';

@immutable
sealed class DownloadExcelState {}

final class DownloadExcelInitial extends DownloadExcelState {}

final class DownloadAttExcelLoadingState extends DownloadExcelState{}

final class DownloadAttExcelSuccessState extends DownloadExcelState{
  final String message;
  DownloadAttExcelSuccessState({required this.message});
}

final class DownloadAttExcelFailureState extends DownloadExcelState{
  final String message;
  DownloadAttExcelFailureState({required this.message});
}
