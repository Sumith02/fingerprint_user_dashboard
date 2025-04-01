part of 'time_bloc.dart';

@immutable
sealed class TimeState {}

final class TimeInitial extends TimeState {}

final class SetTimeLoadingState extends TimeState{}

final class SetTimeSuccessState extends TimeState{
  final String message;
  SetTimeSuccessState({required this.message});
}

final class SetTimeFailureState extends TimeState{
  final String message;
  SetTimeFailureState({required this.message});
}
