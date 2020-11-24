import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:iatec_localization/src/domain/entities/localized_phrase.dart';
import 'package:iatec_localization/src/domain/errors/errors.dart';
import 'package:iatec_localization/src/domain/repositories/localization_repository.dart';

abstract class Initi18nValues {
  Future<Either<LocalizationFailure, LocalizedPhrase>> call({
    @required String url,
    @required String locale,
  });
}

class Initi18nValuesImpl implements Initi18nValues {
  final LocalizationRepository repository;

  Initi18nValuesImpl(this.repository);

  @override
  Future<Either<LocalizationFailure, LocalizedPhrase>> call({
    @required String url,
    @required String locale,
  }) {
    assert(locale != null);
    assert(url != null);
    return repository.fetchLocalization(
        locale: locale.replaceAll('_', '-'), url: url);
  }
}
