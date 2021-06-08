import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:iatec_localization/src/domain/repositories/localization_repository.dart';
import 'package:iatec_localization/src/domain/usecases/get_current_locale.dart';
import 'package:iatec_localization/src/domain/usecases/init_i18n_values.dart';
import 'package:iatec_localization/src/domain/usecases/proccess_phrase.dart';
import 'package:iatec_localization/src/external/services/connection_check.dart';
import 'package:iatec_localization/src/external/services/datasources/api_localization.dart';
import 'package:iatec_localization/src/external/services/datasources/local_storage_locate.dart';
import 'package:iatec_localization/src/infra/datasources/cache_datasource.dart';
import 'package:iatec_localization/src/infra/datasources/localization_datasource.dart';
import 'package:iatec_localization/src/infra/repositories/localization_repository.dart';
import 'package:iatec_localization/src/infra/services/connection_check.dart';
import 'package:kiwi/kiwi.dart';

final _localizationModule = KiwiContainer.scoped()
  ..registerFactory<GetCurrentLocale>((s) => GetCurrentLocaleImpl(s()))
  ..registerFactory<ProccessValue>((s) => ProccessValueImpl())
  ..registerFactory<Dio>((s) => Dio())
  ..registerFactory<Initi18nValues>((s) => Initi18nValuesImpl(s()))
  ..registerFactory<LocalizationDatasource>((s) => ApiLocalization(s()))
  ..registerFactory<LocalizationRepository>((s) => LocalizationRepositoryImpl(
      cacheDatasource: s(), connectionCheck: s(), localizationDatasource: s()))
  ..registerFactory<CacheDatasource>((s) => LocalStorageLocate(s()))
  ..registerFactory<ConnectionCheck>((s) => ConnectionCheckImpl())
  ..registerInstance(false); //is test

T resolve<T>() => _localizationModule<T>();

@visibleForTesting
void changeBind<T>(T register) {
  _localizationModule.unregister<T>();
  _localizationModule.registerInstance<T>(register);
}
