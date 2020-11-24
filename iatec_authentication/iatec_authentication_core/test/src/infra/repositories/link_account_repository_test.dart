import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iatec_authentication_core/iatec_authentication_core.dart';
import 'package:iatec_authentication_core/src/infra/datasource/auth_datasource.dart';
import 'package:iatec_authentication_core/src/infra/repositories/link_account_repository.dart';
import 'package:mockito/mockito.dart';

class AuthDatasourceMock extends Mock implements AuthDatasource {}

void main() {
  final datasourceMock = AuthDatasourceMock();
  final repository = LinkAccountRepositoryImpl(datasource: datasourceMock);

  test('should do link account', () async {
    when(datasourceMock.linkAccount(ProviderLogin.google))
        .thenAnswer((_) async => LoggedUser());
    final result = await repository.linkAccount(ProviderLogin.google);
    expect(result | null, isA<LoggedUser>());
  });

  test('should throw AuthFailed file', () async {
    when(datasourceMock.linkAccount(ProviderLogin.google))
        .thenThrow(CredentialsError(message: 'Test'));
    final result = await repository.linkAccount(ProviderLogin.google);
    expect(result.fold(id, id), isA<CredentialsError>());
  });

  test('should throw unknown error return LinkAccountError', () async {
    when(datasourceMock.linkAccount(ProviderLogin.google))
        .thenThrow(Exception());
    final result = await repository.linkAccount(ProviderLogin.google);
    expect(result.fold(id, id), isA<LinkAccountError>());
  });
}
