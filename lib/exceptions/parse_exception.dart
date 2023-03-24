class ParseException implements Exception {
  String message;

  ParseException({
    this.message = "",
  });

  @override
  String toString() {
    if (message.isEmpty) return "ParseException";
    return "ParseException: $message";
  }
}
