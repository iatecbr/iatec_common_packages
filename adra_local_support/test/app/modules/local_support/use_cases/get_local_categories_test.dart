import 'package:adra_local_support/modules/local_support/domain/entities/local_category.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/local_support/local_support.dart';
import 'package:adra_local_support/modules/local_support/domain/erros/local_support_errors.dart';
import 'package:adra_local_support/modules/local_support/domain/repositories/local_support_repository.dart';
import 'package:adra_local_support/modules/local_support/domain/use_cases/get_local_categories.dart';
import 'package:adra_local_support/modules/local_support/domain/use_cases/get_local_supports.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LocalSupportRepositoryMock extends Mock
    implements LocalSupportRepository {}

void main() {
  LocalSupportRepository repository = LocalSupportRepositoryMock();
  setUp(() {});
  group('UseCase GetLocalCategories Test', () {
    test('Happy path', () async {
      when(repository.getLocalCategories()).thenAnswer(
        (_) async => Right([
          LocalCategory(
            1,
            'Mensagem lembrando os protocolos ou sendo de ânimo para o vulnerável',
            true,
          ),
        ]),
      );

      var categories = await GetLocalCategories(repository)();

      expect(categories | null, isInstanceOf<List<LocalCategory>>());
    });

    test('Test Failure parse Model', () async {
      when(repository.getLocalCategories()).thenAnswer(
        (_) async => Left(LocalSupportFailure(Exception('error'))),
      );

      var featureMessage = await GetLocalCategories(repository)();

      expect(featureMessage.fold(id, id), isA<LocalSupportFailure>());
    });
  });
}
