part of 'fingerprint_scanner_bloc.dart';

@immutable
sealed class FingerprintScannerEvent {}

final class ActivateFingerprintScannerEvent extends FingerprintScannerEvent{
  final String port;
  ActivateFingerprintScannerEvent({required this.port});
}
