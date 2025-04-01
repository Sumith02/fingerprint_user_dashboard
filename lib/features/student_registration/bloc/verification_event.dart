part of 'verification_bloc.dart';

@immutable
sealed class VerificationEvent {}


final class VerifyDetailsEvent extends VerificationEvent{
  final String studentName;
  final String studentUSN;
  final String studentBranch;
  final String unitId;
  final String studentUnitId;
  final String fingerprintData;
  VerifyDetailsEvent({
    required this.studentName,
    required this.studentUSN,
    required this.studentBranch,
    required this.unitId,
    required this.studentUnitId,
    required this.fingerprintData,
  });
}
