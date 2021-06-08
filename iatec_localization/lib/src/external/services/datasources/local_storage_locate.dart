import 'dart:async';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iatec_localization/src/infra/datasources/cache_datasource.dart';

const _finallocalizationKey = '_finallocalizationKey';
const _finallocaleKey = '_finallocaleKey';

// ignore_for_file: implicit_dynamic_method, implicit_dynamic_parameter, strict_raw_type, return_of_invalid_type, invalid_assignment, argument_type_not_assignable
class LocalStorageLocate implements CacheDatasource {
  final _completer = Completer<Box>();
  LocalStorageLocate([bool isTest = false]) {
    if (isTest) {
      Hive.init('dbtest');
      Hive.openBox('localization').then((box) {
        _completer.complete(box);
      });
      return;
    }
    Hive.initFlutter('localization').then((value) async {
      final box = await Hive.openBox('localization');
      _completer.complete(box);
    });
  }

  @override
  Future<Map<String, String>> fetchCacheValue() async {
    Map<String, dynamic> map =
        (await _completer.future).get(_finallocalizationKey);
    return map.map<String, String>(
        (key, value) => MapEntry<String, String>(key, value));
  }

  @override
  Future<void> saveCache(Map<String, String> value) async {
    await (await _completer.future).put(_finallocalizationKey, value);
  }

  @override
  Future<void> saveLocale(String value) async {
    await (await _completer.future).put(_finallocaleKey, value);
  }

  @override
  Future<String> fetchLocale() async {
    return (await _completer.future).get(_finallocaleKey);
  }
}
