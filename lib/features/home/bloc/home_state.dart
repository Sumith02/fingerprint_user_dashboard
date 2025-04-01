part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomePageLoadingState extends HomeState{}

final class HomePageErrorState extends HomeState{
  final String message;
  HomePageErrorState({required this.message});
}

final class HomePageLoadSuccessState extends HomeState{
  final List<Map<String , dynamic>> devices;
  HomePageLoadSuccessState({required this.devices});
}

final class LogoutSuccessState extends HomeState{}

final class LogoutFailureState extends HomeState{}
