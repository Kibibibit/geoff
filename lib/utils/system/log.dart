
import 'package:logger/logger.dart';


/// An extension of the dart logger, but includes class names
class Log {

  final String _name;
  final Logger _logger;

  Log(
    String name,
    {LogFilter? filter,
    LogPrinter? printer,
    LogOutput? output,
    Level? level,
  }) : _name = name,
    _logger = Logger(
      filter: filter, 
      printer: printer, 
      output: output, 
      level: level
    );


  String get name {return _name;}  


  /// Calls log at the given [Level]
  void log(Level level, String message, [dynamic error, StackTrace? stackTrace]) {
    message = "[$_name] ${message.toString()}";

    Map<Level, Function(String, [dynamic, StackTrace?])?> _functionMap = {
      Level.verbose : _logger.v,
      Level.debug : _logger.d,
      Level.info : _logger.i,
      Level.warning : _logger.w,
      Level.error : _logger.e,
      Level.wtf : _logger.wtf,
      Level.nothing : null
    };

    void Function(String, [dynamic, StackTrace?])? function = _functionMap[level];

    if (function != null) {
      if (error != null) {
        function(message, error, stackTrace);
      } else {
        function(message);
      }
    }
  }

  void verbose(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    log(Level.verbose, message, error, stackTrace);
  }

  void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    log(Level.debug, message, error, stackTrace);
  }

  void info(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    log(Level.info, message, error, stackTrace);
  }

  void warning(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    log(Level.warning, message, error, stackTrace);
  }

  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    log(Level.error, message, error, stackTrace);
  }

  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    log(Level.wtf, message, error, stackTrace);
  }

  



}