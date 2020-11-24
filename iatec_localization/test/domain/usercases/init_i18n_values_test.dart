import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iatec_localization/src/domain/entities/localized_phrase.dart';
import 'package:iatec_localization/src/domain/repositories/localization_repository.dart';
import 'package:iatec_localization/src/domain/usecases/init_i18n_values.dart';
import 'package:mockito/mockito.dart';

class LocalizationRepositoryMock extends Mock
    implements LocalizationRepository {}

void main() {
  LocalizationRepository repository;
  Initi18nValues usecase;
  setUpAll(() {
    repository = LocalizationRepositoryMock();
    usecase = Initi18nValuesImpl(repository);
  });
  test('should retrive localizatad phrases ', () async {
    when(repository.fetchLocalization(
            url: anyNamed('url'), locale: anyNamed('locale')))
        .thenAnswer((_) async => Right(LocalizedPhrase(phrases: {})));
    final result = await usecase.call(url: 'url', locale: 'pt-BR');
    expect(result | null, isA<LocalizedPhrase>());
  });
}
