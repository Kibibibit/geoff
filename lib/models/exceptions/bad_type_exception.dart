class BadTypeException implements Exception {

  String field;
  Type expected;
  Type got;

  BadTypeException(this.field, this.expected, this.got);

  String error() => "Field '$field' expected ${expected.toString()} but got ${got.toString()}";
} 