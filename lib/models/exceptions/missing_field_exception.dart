///Returned when `ModelUtils` tries to get a field that does not exist
class MissingFieldException implements Exception {

  final String fieldName;
  final bool emptyIsNull;
  final bool nullable;
  final String message;
  MissingFieldException(this.fieldName, this.emptyIsNull, this.nullable) : 
  message = "$fieldName was missing${nullable ? ", and emptyIsNull is $emptyIsNull!" : "!"}";

  @override
  String toString() => message;

  



} 