class MissingFieldException implements Exception {


  String fieldName;
  bool emptyIsNull;
  bool nullable;

  MissingFieldException(this.fieldName, this.emptyIsNull, this.nullable);

  String error() => "$fieldName was missing${nullable ? ", and emptyIsNull is $emptyIsNull!" : "!"}";


} 