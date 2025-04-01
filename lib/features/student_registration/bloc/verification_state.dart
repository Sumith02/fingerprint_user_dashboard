part of 'verification_bloc.dart';

@immutable
sealed class VerificationState {}

final class VerificationInitial extends VerificationState {}

final class VerifyDetailsSuccessState extends VerificationState{}

final class VerifyDetailsFailureState extends VerificationState{
  final String message;
  VerifyDetailsFailureState({required this.message});
}

final class VerifyDetailsLoadingState extends VerificationState{}
