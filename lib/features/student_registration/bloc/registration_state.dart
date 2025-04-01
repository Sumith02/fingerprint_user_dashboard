part of 'registration_bloc.dart';

@immutable
sealed class RegistrationState {}

final class RegistrationInitial extends RegistrationState {}

final class RegisterStudentSuccessState extends RegistrationState{
  final String message;
  RegisterStudentSuccessState({required this.message});
}

final class RegisterStudentFailureState extends RegistrationState{
  final String message;
  RegisterStudentFailureState({required this.message});
}

final class RegisterStudentLoadingState extends RegistrationState{}