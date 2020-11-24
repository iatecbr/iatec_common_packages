abstract class LocalizationFailure implements Exception {
  final String message;

  const LocalizationFailure(this.message);

  @override
  String toString() {
    return '${runtimeType.toString()}: $message';
  }
}

class ProccessPhraseError extends LocalizationFailure {
  ProccessPhraseError(String message) : super(message);
}

class ApiPhraseError extends LocalizationFailure {
  ApiPhraseError(String message) : super(message);
}

class InitPhraseError extends LocalizationFailure {
  InitPhraseError(String message) : super(message);
}
