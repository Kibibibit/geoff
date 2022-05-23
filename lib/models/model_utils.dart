
import 'package:geoff/models/exceptions/bad_type_exception.dart';
import 'package:geoff/models/exceptions/missing_field_exception.dart';
/// A collection of methods for helping convert models to and from `Map`s
abstract class ModelUtils {

  ModelUtils._();

  /// Gets a field out of a `Map` of the given type.
  static K getField<K>(Map<String, dynamic> map, String fieldName, [bool emptyIsNull = true]) {

    if (map.containsKey(fieldName)) {

      if (map[fieldName] is K) {
        return map[fieldName] as K;
      } 
      throw BadTypeException(fieldName, K.runtimeType, map[fieldName].runtimeType);

    } else {
      if (null is K && emptyIsNull) {
        return null as K;
      }
      throw MissingFieldException(fieldName, emptyIsNull, null is K);
    }

  }



}