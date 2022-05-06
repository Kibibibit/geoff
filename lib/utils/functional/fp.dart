abstract class FP {

  /// Private constructor to prevent extending
  FP._();

  static K Function(List<V> list) reduce<K, V>(
      K Function(K acc, V elem) fn, K acc) {
    return (final List<V> list) {
      if (list.isEmpty) {
        return acc;
      }

      acc = fn(acc, list.first);

      return reduce<K, V>(fn, acc)(list.sublist(1));
    };
  }

  /// The method that actually remembers the list. Stays private,
  /// as you should not be able to access [l].
  static List<K> Function(List<K> list) _filter<K>(
      bool Function(K elem) fn, List<K> l) {
    return (final List<K> list) {
      if (list.isEmpty) {
        return l;
      }

      if (fn(list.first)) {
        l.add(list.first);
      }

      return _filter(fn, l)(list.sublist(1));
    };
  }

  static List<K> Function(List<K> list) filter<K>(bool Function(K elem) fn) =>
      (final List<K> list) => _filter<K>(fn, [])(list);

  static List<V> Function(List<K> list) _map<K, V>(
      V Function(K elem) fn, List<V> l) {
    return (final List<K> list) {
      if (list.isEmpty) {
        return l;
      }

      l.add(fn(list.first));

      return _map<K, V>(fn, l)(list.sublist(1));
    };
  }

  static List<V> Function(List<K> list) map<K, V>(V Function(K elem) fn) =>
      (final List<K> list) => _map<K, V>(fn, [])(list);
}
