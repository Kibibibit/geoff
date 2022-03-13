
import 'package:flutter/material.dart';
import 'package:geoff/utils/maths/random_utils.dart';
import 'package:geoff/utils/system/level.dart';


/// An extension of the dart logger, but includes class names
class Log {

  

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
  final Level _level;
  final int _col;
  bool _colors;

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


  String _colorise(String text, String color) {
    if (_colors) {
      text = color+text+_reset;
    }
    return text;
  }

  void logAt(Level level, dynamic message, [Error? error, StackTrace? stackTrace]) {

    if (level != Level.nothing) {
      String levelString = "[${_colorise(level.toString().toUpperCase(), _logColor[level]!)}]";
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

  /// Calls log at the given [Level]
  void log(dynamic message, [Error? error, StackTrace? stackTrace]) {
    logAt(_level, message, error, stackTrace);
  }


  void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logAt(Level.debug, message, error, stackTrace);
  }

  void info(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logAt(Level.info, message, error, stackTrace);
  }

  void warning(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logAt(Level.warning, message, error, stackTrace);
  }

  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logAt(Level.error, message, error, stackTrace);
  }

  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logAt(Level.wtf, message, error, stackTrace);
  }

  



}