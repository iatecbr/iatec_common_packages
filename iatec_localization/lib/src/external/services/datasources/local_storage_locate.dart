import 'dart:async';
import 'package:glutton/glutton.dart';
import 'package:iatec_localization/src/infra/datasources/cache_datasource.dart';

const finallocalizationKey = 'finallocalizationKey';
const finallocaleKey = 'finallocaleKey';

class LocalStorageLocate implements CacheDatasource {
  final bool isTest;
  LocalStorageLocate(this.isTest);

  @override
  Future<Map<String, String>> fetchCacheValue() async {
    Map<String, dynamic> map = await Glutton.vomit(finallocalizationKey);
    return map.map<String, String>(
        (key, value) => MapEntry<String, String>(key, value));
  }

  @override
  Future<void> saveCache(Map<String, String> value) async {
    await Glutton.eat(finallocalizationKey, value);
  }

  @override
  Future<void> saveLocale(String value) async {
    await Glutton.eat(finallocaleKey, value);
  }

  @override
  Future<String> fetchLocale() async {
    return await Glutton.vomit(finallocaleKey);
  }
}
