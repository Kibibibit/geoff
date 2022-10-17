import 'dart:io' as io;
import 'package:flutter/foundation.dart' as found;

abstract class SystemInfo {

  SystemInfo._();

  /// If true, the application is running in debug mode
  static bool get debugMode => found.kDebugMode;

  static Platform? _platform;

  /// Gets the current [Platform] that the system is running on
  static Platform getPlatform() {
    if (_platform == null) {
      try {
        if (io.Platform.isAndroid) {
          _platform = Platform.android;
        } else if (io.Platform.isIOS) {
          _platform = Platform.ios;
        } else if (io.Platform.isWindows) {
          _platform = Platform.windows;
        } else if (io.Platform.isMacOS) {
          _platform = Platform.macOs;
        } else if (io.Platform.isFuchsia) {
          _platform = Platform.fuchsia;
        } else if (io.Platform.isLinux) {
          _platform = Platform.linux;
        } else {
          _platform = Platform.unknown;
        }
      } catch (e) {
        _platform = Platform.web;
      }
    }

    return _platform!;
  }
}

enum Platform { android, ios, web, windows, macOs, fuchsia, linux, unknown }
