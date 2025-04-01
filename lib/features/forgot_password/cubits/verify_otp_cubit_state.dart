import 'package:flutter/cupertino.dart';

@immutable
sealed class VerifyOtpState {}

final class VerifyOtpInitialState extends VerifyOtpState{}

final class VerifyOtpSuccessState extends VerifyOtpState{
  final String message;
  VerifyOtpSuccessState({required this.message});
}

final class VerifyOtpFailureState extends VerifyOtpState{
  final String message;
  VerifyOtpFailureState({required this.message});
}

final class VerifyOtpLoadingState extends VerifyOtpState{}