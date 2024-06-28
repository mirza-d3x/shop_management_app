import 'dart:async';
import 'dart:developer';

void consoleLog(
  String message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
  String? name,
}) {
  log(
    message,
    time: time,
    sequenceNumber: sequenceNumber,
    level: level,
    name: "NEST_APP: ${name ?? ""}",
    zone: zone,
    error: error,
    stackTrace: stackTrace,
  );
}
