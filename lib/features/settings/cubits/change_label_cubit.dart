import 'dart:convert';

import 'package:metrix/core/constants/http_headers.dart';
import 'package:metrix/core/constants/http_routes.dart';
import 'package:metrix/features/settings/cubits/change_label_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ChangeLabelCubit extends Cubit<ChangeLabelState> {
  ChangeLabelCubit() : super(ChangeLabelInitialState());

  Future<void> changeLabel(String unitID, String label) async {
    try {
      emit(ChangeLabelLoadingState());
      if (unitID.isEmpty || label.isEmpty) {
        emit(
          ChangeLabelFailureState(message: "please enter all the required fields."),
        );
        return;
      }
      final jsonBody = jsonEncode({
        "unit_id": unitID.trim(),
        "label": label.trim(),
      });
      final jsonResponse = await http.post(
        Uri.parse(HttpRoutes.changeLabel),
        body: jsonBody,
        headers: HttpHead.jsonHeaders,
      );
      final response = jsonDecode(jsonResponse.body);
      if (jsonResponse.statusCode != 200) {
        emit(ChangeLabelFailureState(message: response["error"]));
        return;
      }
      emit(ChangeLabelSuccessState(message: response["message"]));
    } catch (e) {
      emit(ChangeLabelFailureState(message: "unable to process the request."));
    }
  }
}
