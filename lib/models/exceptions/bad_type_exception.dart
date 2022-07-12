///Thrown when `ModelUtils` tries to get a field and the type is not matched
class BadTypeException implements Exception {

  /// Which field had the error
  final String field;

  /// What type was expected to be returned
  final Type expected;

  /// What type was actually returned
  final Type got;

  /// The message that the error displays
  final String message;

  BadTypeException(this.field, this.expected, this.got) :
  message = "Field '$field' expected ${expected.toString()} but got ${got.toString()}";

  @override
  String toString() => message;
} 