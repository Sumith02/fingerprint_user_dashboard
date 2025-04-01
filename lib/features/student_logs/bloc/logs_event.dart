part of 'logs_bloc.dart';

@immutable
sealed class LogsEvent {}


final class FetchStudentLogsEvent extends LogsEvent{
  final String studentId;
  FetchStudentLogsEvent({required this.studentId});
}
