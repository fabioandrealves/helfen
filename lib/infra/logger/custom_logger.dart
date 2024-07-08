import 'package:logger/logger.dart';

enum AndroidLogLevel { info, warning, error, debug, verbose }

class CustomLogger {
  static final Logger _logger = Logger();

  static void logToLogcat({
    required String tag,
    required String subTag,
    required String message,
    required AndroidLogLevel logLevel,
  }) {
    // Log to console using logger library
    switch (logLevel) {
      case AndroidLogLevel.info:
        _logger.i('$tag.$subTag: $message');
        break;
      case AndroidLogLevel.warning:
        _logger.w('$tag.$subTag: $message');
        break;
      case AndroidLogLevel.error:
        _logger.e('$tag.$subTag: $message');
        break;
      case AndroidLogLevel.debug:
        _logger.d('$tag.$subTag: $message');
        break;
      case AndroidLogLevel.verbose:
        _logger.v('$tag.$subTag: $message');
        break;
    }
  }

  // Prettified logs in terminal
  static void logInfo(dynamic info) {
    _logger.i(info);
  }

  static void logWarning(dynamic warning) {
    _logger.w(warning);
  }

  static void logError(dynamic error) {
    _logger.e(error);
  }
}
