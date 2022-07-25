
import 'dart:async';
/// This class will 'debounce' a function which prevents it from
/// being called too many times. Ideal for search bars or other situations where a call may be trigged on 
/// several rapid events. <br/>
/// As dart does not allow varargs or something similar,
/// pass in a class T to be your arguments.
/// <br/>
/// When run is called, it will wait (duration) before being called.
/// If run is called again before duration is up, duration will be reset
class Debouncer<T> {

  /// The function being called after duration
  final void Function(T) function;

  Timer? _timer;

  /// The time the debouncer waits before calling the function
  final Duration duration;

  Debouncer({this.duration = const Duration(milliseconds: 500), required this.function});

  /// Run the given function
  void run(T param) {
    _timer?.cancel();
    _timer = Timer(duration, ()=>function);
  }

  /// cancel the timer, preventing function from being run 
  void cancel() {
    _timer?.cancel();
  }

}