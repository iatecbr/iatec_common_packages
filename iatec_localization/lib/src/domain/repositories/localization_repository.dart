import 'package:dartz/dartz.dart';
import 'package:iatec_localization/src/domain/entities/localized_phrase.dart';
import 'package:iatec_localization/src/domain/errors/errors.dart';

abstract class LocalizationRepository {
  Future<Either<LocalizationFailure, LocalizedPhrase>> fetchLocalization({
    String url,
    String locale,
  });

  Future<Either<LocalizationFailure, String>> fetchLocale();
}
