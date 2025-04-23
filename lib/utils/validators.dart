//name
class NameException implements Exception {
  final String message;
  NameException({required this.message});

  @override
  String toString() => 'NameException: $message';
}

//term and condition
class TermException implements Exception {
  final String message;
  TermException({required this.message});

  @override
  String toString() => 'TermException: $message';
}
