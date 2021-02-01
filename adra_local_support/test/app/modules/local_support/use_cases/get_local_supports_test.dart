import 'package:adra_local_support/modules/local_support/domain/entities/local_category.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/local_support/country_local_support.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/local_support/local_support.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/local_support/locality_local_support.dart';
import 'package:adra_local_support/modules/local_support/domain/erros/local_support_errors.dart';
import 'package:adra_local_support/modules/local_support/domain/repositories/local_support_repository.dart';
import 'package:adra_local_support/modules/local_support/domain/use_cases/get_local_supports.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LocalSupportRepositoryMock extends Mock
    implements LocalSupportRepository {}

void main() {
  LocalSupportRepository repository = LocalSupportRepositoryMock();
  setUp(() {});
  group('UseCase GetFeatureMessage Test', () {
    test('Happy path', () async {
      when(repository.getLocalSupports(any, any, any, any)).thenAnswer(
        (_) async => Right([
          LocalSupport(
              1,
              'name',
              LocalityLocalSupport(
                1,
                CountryLocalSupport(1, 'Description', 'short name'),
                'state',
                'city',
                'stateAcronym',
              ),
              LocalCategory(1, 'desc', false),
              'address',
              'complement',
              'neighborhood',
              'zipCode',
              1,
              2,
              3,
              true),
        ]),
      );

      var featureMessage = await GetLocalSupports(repository)(1, 2);

      expect(featureMessage | null, isInstanceOf<List<LocalSupport>>());
    });

    test('Test Failure parse Model', () async {
      when(repository.getLocalSupports(any, any, any, any)).thenAnswer(
        (_) async => Left(LocalSupportFailure(Exception('error'))),
      );

      var featureMessage = await GetLocalSupports(repository)(1, 2);

      expect(featureMessage.fold(id, id), isA<LocalSupportFailure>());
    });
  });
}
