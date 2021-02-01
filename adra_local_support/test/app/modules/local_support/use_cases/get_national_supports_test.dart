import 'package:adra_local_support/modules/local_support/domain/entities/local_support/local_support.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/national_support.dart';
import 'package:adra_local_support/modules/local_support/domain/erros/local_support_errors.dart';
import 'package:adra_local_support/modules/local_support/domain/repositories/local_support_repository.dart';
import 'package:adra_local_support/modules/local_support/domain/use_cases/get_national_supports.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LocalSupportRepositoryMock extends Mock
    implements LocalSupportRepository {}

void main() {
  LocalSupportRepository repository = LocalSupportRepositoryMock();
  setUp(() {});
  group('UseCase GetNationalSupports Test', () {
    test('Happy path', () async {
      when(repository.getNationalSupports(any)).thenAnswer(
        (_) async => Right([
          NationalSupport(
            1,
            1,
            'Mensagem lembrando os protocolos ou sendo de ânimo para o vulnerável',
            'Title',
            false,
          ),
        ]),
      );

      var featureMessage = await GetNationalSupports(repository)('1');

      expect(featureMessage | null, isInstanceOf<List<NationalSupport>>());
    });

    test('Test Failure parse Model', () async {
      when(repository.getNationalSupports(any)).thenAnswer(
        (_) async => Left(LocalSupportFailure(Exception('error'))),
      );

      var featureMessage = await GetNationalSupports(repository)('1');

      expect(featureMessage.fold(id, id), isA<LocalSupportFailure>());
    });
  });
}
