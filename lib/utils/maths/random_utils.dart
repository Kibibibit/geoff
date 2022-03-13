

import 'dart:math';

class RandomUtils {

  static Random? _random;

  
  static Random _getRandom() {
    _random ??= Random();
    return _random!;
  }

  /// Sets the seed for these. Note that this creates a new [Random] instance so
  /// it will reset the seed
  static void setSeed(int seed) {
    _random = Random(seed);
  }
  
  /// Gives an int in the given range from [min] (inclusive) to [max] (exclusive)
  static int intInRange(int min, int max) {
    return min + _getRandom().nextInt(max-min);
  }



}