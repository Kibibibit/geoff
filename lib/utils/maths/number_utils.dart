

import 'dart:math';

class NumberUtils {

  /// Rounds a double to have [places] places
  static double roundToPlaces(double val, int places) {

    val *= pow(10, places);

    double out = val.roundToDouble();

    return out/pow(10,places);



  }



}