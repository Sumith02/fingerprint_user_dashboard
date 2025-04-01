import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';


part 'fingerprint_scanner_event.dart';
part 'fingerprint_scanner_state.dart';

class FingerprintScannerBloc
    extends Bloc<FingerprintScannerEvent, FingerprintScannerState> {
  FingerprintScannerBloc() : super(FingerprintScannerInitial()) {
    on<ActivateFingerprintScannerEvent>(_takeFingerprint);
  }

  Future<void> _takeFingerprint(
    ActivateFingerprintScannerEvent event,
    Emitter<FingerprintScannerState> emit,
  ) async {
    try {
      emit(FingerprintScannerLoadingState());
      // Port Connection
      final port = SerialPort(event.port);
      if (!port.openReadWrite()) {
        emit(
          FingerprintScannerFailureState(
            message: "Unable to open port for Read and Write",
          ),
        );
        return;
      }
      final reader = SerialPortReader(port);
      final complete = Completer<void>();

      // Port Configuration
      final config = port.config;
      config.baudRate = 115200;
      config.bits = 8;
      config.stopBits = 1;
      config.parity = 0;
      port.config = config;

      // Start Reading
      _controlCommand(port, 0);
      emit(
        FingerprintScannerAckState(
          message: "Place your Finger",
          animationDuration: 0.0,
        ),
      );
      StringBuffer buffer = StringBuffer();

      reader.stream.listen((response) async {
        buffer.write(utf8.decode(response));
        if (buffer.toString().contains("\n")) {
          var messages = buffer.toString().split("\n");
          for (var message in messages) {
            if(message.isNotEmpty){
              try {
                var res = jsonDecode(message.trim());
                if(res["error_status"] == "0"){
                  switch(res["message_type"]){
                    case "0":
                      emit(FingerprintScannerAckState(message: "Place your Finger...", animationDuration: 0.12));
                      await _controlCommand(port, 1);
                      break;
                    case "1":
                      emit(FingerprintScannerAckState(message: "Please Wait...", animationDuration: 0.23));
                      await _controlCommand(port, 2);
                      break;
                    case "2":
                      emit(FingerprintScannerAckState(message: "Fingerprint taken Successfuly.", animationDuration: 1));
                      await _controlCommand(port, 3);
                      break;
                    case "3":
                      complete.complete();
                      emit(FingerprintScanSuccessState(fingerprintData: res["fingerprint_data"]));
                  }
                } if(res["error_status"] == '1'){
                  emit(FingerprintScannerAckState(message: "Please Place your Finger again.", animationDuration: 0.0));
                  await _controlCommand(port, 0);
                }
              } catch (e) {
                emit(FingerprintScannerFailureState(message: "Error occured while getting the data."));
                _controlCommand(port, 0);
              }
            }
            buffer.clear();
          }
        }
      });
      await complete.future;
      if (port.isOpen) {
        port.flush();
        port.close();
      }
    } catch (e) {
      emit(FingerprintScannerFailureState(message: "Error occured while scanning."));
    }
  }

  Future<void> _controlCommand(SerialPort port, int status) async {
    final command = jsonEncode({"control_status": status});
    port.write(Uint8List.fromList(utf8.encode(command)));
  }
}
