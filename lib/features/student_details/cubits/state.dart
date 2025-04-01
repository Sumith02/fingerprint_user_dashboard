import 'package:flutter/material.dart';

@immutable
sealed class StudentDetailsState {}

final class StudentDetailsInitialState extends StudentDetailsState {}

final class DeleteSuccessState extends StudentDetailsState {
  final String message;
  DeleteSuccessState({required this.message});
}

final class DeleteFailureState extends StudentDetailsState {
  final String message;
  DeleteFailureState({required this.message});
}

final class UpdateStudentSuccessState extends StudentDetailsState {
  final String message;
  UpdateStudentSuccessState({required this.message});
}

final class UpdateStudentFailureState extends StudentDetailsState {
  final String message;
  UpdateStudentFailureState({required this.message});
}
