

import 'dart:math';

class RandomUtils {

  static Random? _random;

  
  static Random _getRandom() {
    _random ??= Random();
    return _random!;
  }


  static void setSeed(int seed) {
    _random = Random(seed);
  }
  

  static int intInRange(int min, int max) {
    return min + _getRandom().nextInt(max-min);
  }



}