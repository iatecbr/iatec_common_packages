import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iatec_authentication_core/iatec_authentication_core.dart';
import 'package:iatec_authentication_core/src/domain/repositories/link_account_repository.dart';
import 'package:iatec_authentication_core/src/domain/usecases/unlink_account.dart';
import 'package:mockito/mockito.dart';

class LinkAccountRepositoryMock extends Mock implements LinkAccountRepository {}

void main() {
  LinkAccountRepository repository;
  UnLinkAccount usecase;
  setUpAll(() {
    repository = LinkAccountRepositoryMock();
    usecase = UnLinkAccountImpl(repository: repository);
  });

  test('should do unlink account', () async {
    when(repository.unlinkAccount(ProviderLogin.google))
        .thenAnswer((_) async => const Right(LoggedUser()));
    final result = await usecase(ProviderLogin.google);
    expect(result | null, isA<LoggedUser>());
  });
}
