abstract class FP {

  /// Private constructor to prevent extending
  FP._();


  ///Runs `fn` on every element of `list`. Call like `FP.onEvery<K>(fn)(list)`
  static void Function(List<K> list) onEvery<K>(void Function(K elem) fn){
    return (final List<K> list) {
      fn(list.first);
      onEvery(fn)(list.skip(1).toList());
    };
  }

  /// Reduces `acc` by calling `fn` on every element of `list`. `fn` should modify `acc` and then return it.
  /// Call like `FP.reduce<K,V>(fn, acc)(list)`
  static V Function(List<K> list) reduce<K, V>(
      V Function(V acc, K elem) fn, V acc) {
    return (final List<K> list) {
      if (list.isEmpty) {
        return acc;
      }

      acc = fn(acc, list.first);

      return reduce<K, V>(fn, acc)(list.skip(1).toList());
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

      return _filter(fn, l)(list.skip(1).toList());
    };
  }

  /// Returns a new list in which `fn(every element on list)` returns `true`
  /// Call like `FP.filter<K>(fn)(list)`
  static List<K> Function(List<K> list) filter<K>(bool Function(K elem) fn) =>
      (final List<K> list) => _filter<K>(fn, [])(list);

  static List<V> Function(List<K> list) _map<K, V>(
      V? Function(K elem) fn, List<V> l) {
    return (final List<K> list) {
      if (list.isEmpty) {
        return l;
      }

      V? v = fn(list.first);
      if (v != null) {
        l.add(v);
      } else if (null is V) {
        // ignore: unnecessary_cast
        (l as List<V?>).add(v);
      }

      

      return _map<K, V>(fn, l)(list.skip(1).toList());
    };
  }

  ///Returns a new list where each element of `list` is transformed by `fn`. If `V` is nullable,
  /// and `fn` returns null, null will be added to the list. Otherwise, use `return null` to skip these elements.
  /// Call like `FP.map<K,V>(fn)(list)`
  static List<V> Function(List<K> list) map<K, V>(V Function(K elem) fn) =>
      (final List<K> list) => _map<K, V>(fn, [])(list);
}
