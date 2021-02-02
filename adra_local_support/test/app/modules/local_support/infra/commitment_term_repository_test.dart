import 'package:adra_local_support/modules/local_support/domain/entities/local_category.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/local_support/local_support.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/national_support.dart';
import 'package:adra_local_support/modules/local_support/domain/repositories/local_support_repository.dart';
import 'package:adra_local_support/modules/local_support/external/models/local_category_model.dart';
import 'package:adra_local_support/modules/local_support/external/models/local_support/country_local_support_model.dart';
import 'package:adra_local_support/modules/local_support/external/models/local_support/local_support_model.dart';
import 'package:adra_local_support/modules/local_support/external/models/local_support/locality_local_support_model.dart';
import 'package:adra_local_support/modules/local_support/external/models/national_support_model.dart';
import 'package:adra_local_support/modules/local_support/infra/data_sources/local_support_data_source.dart';
import 'package:adra_local_support/modules/local_support/infra/repositories/local_support_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LocalSupportDataSourceMock extends Mock
    implements LocalSupportDataSource {}

void main() {
  LocalSupportDataSource dataSource = LocalSupportDataSourceMock();
  LocalSupportRepository repository;
  setUp(() {});
  group('UseCase LocalSupportRepository getLocalSupports Test', () {
    test('Test parse Model', () async {
      when(
        dataSource.getLocalSupports(
          any,
          any,
          categoriesId: anyNamed('categoriesId'),
          filter: anyNamed('filter'),
        ),
      ).thenAnswer((_) async => [
            LocalSupportModel(
                1,
                'name',
                LocalityLocalSupportModel(
                  1,
                  CountryLocalSupportModel(1, 'Description', 'short name'),
                  'state',
                  'city',
                  'stateAcronym',
                ),
                LocalCategoryModel(1, 'desc', false),
                'address',
                'complement',
                'neighborhood',
                'zipCode',
                1,
                2,
                3,
                true),
          ]);

      repository = LocalSupportRepositoryImpl(dataSource);
      var featureMessage = await repository.getLocalSupports(1, 1, '', []);

      expect(featureMessage | null, isInstanceOf<List<LocalSupport>>());
    });
  });

  group('UseCase LocalSupportRepository getLocalCategories Test', () {
    test('Test parse Model', () async {
      when(dataSource.getLocalCategories()).thenAnswer((_) async => [
            LocalCategoryModel(
              1,
              'descricao',
              true,
            ),
          ]);

      repository = LocalSupportRepositoryImpl(dataSource);
      var featureMessage = await repository.getLocalCategories();

      expect(featureMessage | null, isInstanceOf<List<LocalCategory>>());
    });
  });

  group('UseCase LocalSupportRepository getNationalSupports Test', () {
    test('Test parse Model', () async {
      when(dataSource.getNationalSupports(any)).thenAnswer((_) async => [
            NationalSupportModel(
              1,
              1,
              'Mensagem lembrando os protocolos ou sendo de ânimo para o vulnerável',
              'Title',
              false,
            ),
          ]);

      repository = LocalSupportRepositoryImpl(dataSource);
      var featureMessage = await repository.getNationalSupports('1');

      expect(featureMessage | null, isInstanceOf<List<NationalSupport>>());
    });
  });
}
