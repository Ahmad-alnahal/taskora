extension ExceptionMessage on Object {
  String get userMessage {
    final self = this;


    if (self is FormatException) return 'Invalid data format.';
    if (self is UnsupportedError) return 'Unsupported operation.';
    if (self is ArgumentError) return 'Invalid input.';


    final text = self.toString();


    if (text.startsWith('Exception: ')) {
      return text.replaceFirst('Exception: ', '').trim();
    }

    return text.trim().isEmpty ? 'Something went wrong.' : text.trim();
  }
}
