part of 'download_pdf_bloc.dart';

@immutable
sealed class DownloadPdfState {}

final class DownloadPdfInitial extends DownloadPdfState {}

final class DownlaodAttPdfLoadingState extends DownloadPdfState{}

final class DownloadAttPdfSuccessState extends DownloadPdfState{
  final String message;
  DownloadAttPdfSuccessState({required this.message});
}

final class DownloadAttPdfFailureState extends DownloadPdfState{
  final String message;
  DownloadAttPdfFailureState({required this.message});
}
