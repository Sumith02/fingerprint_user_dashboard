part of 'fingerprint_scanner_bloc.dart';

@immutable
sealed class FingerprintScannerState {}

final class FingerprintScannerInitial extends FingerprintScannerState {}

final class FingerprintScanSuccessState extends FingerprintScannerState{
  final String fingerprintData;
  FingerprintScanSuccessState({required this.fingerprintData});
}

final class FingerprintScannerFailureState extends FingerprintScannerState{
  final String message;
  FingerprintScannerFailureState({required this.message});
}

final class FingerprintScannerLoadingState extends FingerprintScannerState{}

final class FingerprintScannerAckState extends FingerprintScannerState{
  final String message;
  final double animationDuration;
  FingerprintScannerAckState({required this.message , required this.animationDuration});
}
