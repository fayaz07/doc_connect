import 'package:flutter/foundation.dart';

class Log {

  static Logger _log = Logger();

  static debug(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _log.d(message, error, stackTrace);
  }

  static info(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _log.i(message, error, stackTrace);
  }

  static error(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _log.e(message, error, stackTrace);
  }

  static warning(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _log.w(message, error, stackTrace);
  }

  static handleHttpCrash(dynamic message,
      [dynamic err, StackTrace stackTrace]) {
    error(message, err.toString(), stackTrace);
  }

  static close() {
    _log.close();
//    _sink.close();
  }
}

class Logger {
  i(dynamic message, [dynamic error, StackTrace stackTrace]) {
    debugPrint('--------------------info-----------------');
    debugPrint(message);
    if (error != null) debugPrint(error);
    debugPrint('-----------------------------------------');
  }

  d(dynamic message, [dynamic error, StackTrace stackTrace]) {
    debugPrint('--------------------debug-----------------');
    debugPrint(message);
    if (error != null) debugPrint(error);
    debugPrint('-----------------------------------------');
  }

  w(dynamic message, [dynamic error, StackTrace stackTrace]) {
    debugPrint('--------------------warning-----------------');
    debugPrint(message);
    if (error != null) debugPrint(error);
    debugPrint('-----------------------------------------');
  }

  e(dynamic message, [dynamic error, StackTrace stackTrace]) {
    debugPrint('--------------------error-----------------');
    debugPrint(message);
    if (error != null) debugPrint(error);
    debugPrint('-----------------------------------------');
  }

  close() {}
}
