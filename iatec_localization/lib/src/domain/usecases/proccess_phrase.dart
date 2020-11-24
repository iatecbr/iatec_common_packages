import 'package:dartz/dartz.dart';
import 'package:iatec_localization/src/domain/entities/localized_phrase.dart';
import 'package:iatec_localization/src/domain/errors/errors.dart';

abstract class ProccessValue {
  Either<LocalizationFailure, String> call(
    String key, {
    String defaultValue,
    List<String> arguments,
    LocalizedPhrase localizedPhrase,
  });
}

class ProccessValueImpl implements ProccessValue {
  ProccessValueImpl();

  @override
  Either<LocalizationFailure, String> call(
    String key, {
    String defaultValue,
    List<String> arguments,
    LocalizedPhrase localizedPhrase,
  }) {
    assert(key != null);

    if (localizedPhrase?.phrases == null && defaultValue != null) {
      return Right(_interpolateValue(defaultValue, arguments));
    } else if (localizedPhrase?.phrases == null && defaultValue == null) {
      return Left(ProccessPhraseError('not found phrase'));
    }

    if (localizedPhrase.phrases.containsKey(key)) {
      return Right(_interpolateValue(localizedPhrase.phrases[key], arguments));
    } else if (defaultValue != null && defaultValue.isNotEmpty) {
      return Right(_interpolateValue(defaultValue, arguments));
    } else {
      return Left(ProccessPhraseError('not found phrase'));
    }
  }

  String _interpolateValue(String value, List<String> arguments) {
    final length = arguments?.length ?? 0;
    if (!value.contains('%s') || length == 0) {
      return value;
    }

    for (var i = 0; i < length; i++) {
      value = value.replaceFirst('%s', arguments[i]);
    }
    return value;
  }
}
