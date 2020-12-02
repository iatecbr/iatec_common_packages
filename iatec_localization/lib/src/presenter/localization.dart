import 'package:flutter/material.dart';
import 'package:iatec_localization/src/domain/entities/localized_phrase.dart';
import 'package:iatec_localization/src/domain/usecases/get_current_locale.dart';
import 'package:iatec_localization/src/domain/usecases/init_i18n_values.dart';
import 'localization_module.dart' as module;

class Localization {
  static bool _isInitialized = false;
  static bool get isInitialized => _isInitialized;
  static LocalizedPhrase localizedPhrase;
  static String currentLocale;

  static Future<void> init(
      {@required String locate, @required String url}) async {
    var currentLocaleUseCase = module.resolve<GetCurrentLocale>();

    var currentLocaleResult = await currentLocaleUseCase();

    await currentLocaleResult.fold(
      (l) => _init(url, locate),
      (r) => _init(url, locate ?? r),
    );
  }

  static Future<void> _init(String url, String locale) async {
    currentLocale = locale;
    final usecase = module.resolve<Initi18nValues>();
    final result = await usecase(locale: locale, url: url);
    result.fold(print, (r) => localizedPhrase = r);
    _isInitialized = true;
  }
}
