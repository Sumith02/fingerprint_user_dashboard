part of 'change_password_bloc.dart';

@immutable
sealed class ChangePasswordEvent {}

final class UpdatePassword extends ChangePasswordEvent {
  final String newPassword;
  final String confirmPassword;
  UpdatePassword({
    required this.newPassword,
    required this.confirmPassword,
  });
}
