import 'package:flutter/foundation.dart';

class LocalizedPhrase {
  final String locale;
  final Map<String, String> phrases;

  const LocalizedPhrase({this.locale, @required this.phrases});
}
