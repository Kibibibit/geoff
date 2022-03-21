import 'dart:async';
import 'dart:convert';

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

  static int _maxLogs = 100;

  static double _iconSize = 24.0;

  static bool _logInDebugMode = false;

  static final List<_LogModel> _logs = [];

  static final StreamController _streamController =
      StreamController.broadcast();

  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  static void _addLog(_LogModel model) {
    if (_logs.length >= _maxLogs) {
      _logs.removeAt(0);
    }
    _logs.add(model);
    _streamController.add("");
  }

  static void showLogger(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const _LogConsole();
    }));
  }

  static final Map<Level, String> _logColor = {
    Level.info: _cyan,
    Level.debug: _green,
    Level.warning: _yellow,
    Level.error: _red,
    Level.wtf: _magenta
  };

  static final List<String> _classColors = [
    _green,
    _yellow,
    _blue,
    _magenta,
    _cyan,
    _white
  ];

  final String _name;
  final int _col;
  Level _level;
  bool _colors;

  /// Creates a new logger
  Log(
    String name, {
    Level level = Level.info,
    bool colors = true,
  })  : _name = name,
        _col = RandomUtils.intInRange(0, _classColors.length),
        _colors = colors,
        _level = level;

  String get name {
    return _name;
  }

  Level get level {
    return _level;
  }

  bool get colors {
    return _colors;
  }

  int get maxLogs {
    return _maxLogs;
  }

  double get iconSize {
    return _iconSize;
  }

  bool get logInDebugMode {
    return _logInDebugMode;
  }

  void setLogInDebugMode(bool log) {
    _logInDebugMode = log;
  }

  void setMaxLogs(int maxLogs) {
    if (maxLogs >= 0) {
      _maxLogs = maxLogs;
    }
  }

  void setIconSize(double iconSize) {
    _iconSize = iconSize;
  }

  void setColors(bool colors) {
    _colors = colors;
  }

  void setLevel(Level level) {
    _level = level;
  }

  String _colorise(String text, String color) {
    if (_colors) {
      text = color + text + _reset;
    }
    return text;
  }

  /// Calls log at the given [Level]
  void logAt(Level level, dynamic message,
      [Error? error, StackTrace? stackTrace]) {
    if (level != Level.nothing && (SystemInfo.debugMode || _logInDebugMode)) {
      String formattedMessage = _encoder.convert(message.toString());
      String levelString =
          "[${_colorise(level.name.toUpperCase(), _logColor[level]!)}]";
      String classString = "[${_colorise(_name, _classColors[_col])}]";
      String logStart = levelString + classString;
      String out = logStart + formattedMessage;

      debugPrint(out);
      if (error != null) {
        stackTrace ??= error.stackTrace;
        debugPrintStack(label: error.toString(), stackTrace: stackTrace);
      }

      _addLog(_LogModel(level, _name, _classColors[_col], formattedMessage,
          error, stackTrace));
    }
  }

  /// Calls [logAt] but at the currently set [Level] through [setLevel]
  void log(dynamic message, [Error? error, StackTrace? stackTrace]) {
    logAt(_level, message, error, stackTrace);
  }

  /// Logs at [Level.debug], assuming the system is in debug mode
  void debug(dynamic message, [Error? error, StackTrace? stackTrace]) {
    logAt(Level.debug, message, error, stackTrace);
  }

  /// Logs at [Level.info]
  void info(dynamic message, [Error? error, StackTrace? stackTrace]) {
    logAt(Level.info, message, error, stackTrace);
  }

  /// Logs at [Level.warning]
  void warning(dynamic message, [Error? error, StackTrace? stackTrace]) {
    logAt(Level.warning, message, error, stackTrace);
  }

  /// Logs at [Level.error]
  void error(dynamic message, [Error? error, StackTrace? stackTrace]) {
    logAt(Level.error, message, error, stackTrace);
  }

  /// Logs at [Level.wtf]
  void wtf(dynamic message, [Error? error, StackTrace? stackTrace]) {
    logAt(Level.wtf, message, error, stackTrace);
  }
}

/// This model stores the details used to output the log details
class _LogModel {
  late final Level level;
  late final String caller;
  late final String callerColour;
  late final String message;
  late final Error? error;
  late final StackTrace? stackTrace;

  _LogModel(this.level, this.caller, this.callerColour, this.message,
      this.error, this.stackTrace);
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

class _LogConsole extends StatefulWidget {
  const _LogConsole({Key? key}) : super(key: key);

  @override
  State<_LogConsole> createState() => _LogConsoleState();
}

class _LogConsoleState extends State<_LogConsole> {
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();

    setState(() {
      subscription = Log._streamController.stream.listen((event) {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              subscription.cancel();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close)),
        title: const Text("Logs"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: Log._logs.length,
              itemBuilder: (context, index) {
                return _LogWidget(model: Log._logs[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LogWidget extends StatelessWidget {
  static final Map<Level, IconData> _iconMap = {
    Level.info: Icons.lightbulb,
    Level.warning: Icons.warning,
    Level.error: Icons.error,
    Level.debug: Icons.bug_report,
    Level.wtf: Icons.ac_unit
  };

  static final Map<Level, Color> _colorMap = {
    Level.info: Colors.blue,
    Level.warning: Colors.amber,
    Level.error: Colors.red,
    Level.debug: Colors.green,
    Level.wtf: Colors.purple
  };

  static final Map<String, Color> _textColorMap = {
    Log._green: Colors.green,
    Log._yellow: Colors.amber,
    Log._blue: Colors.yellow,
    Log._magenta: Colors.purple,
    Log._cyan: Colors.cyan,
    Log._white: Colors.black
  };

  final _LogModel model;
  final Icon icon;

  _LogWidget({Key? key, required this.model})
      : icon = Icon(
          _iconMap[model.level],
          color: _colorMap[model.level],
          size: Log._iconSize,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(model.message),
      subtitle: Text(
        model.error?.toString() ?? "",
        style: const TextStyle(color: Colors.red),
      ),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            child: icon,
            padding: const EdgeInsets.only(right: 5),
          ),
          Text(
            "[${model.caller}]",
            style: TextStyle(fontWeight: FontWeight.bold,color: _textColorMap[model.callerColour]),
          )
        ],
      ),
    );
  }
}
