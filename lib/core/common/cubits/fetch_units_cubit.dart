import 'dart:convert';

import 'package:metrix/core/constants/http_headers.dart';
import 'package:metrix/core/constants/http_routes.dart';
import 'package:metrix/core/common/cubits/fetch_unit_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class FetchUnitIDCubit extends Cubit<FetchUnitIDState> {
  FetchUnitIDCubit() : super(FetchUnitIDInitialState());

  Future<void> fetchMachines() async {
    try {
      emit(FetchUnitIDLoadingState());
      final box = await Hive.openBox("user_details");
      final String ? userId = box.get("user_id");
      box.close();
      if (userId!.isEmpty) {
        emit(
          FetchUnitIDFailureState(
            message: "invalid user id please login and try again.",
          ),
        );
        return;
      }
      final jsonResponse = await http.get(
        Uri.parse("${HttpRoutes.getUnitID}/$userId"),
        headers: HttpHead.jsonHeaders,
      );
      final response = jsonDecode(jsonResponse.body);
      if(jsonResponse.statusCode != 200){
        emit(FetchUnitIDFailureState(message: response["error"]));
        return;
      }
      if(response["units"] == null){
        emit(FetchUnitIDFailureState(message: "no machines exist."));
        return;
      }
      final List<String> units = List<String>.from(response["units"]);
      emit(FetchUnitIDSuccessState(units: units));
    } catch (e) {
      emit(FetchUnitIDFailureState(message: "unable to process the request."));
    }
  }
}
