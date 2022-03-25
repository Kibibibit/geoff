import 'dart:async';

class Alarm {
  late final void Function() _alarm;
  late DateTime _at;
  late Duration _after;
  late Timer _timer;

  static Alarm at(DateTime at, void Function() callback) {
    Alarm alarm = Alarm._(callback);
    alarm._createFromDateTime(at);
    return alarm;
  }

  static Alarm after(Duration after, void Function() callback) {
    Alarm alarm = Alarm._(callback);
    alarm._createFromDuration(after);
    return alarm;
  }

  bool get isActive => _timer.isActive;
  int get tick => _timer.tick;

  Alarm._(this._alarm);

  void cancel() {
    _timer.cancel();
  }

  void _start() {
    _timer = Timer(_after, _alarm);
  }

  void _createFromDateTime(DateTime at) {
    _at = at;
    _after = _at.difference(DateTime.now());

    if (_after.isNegative) {
      _after = const Duration(seconds: 0);
    }
    _start();
  }

  void _createFromDuration(Duration after) {
    _after = after;
    _at = DateTime.now().add(_after);

    if (_after.isNegative) {
      _after = const Duration(seconds: 0);
    }

    _start();
  }
}
