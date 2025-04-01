import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc() : super(VerificationInitial()) {
    on<VerifyDetailsEvent>(_verifyDetails);
  }
  Future<void> _verifyDetails(VerifyDetailsEvent event , Emitter<VerificationState> emit) async {
    try {
      emit(VerifyDetailsLoadingState());
      if(event.studentName.isEmpty){
        emit(VerifyDetailsFailureState(message: "Enter Student Name"));
        return;
      }
      if(event.studentUSN.isEmpty){
        emit(VerifyDetailsFailureState(message: "Enter Student USN"));
        return;
      }
      if(event.studentBranch.isEmpty){
        emit(VerifyDetailsFailureState(message: "Enter Student Branch"));
        return;
      }
      if(event.studentUnitId.isEmpty){
        emit(VerifyDetailsFailureState(message: "Select Student Student Unit ID"));
        return;
      }
      if(event.unitId.isEmpty){
        emit(VerifyDetailsFailureState(message: "Select Student Unit ID"));
        return;
      }
      if(event.fingerprintData.isEmpty){
        emit(VerifyDetailsFailureState(message: "Add Student Fingerprint"));
        return;
      }
      emit(VerifyDetailsSuccessState());
    } catch (e) {
      emit(VerifyDetailsFailureState(message: "Error while verifying."));
    }
  }
}
