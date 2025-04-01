import 'dart:convert';

import 'package:metrix/core/constants/http_headers.dart';
import 'package:metrix/core/constants/http_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<BiometricMachinesFetchEvent>(_fetchBiometricMachinesEvent);
    on<LogoutEvent>(_logout);
  }

  Future<void> _logout(LogoutEvent event, Emitter<HomeState> emit) async {
    try {
      final box = await Hive.openBox("user_details");
      await box.delete("token");
      await box.delete("user_id");
      await box.delete("user_name");
      await box.close();
      emit(LogoutSuccessState());
    } catch (e) {
      emit(LogoutFailureState());
    }
  }

  Future<void> _fetchBiometricMachinesEvent(
    BiometricMachinesFetchEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomePageLoadingState());
      final box = await Hive.openBox("user_details");
      final String ? userId = box.get("user_id");
      await box.close();
      if (userId == null) {
        emit(
          HomePageErrorState(
            message: "invalid user id please logout and login again.",
          ),
        );
        return;
      }
      var jsonResponse = await http.get(
        Uri.parse("${HttpRoutes.fetchDevices}/$userId"),
        headers: HttpHead.jsonHeaders,
      );
      final response = jsonDecode(jsonResponse.body);
      if (jsonResponse.statusCode != 200) {
        emit(HomePageErrorState(message: response["error"]));
        return;
      }
      if (response["units"] == null) {
        emit(HomePageErrorState(message: "No Devices Found."));
        return;
      }
      final List<Map<String, dynamic>> devices = List<Map<String, dynamic>>.from(response["units"]);
      emit(HomePageLoadSuccessState(devices: devices));
    } catch (e) {
      emit(HomePageErrorState(message: "Unable to Process the Request."));
    }
  }
}
