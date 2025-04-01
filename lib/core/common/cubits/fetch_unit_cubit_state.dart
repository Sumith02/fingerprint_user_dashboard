import 'package:flutter/material.dart';

@immutable
sealed class FetchUnitIDState {}

final class FetchUnitIDInitialState extends FetchUnitIDState{}

final class FetchUnitIDSuccessState extends FetchUnitIDState{
  final List<String> units;
  FetchUnitIDSuccessState({required this.units});
}

final class FetchUnitIDFailureState extends FetchUnitIDState{
  final String message;
  FetchUnitIDFailureState({required this.message});
}

final class FetchUnitIDLoadingState extends FetchUnitIDState{}