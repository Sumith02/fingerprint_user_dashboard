part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

final class LoginEvent extends AuthenticationEvent{
  final String userName;
  final String password;
  LoginEvent({required this.userName , required this.password});
}
