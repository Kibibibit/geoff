class BadTypeException implements Exception {

  final String field;
  final Type expected;
  final Type got;
  final String message;

  BadTypeException(this.field, this.expected, this.got) :
  message = "Field '$field' expected ${expected.toString()} but got ${got.toString()}";

  @override
  String toString() => message;
} 