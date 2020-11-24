import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:iatec_localization/src/domain/entities/localized_phrase.dart';
import 'package:iatec_localization/src/domain/errors/errors.dart';
import 'package:iatec_localization/src/domain/repositories/localization_repository.dart';
import 'package:iatec_localization/src/infra/datasources/cache_datasource.dart';
import 'package:iatec_localization/src/infra/datasources/localization_datasource.dart';
import 'package:iatec_localization/src/infra/services/connection_check.dart';

class LocalizationRepositoryImpl implements LocalizationRepository {
  final ConnectionCheck connectionCheck;
  final LocalizationDatasource localizationDatasource;
  final CacheDatasource cacheDatasource;

  LocalizationRepositoryImpl({
    @required this.connectionCheck,
    @required this.localizationDatasource,
    @required this.cacheDatasource,
  });

  @override
  Future<Either<LocalizationFailure, String>> fetchLocale() async {
    try {
      final result = await cacheDatasource.fetchLocale();
      return Right(result);
    } catch (e) {
      return Left(InitPhraseError('Datasource Error'));
    }
  }

  Future<Either<LocalizationFailure, LocalizedPhrase>> _fromApi(
      String url, String locate) async {
    try {
      final result =
          await localizationDatasource.fetchLocalization(url, locate);
      await _saveCache(result, locate);
      final localization = LocalizedPhrase(phrases: result);
      return Right(localization);
    } on ApiPhraseError {
      final result = await _fromCache();
      return result.leftMap((l) => ApiPhraseError('Api and cache error'));
    } catch (e) {
      return Left(InitPhraseError('Datasource Error'));
    }
  }

  Future<Either<LocalizationFailure, LocalizedPhrase>> _fromCache() async {
    try {
      final result = await cacheDatasource.fetchCacheValue();
      final localization = LocalizedPhrase(phrases: result);
      return Right(localization);
    } catch (e) {
      return Left(InitPhraseError('Cache Retrive Error'));
    }
  }

  Future<void> _saveCache(Map<String, String> result, String locale) async {
    try {
      await cacheDatasource.saveCache(result);
      await cacheDatasource.saveLocale(locale);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<Either<LocalizationFailure, LocalizedPhrase>> fetchLocalization(
      {String url, String locale}) async {
    bool isConnected;
    try {
      isConnected = await connectionCheck.isConnected;
    } catch (e) {
      return Left(InitPhraseError('Check Connection Error'));
    }
    if (isConnected) {
      return _fromApi(url, locale);
    } else {
      return _fromCache();
    }
  }
}
