part of 'time_bloc.dart';

@immutable
sealed class TimeEvent {}

final class SetTime extends TimeEvent {
  final String morningStart;
  final String morningEnd;
  final String afternoonStart;
  final String afternoonEnd;
  final String eveningStart;
  final String eveningEnd;
  SetTime({
    required this.morningStart,
    required this.morningEnd,
    required this.afternoonStart,
    required this.afternoonEnd,
    required this.eveningStart,
    required this.eveningEnd,
  });
}
