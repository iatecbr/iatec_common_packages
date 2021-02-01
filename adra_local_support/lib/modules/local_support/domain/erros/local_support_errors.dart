class LocalSupportFailure implements Exception {
  final String _message;
  final Exception innerException;

  LocalSupportFailure(this.innerException, {String message})
      : _message = message;

  String get message =>
      _message ?? innerException.toString()?.replaceAll('Exception: ', '');
}
