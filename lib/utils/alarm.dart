import 'dart:async';

import 'package:geoff/utils/system/log.dart';

/// Creates an alarm object that will run a callback, either at a given time or after a certain duration.
/// The alarm will start its' countdown until [start] is called. If the duration is negative
/// or the time to trigger on has already passed, the alarm will trigger immediatly
class Alarm {

  static final Log _logger = Log("Alarm");

  /// Disable the colors in the logs if your terminal does not support escape codes
  static void disableColors() {
    _logger.setColors(false);
  }

  late final void Function() _alarm;
  late DateTime _at;
  late Duration _after;
  late Timer _timer;
  late final bool _onDateTime;

  static Alarm at(DateTime at, void Function() callback) {
    Alarm alarm = Alarm._(callback, true);
    alarm._at = at;
    return alarm;
  }

  static Alarm after(Duration after, void Function() callback) {
    Alarm alarm = Alarm._(callback, false);
    alarm._after = after;
    return alarm;
  }

  /// If the timer for this alarm is active, will return true
  bool get isActive => _timer.isActive;

  /// The tick of the alarm's timer
  int get tick => _timer.tick;

  /// If the alarm is triggering on a time, or after a duration
  bool get onDateTime => _onDateTime;

  /// Returns the duration this timer will take to trigger, relative if
  /// using an alarm with a datetime
  Duration get triggerAfter {
    if (_onDateTime) {
      return _at.difference(DateTime.now());
    } else {
      return _after;
    }
  }

  /// Returns the datetime that this timer will trigger at, relative if
  /// using an alarm with a duration
  DateTime get triggerAt {
    if (_onDateTime) {
      return _at;
    } else {
      return _at.add(_after);
    }
  }


  Alarm._(this._alarm, this._onDateTime) {
    _timer = Timer(Duration.zero, () {});
  }

  void cancel() {
    _timer.cancel();
  }

  /// Starts the alarm.
  Alarm start() {
    _onDateTime ? _createFromDateTime(_at) : _createFromDuration(_after);
    if (_after.isNegative) {
      _logger.warning("Duration for alarm is negative!, triggering now!");
      _after = Duration.zero;
    }
    _timer = Timer(_after, _alarm);
    return this;
  }

  void _createFromDateTime(DateTime at) {
    _at = at;
    _after = _at.difference(DateTime.now());

    
  }

  void _createFromDuration(Duration after) {
    _after = after;
    _at = DateTime.now().add(_after);
  }
}
