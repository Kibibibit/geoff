///Returned when `ModelUtils` tries to get a field that does not exist
class MissingFieldException implements Exception {

  /// Which field had the error
  final String fieldName;

  /// Whether or not an empty string is treated as null or not
  final bool emptyIsNull;

  /// Whether or not the field is nullable
  final bool nullable;

  /// The message with the error
  final String message;
  MissingFieldException(this.fieldName, this.emptyIsNull, this.nullable) : 
  message = "$fieldName was missing${nullable ? ", and emptyIsNull is $emptyIsNull!" : "!"}";

  @override
  String toString() => message;

  



} 