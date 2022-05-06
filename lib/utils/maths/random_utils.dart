

import 'dart:math';

/// This class contains functions related to getting random numbers.
/// You can set the see with [setSeed] but keep in mind this will reset [Random] instance
/// when called
abstract class RandomUtils {

  /// Private constructor to prevent extending
  RandomUtils._();

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
  
  /// Gives an int in the given range from [min] (inclusive) to [max] (inclusive)
  static int intInRange(int min, int max) {
    if (min > max) {
      int i = max;
      max = min;
      min = i;
    }
    return min + _getRandom().nextInt(max-min+1);
  }
  
  /// Gives a double in the given range from [min] (inclusive) to [max] (inclusive)
  static double doubleInRange(double min, double max) {
    if (min > max) {
      double i = max;
      max = min;
      min = i;
    }
    return min + _getRandom().nextDouble() * (max-min).abs();
  }


}