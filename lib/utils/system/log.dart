
import 'package:flutter/material.dart';
import 'package:geoff/utils/maths/random_utils.dart';
import 'package:geoff/utils/system/system_info.dart';


/// An extension of the dart logger, but includes class names
class Log {

  

  /// Escape codes for logging in color
  //static const String _black = "\x1B[30m";
  static const String _red = "\x1B[31m";
  static const String _green = "\x1B[32m";
  static const String _yellow = "\x1B[33m";
  static const String _blue = "\x1B[34m";
  static const String _magenta = "\x1B[35m";
  static const String _cyan = "\x1B[36m";
  static const String _white = "\x1B[37m";
  static const String _reset = "\x1B[0m";

  static final Map<Level, String> _logColor = {
    Level.info:_cyan,
    Level.debug:_green,
    Level.warning:_yellow,
    Level.error:_red,
    Level.wtf:_magenta
  };

  static final List<String> _classColors = [
    _green,_yellow,_blue,_magenta,_cyan,_white
  ];


  final String _name;
  final int _col;
  Level _level;
  bool _colors;

  /// Creates a new logger
  Log(
    String name,
    {
      Level level = Level.info,
      bool colors = true,
  }) : _name = name,
    _col = RandomUtils.intInRange(0, _classColors.length),
    _colors = colors,
    _level = level;



  String get name {return _name;}
  Level get level {return _level;}
  bool get colors {return _colors;}

  void setColors(bool colors) {
    _colors = colors;
  }

  void setLevel(Level level) {
    _level = level;
  }


  String _colorise(String text, String color) {
    if (_colors) {
      text = color+text+_reset;
    }
    return text;
  }


  /// Calls log at the given [Level]
  void logAt(Level level, dynamic message, [Error? error, StackTrace? stackTrace]) {

    if (level != Level.nothing || (level == Level.debug && !SystemInfo.debugMode)) {
      String levelString = "[${_colorise(level.name.toUpperCase(), _logColor[level]!)}]";
      String classString = "[${_colorise(_name, _classColors[_col])}]";
      String logStart = levelString + classString;
      String out = logStart + message.toString();

      debugPrint(out);
      if (error != null) {
        stackTrace ??= error.stackTrace;
        debugPrintStack(label: error.toString(), stackTrace: stackTrace);
      }
    }


  }

  /// Calls [logAt] but at the currently set [Level] through [setLevel]
  void log(dynamic message, [Error? error, StackTrace? stackTrace]) {
    logAt(_level, message, error, stackTrace);
  }

  /// Logs at [Level.debug], assuming the system is in debug mode
  void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logAt(Level.debug, message, error, stackTrace);
  }

  /// Logs at [Level.info]
  void info(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logAt(Level.info, message, error, stackTrace);
  }

  /// Logs at [Level.warning]
  void warning(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logAt(Level.warning, message, error, stackTrace);
  }

  /// Logs at [Level.error]
  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logAt(Level.error, message, error, stackTrace);
  }

  /// Logs at [Level.wtf]
  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logAt(Level.wtf, message, error, stackTrace);
  }

  
}


/// The level that the logger can log at
enum Level {
  /// Info - For logging simple info messages
  info,
  /// Warning - for non critical errors
  warning,
  /// Debug - For debugging information
  debug,
  /// Error - For critical errors
  error,
  /// WTF - WTF
  wtf,
  /// Disables logging completely
  nothing
}