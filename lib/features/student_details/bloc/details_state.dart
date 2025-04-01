part of 'details_bloc.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {}

final class FetchStudentDetailsSuccessState extends DetailsState{
  final List<Map<String , dynamic>> details;
  FetchStudentDetailsSuccessState({required this.details});
}

final class FetchStudentDetailsFailureState extends DetailsState{
  final String message;
  FetchStudentDetailsFailureState({required this.message});
}

final class FetchStudentDetailsLoadingState extends DetailsState{}
