import 'package:metrix/features/student_registration/cubits/port_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

class FetchPortsCubit extends Cubit<FetchPortsCubitState> {
  FetchPortsCubit() : super(FetchPortCubitInitialState());

  void fetchPorts() {
    try {
      emit(FetchPortsLoadingState());
      final List<String> ports = SerialPort.availablePorts;
      if (ports.isEmpty) {
        emit(FetchPortsFailureState(message: "no ports detected."));
        return;
      }
      emit(FetchPortSuccessState(ports: ports));
    } catch (e) {
      emit(FetchPortsFailureState(message: "unable to access ports."));
    }
  }
}
