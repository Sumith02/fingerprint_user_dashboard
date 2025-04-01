import 'package:flutter/material.dart';

@immutable
sealed class SendOtpState {}

final class SendOtpInitialState extends SendOtpState {}

final class SendOtpSuccessState extends SendOtpState {
  final String message;
  SendOtpSuccessState({required this.message});
}

final class SendOtpFailureState extends SendOtpState {
  final String message;
  SendOtpFailureState({required this.message});
}

final class SendOtpLoadingState extends SendOtpState{}
