part of 'details_bloc.dart';

@immutable
sealed class DetailsEvent {}

final class FetchStudentDetails extends DetailsEvent{
  final String unitId;
  FetchStudentDetails({required this.unitId});
}
