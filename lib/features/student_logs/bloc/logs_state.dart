part of 'logs_bloc.dart';

@immutable
sealed class LogsState {}

final class LogsInitial extends LogsState {}


final class FetchStudentLogsSuccessState extends LogsState{
  final List<Map<String , dynamic>> logs;
  FetchStudentLogsSuccessState({required this.logs});
}

final class FetchStudentLogsFailureState extends LogsState{
  final String message;
  FetchStudentLogsFailureState({required this.message});
}

final class FetchStudentLogsLoadingState extends LogsState{}