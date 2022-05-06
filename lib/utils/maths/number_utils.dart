import 'dart:math';

/// This class contains utility functions related to number manipulation,
/// such as rounding/wrapping values
abstract class NumberUtils {

  /// Private constructor to prevent extending
  NumberUtils._();

  /// Rounds a double to have [places] places
  static double roundToPlaces(double val, int places) {

    val *= pow(10, places);

    double out = val.roundToDouble();

    return out/pow(10,places);

  }


  /// Wraps a double [val] between [min] and [max]. If [min] = 1, [max] = 5
  /// and [val] = 7, this will return 2.
  static double wrapDouble(double val, double min, double max) {
    double diff = (max-min).abs() + 1;
    while (val < min) {
      val += diff;
    }
    while (val > max) {
      val -= diff;
    }
    return val;
  }

  /// Wraps an integer [val] between [min] and [max]. If [min] = 1, [max] = 5
  /// and [val] = 7, this will return 2.
  static int wrapInt(int val, int min, int max) {
    return wrapDouble(val.toDouble(), min.toDouble(), max.toDouble()).toInt();
  }


}