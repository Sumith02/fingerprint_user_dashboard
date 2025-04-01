part of 'change_password_bloc.dart';

@immutable
sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}

final class UpdatePasswordSuccessState extends ChangePasswordState {
  final String message;
  UpdatePasswordSuccessState({required this.message});
}

final class UpdatePasswordFailureState extends ChangePasswordState {
  final String message;
  UpdatePasswordFailureState({required this.message});
}

final class UpdatePasswordLoadingState extends ChangePasswordState{}
