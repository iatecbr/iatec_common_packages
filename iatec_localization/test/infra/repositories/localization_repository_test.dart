import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iatec_localization/src/domain/entities/localized_phrase.dart';
import 'package:iatec_localization/src/domain/errors/errors.dart';
import 'package:iatec_localization/src/infra/datasources/cache_datasource.dart';
import 'package:iatec_localization/src/infra/datasources/localization_datasource.dart';
import 'package:iatec_localization/src/infra/repositories/localization_repository.dart';
import 'package:iatec_localization/src/infra/services/connection_check.dart';
import 'package:mockito/mockito.dart';

class ConnectionCheckMock extends Mock implements ConnectionCheck {}

class LocalizationDatasourceMock extends Mock
    implements LocalizationDatasource {}

class CacheDatasourceMock extends Mock implements CacheDatasource {
  Map<String, String> savedCache;

  @override
  Future<void> saveCache(Map<String, String> value) async {
    savedCache = value;
  }
}

void main() {
  final connectionCheck = ConnectionCheckMock();
  final datasource = LocalizationDatasourceMock();
  final cache = CacheDatasourceMock();
  final map = <String, String>{
    'test-one': 'Test One',
    'test-two': 'Test Two',
    'test-three': 'Test Three',
  };

  final repository = LocalizationRepositoryImpl(
      cacheDatasource: cache,
      connectionCheck: connectionCheck,
      localizationDatasource: datasource);

  group('is Online', () {
    test('should fetch localization map from Datasource', () async {
      when(connectionCheck.isConnected).thenAnswer((_) async => true);
      when(datasource.fetchLocalization(any, any)).thenAnswer((_) async => map);
      final result =
          await repository.fetchLocalization(url: 'url', locale: 'pt-BR');
      final localization = result | null;
      expect(localization, isA<LocalizedPhrase>());
      expect(localization.phrases, map);
      expect(cache.savedCache, map);
    });

    test('should throw InitPhraseError then datasource is failured', () async {
      when(connectionCheck.isConnected).thenAnswer((_) async => true);
      when(datasource.fetchLocalization(any, any))
          .thenThrow((dynamic _) async => Exception());
      final result =
          await repository.fetchLocalization(url: 'url', locale: 'pt-BR');
      expect(result.fold(id, id), isA<InitPhraseError>());
    });
    test(
        'should try catch cache values when throw ApiPhraseError in datasource',
        () async {
      when(connectionCheck.isConnected).thenAnswer((_) async => true);
      when(cache.fetchCacheValue()).thenAnswer((_) async => map);
      when(datasource.fetchLocalization(any, any))
          .thenThrow(ApiPhraseError(''));
      final result =
          await repository.fetchLocalization(url: 'url', locale: 'pt-BR');
      final localization = result | null;
      expect(localization, isA<LocalizedPhrase>());
      expect(localization.phrases, map);
    });
    test('should throw ApiPhraseError when fail cache and datasource',
        () async {
      when(connectionCheck.isConnected).thenAnswer((_) async => true);
      when(cache.fetchCacheValue()).thenThrow(Exception());
      when(datasource.fetchLocalization(any, any))
          .thenThrow(ApiPhraseError(''));
      final result =
          await repository.fetchLocalization(url: 'url', locale: 'pt-BR');
      expect(result.fold(id, id), isA<ApiPhraseError>());
    });
  });
  group('is Offline', () {
    test('should fetch localization map from cache', () async {
      when(connectionCheck.isConnected).thenAnswer((_) async => false);
      cache.savedCache = map;
      when(cache.fetchCacheValue()).thenAnswer((_) async => map);
      final result =
          await repository.fetchLocalization(url: 'url', locale: 'pt-BR');
      final localization = result | null;
      expect(localization, isA<LocalizedPhrase>());
      expect(localization.phrases, map);
    });
    test('should throw InitPhraseError then datasource is failured', () async {
      when(connectionCheck.isConnected).thenAnswer((_) async => false);
      when(cache.fetchCacheValue()).thenThrow((dynamic _) async => Exception());
      final result =
          await repository.fetchLocalization(url: 'url', locale: 'pt-BR');
      expect(result.fold(id, id), isA<InitPhraseError>());
    });
  });

  test('should throw InitPhraseError then Check Connection is failured',
      () async {
    when(connectionCheck.isConnected).thenThrow(Exception());

    final result =
        await repository.fetchLocalization(url: 'url', locale: 'pt-BR');
    expect(result.fold(id, id), isA<InitPhraseError>());
  });
}
