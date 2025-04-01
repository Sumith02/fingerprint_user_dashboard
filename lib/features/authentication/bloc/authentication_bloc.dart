import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:metrix/core/constants/http_headers.dart';
import 'package:metrix/core/constants/http_routes.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<LoginEvent>(_loginUser);
  }
  Future<void> _loginUser( LoginEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(LoginLoadingState());
      if (event.userName.isEmpty || event.password.isEmpty) {
        emit(LoginFailedState(message: "please enter all the required fields."));
        return;
      }
      final requestBody = jsonEncode({
        "user_name": event.userName.trim(),
        "password": event.password.trim(),
      });
      final jsonResponse = await http.post(
        Uri.parse(HttpRoutes.login),
        body: requestBody,
        headers: HttpHead.jsonHeaders,
      );
      final response = jsonDecode(jsonResponse.body);
      if (jsonResponse.statusCode != 200) {
        emit(
          LoginFailedState(message: "unable to login: ${response["error"]}."),
        );
        return;
      }
      if(response["token"] == null){
        emit(
          LoginFailedState(message: "unable to login no token found."),
        );
        return;
      }
      final box = await Hive.openBox("user_details");
      await box.put("token", response["token"]);
      final userData = JwtDecoder.decode(response["token"]);
      await box.put("user_id", userData["id"]);
      await box.put("user_name", userData["user_name"]);
      await box.close();
      emit(LoginSuccessState(message: "login successfull."));
    } catch (e) {
      emit(LoginFailedState(message: "unable to process the request."));
    }
  }
}
