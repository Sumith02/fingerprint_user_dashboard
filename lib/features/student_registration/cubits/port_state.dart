import 'package:flutter/cupertino.dart';

@immutable
sealed class FetchPortsCubitState {}

final class FetchPortCubitInitialState extends FetchPortsCubitState {}

final class FetchPortSuccessState extends FetchPortsCubitState {
  final List<String> ports;
  FetchPortSuccessState({required this.ports});
}

final class FetchPortsFailureState extends FetchPortsCubitState {
  final String message;
  FetchPortsFailureState({required this.message});
}

final class FetchPortsLoadingState extends FetchPortsCubitState {}
