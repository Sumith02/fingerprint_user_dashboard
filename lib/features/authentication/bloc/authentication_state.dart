part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class LoginLoadingState extends AuthenticationState{}

final class LoginSuccessState extends AuthenticationState{
  final String message;
  LoginSuccessState({required this.message});
}

final class LoginFailedState extends AuthenticationState{
  final String message;
  LoginFailedState({required this.message});
}
