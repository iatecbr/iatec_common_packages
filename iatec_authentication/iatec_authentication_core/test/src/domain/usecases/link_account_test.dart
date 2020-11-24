import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iatec_authentication_core/iatec_authentication_core.dart';
import 'package:iatec_authentication_core/src/domain/repositories/link_account_repository.dart';
import 'package:iatec_authentication_core/src/domain/usecases/link_account.dart';
import 'package:mockito/mockito.dart';

class LinkAccountRepositoryMock extends Mock implements LinkAccountRepository {}

void main() {
  LinkAccountRepository repository;
  LinkAccount usecase;
  setUpAll(() {
    repository = LinkAccountRepositoryMock();
    usecase = LinkAccountImpl(repository: repository);
  });

  test('should do link account', () async {
    when(repository.linkAccount(ProviderLogin.google))
        .thenAnswer((_) async => const Right(LoggedUser()));
    final result = await usecase(ProviderLogin.google);
    expect(result | null, isA<LoggedUser>());
  });
}
