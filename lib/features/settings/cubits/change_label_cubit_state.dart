import 'package:flutter/cupertino.dart';

@immutable
sealed class ChangeLabelState {}

final class ChangeLabelInitialState extends ChangeLabelState{}

final class ChangeLabelSuccessState extends ChangeLabelState{
  final String message;
  ChangeLabelSuccessState({required this.message});
}

final class ChangeLabelFailureState extends ChangeLabelState{
  final String message;
  ChangeLabelFailureState({required this.message});
}

final class ChangeLabelLoadingState extends ChangeLabelState{}