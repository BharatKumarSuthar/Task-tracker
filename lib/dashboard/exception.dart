class FillData implements Exception {
  final String message;
  FillData({required this.message});

  @override
  String toString() => 'NameException: $message';
}
