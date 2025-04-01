part of 'registration_bloc.dart';

@immutable
sealed class RegistrationEvent {}

final class RegisterStudentEvent extends RegistrationEvent {
  final String studentName;
  final String studentUSN;
  final String studentBranch;
  final String unitId;
  final String studentUnitId;
  final String fingerprintData;
  RegisterStudentEvent({
    required this.studentName,
    required this.studentUSN,
    required this.studentBranch,
    required this.unitId,
    required this.studentUnitId,
    required this.fingerprintData,
  });
}
