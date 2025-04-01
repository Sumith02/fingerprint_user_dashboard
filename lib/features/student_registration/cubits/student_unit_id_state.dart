import 'package:flutter/cupertino.dart';

@immutable
sealed class FetchStudentUnitIDCubitState{}

final class FetchStudentUnitIDCubitInitialState extends FetchStudentUnitIDCubitState{}

final class FetchStudentUnitIDSuccessState
    extends FetchStudentUnitIDCubitState {
  final List<String> studentUnitID;
  FetchStudentUnitIDSuccessState({required this.studentUnitID});
}

final class FetchStudentUnitIDFailureState
    extends FetchStudentUnitIDCubitState {
  final String message;
  FetchStudentUnitIDFailureState({required this.message});
}

final class FetchStudentUnitIDLoadingState extends FetchStudentUnitIDCubitState{}